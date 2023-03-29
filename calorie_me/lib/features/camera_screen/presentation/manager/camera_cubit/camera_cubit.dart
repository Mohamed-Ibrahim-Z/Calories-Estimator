import 'dart:io';
import 'dart:typed_data';
import 'package:calorie_me/constants.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../home_layout/data/models/meal_model.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);
  final ImagePicker cameraImagePicker = ImagePicker();
  dynamic imagePath;

  String? cameraImageUrl;

  void pickImageFromCamera(context) {
    cameraImagePicker
        .pickImage(
      source: ImageSource.camera,
    )
        .then((value) {
      if (value == null) return;
      imagePath = File(value.path);

      emit(CameraImagePickedSuccessState());
    });
  }

  void pickPhotoFromCamera(XFile photo) {
    imagePath = File(photo.path);
    splitImage();
    emit(CameraImagePickedSuccessState());
  }

  final ImagePicker galleryImagePicker = ImagePicker();
  String? galleryImageUrl;

  void pickImageFromGallery() {
    galleryImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      imagePath = File(value.path);
      splitImage();
      emit(GalleryImagePickedSuccessState());
    });
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

    // predictImage();
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .add(mealModel.toMap())
        .then((value) {
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
        mealsList.clear();
        for (var element in event.docs) {
          mealsList.add(MealModel.fromJson(element.data()));
        }
        emit(GetMealsSuccessState());
      });
    }
  }

  // void predictImage() {
  //   emit(PredictImageLoadingState());
  //   DioHelper.postData(endPoint: '/predict', data: {
  //     'image': imageInBytes,
  //   }).then((value) {
  //     print(value.data);
  //     emit(PredictImageSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(PredictImageErrorState());
  //   });
  // }

  Image? halfImage1;
  Image? halfImage2;
  Uint8List? foodImageBytes;
  Uint8List? creditCardImageBytes;

  // double linePosition = 54.h;
  double cameraHeight = 72.h;

  // void changeLinePosition(double position) {
  //   if (linePosition + position < 70.h && linePosition + position > 6.h) {
  //     linePosition += position;
  //     emit(ChangeLinePositionState());
  //   }
  // }

  void splitImage() {
    Image image = decodeImage(imagePath.readAsBytesSync())!;

    halfImage1 = copyCrop(image,
        x: 0, y: 0, width: image.width, height: 3 * image.height ~/ 4);
    halfImage2 = copyCrop(image,
        x: 0,
        y: 3 * image.height ~/ 4,
        width: image.width,
        height: image.height);

    foodImageBytes = encodeJpg(halfImage1!);
    creditCardImageBytes = encodeJpg(halfImage2!);

    FirebaseStorage.instance
        .ref()
        .child('meals/${DateTime.now()} FoodImage.jpg')
        .putData(foodImageBytes!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseStorage.instance
            .ref()
            .child('meals/${DateTime.now()} CreditCardImage.jpg')
            .putData(creditCardImageBytes!)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            // call api to predict

            emit(UploadImageSuccessState());
          }).catchError((error) {});
        });
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  bool flash = false;
  material.IconData flashIcon = material.Icons.flash_off;

  void toggleFlash(CameraController cameraController) {
    flash = !flash;
    cameraController.setFlashMode(flash ? FlashMode.torch : FlashMode.off);
    flashIcon = flash ? material.Icons.flash_on : material.Icons.flash_off;
    emit(ToggleFlashState());
  }
}
