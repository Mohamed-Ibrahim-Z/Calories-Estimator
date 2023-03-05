import 'dart:io';

import 'package:calorie_me/constants.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/models/meal_model.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);
  final ImagePicker cameraImagePicker = ImagePicker();
  dynamic imagePath;

  String? cameraImageUrl;

  void pickImageFromCamera() {
    cameraImagePicker.pickImage(source: ImageSource.camera).then((value) {
      if (value == null) return;
      imagePath = File(value.path);
      emit(CameraImagePickedSuccessState());
    });
  }

  final ImagePicker galleryImagePicker = ImagePicker();
  String? galleryImageUrl;

  void pickImageFromGallery() {
    galleryImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      imagePath = File(value.path);
      emit(GalleryImagePickedSuccessState());
    });
  }

  void clearImagePaths() {
    imageUrl = null;
    imagePath = null;
    emit(ClearImagePathsSuccessState());
  }

  String? imageUrl;

  void uploadImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('meals/${Uri.file(imagePath!.path).pathSegments.last}')
        .putFile(imagePath)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        addMealToList();
        emit(UploadImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void addMealToList() {
    emit(AddMealLoadingState());
    MealModel mealModel = MealModel(
      title: 'meal name',
      calories: '0',
      imageUrl: imageUrl!,
      dateTime: DateTime.now().toString(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .add(mealModel.toMap())
        .then((value) {
      clearImagePaths();
      emit(AddMealSuccessState());
    }).catchError((error) {
      emit(AddMealErrorState());
    });
  }

  List<MealModel> mealsList = [];

  void getMealsList() {
    if (loggedUserID != null) {
      emit(GetMealsLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedUserID)
          .collection('meals')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        for (var element in event.docChanges) {
          mealsList.insert(0, MealModel.fromJson(element.doc.data()!));
        }
        emit(GetMealsSuccessState());
      });
    }
  }
}
