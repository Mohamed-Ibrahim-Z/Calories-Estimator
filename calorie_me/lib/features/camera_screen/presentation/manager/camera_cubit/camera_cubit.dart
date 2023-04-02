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

import '../../../../../core/utils/dio.dart';
import '../../../../home_layout/data/models/meal_model.dart';
import '../../../../image_details/presentation/views/widgets/table_row.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);
  final ImagePicker cameraImagePicker = ImagePicker();
  File image = File('');

  String? cameraImageUrl;

  void pickImageFromCamera(context) {
    cameraImagePicker
        .pickImage(
      source: ImageSource.camera,
    )
        .then((value) {
      if (value == null) return;
      image = File(value.path);

      emit(CameraImagePickedSuccessState());
    });
  }

  double creditCardWidth = 36.w,
      creditCardHeight = 13.h,
      creditCardPixels = 0.0;

  void pickPhotoFromCamera(XFile photo) {
    image = File(photo.path);
    emit(CameraImagePickedSuccessState());
  }

  final ImagePicker galleryImagePicker = ImagePicker();
  String? galleryImageUrl;

  void pickImageFromGallery() {
    galleryImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      image = File(value.path);
      emit(GalleryImagePickedSuccessState());
    });
  }

  String? imageUrl;
  String? imageCutUrl;

  void uploadCutImage() {
    emit(UploadImageLoadingState());
    Image decodedImage = decodeImage(image.readAsBytesSync())!;
    final width = decodedImage.width;
    final height = decodedImage.height;

    for (var y = (height * 0.75).floor(); y < height; y++) {
      for (var x = 0; x < width; x++) {
        decodedImage.setPixelRgba(x, y, 0, 0, 0, 255);
      }
    }
    Uint8List encodedImage = encodeJpg(decodedImage);
    FirebaseStorage.instance
        .ref()
        .child('meals/${Uri.file(image.path).pathSegments.last}')
        .putData(encodedImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageCutUrl = value;
        // predictImage();
        emit(UploadImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void uploadFullImage() {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('meals/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
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

  MealModel? mealModel;

  void addMealToList() {
    emit(AddMealLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .add(mealModel!.toMap())
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
          mealsList.add(MealModel(
            ingredients: element.data()['ingredients'],
            calories: element.data()['calories'],
            imageUrl: element.data()['imageUrl'],
            dateTime: element.data()['dateTime'],
          ));
        }
        emit(GetMealsSuccessState());
      });
    }
  }

  void predictImage() {
    emit(PredictImageLoadingState());
    creditCardPixels = creditCardWidth * creditCardHeight;
    DioHelper.postData(endPoint: '/predict', data: {
      'image': imageCutUrl,
      'creditCardPixels': creditCardPixels,
    }).then((value) {
      print(value.data);
      mealModel = MealModel.fromJson(value.data);
      fillTableRows();
      emit(PredictImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PredictImageErrorState());
    });
  }

  Image? halfImage1;
  Image? halfImage2;
  Uint8List? foodImageBytes;
  Uint8List? creditCardImageBytes;

  double cameraHeight = 72.h;

  // void changeLinePosition(double position) {
  //   if (linePosition + position < 70.h && linePosition + position > 6.h) {
  //     linePosition += position;
  //     emit(ChangeLinePositionState());
  //   }
  // }

  // void splitImage() {
  //   Image image = decodeImage(imagePath.readAsBytesSync())!;
  //
  //   halfImage1 = copyCrop(image,
  //       x: 0, y: 0, width: image.width, height: 3 * image.height ~/ 4);
  //   halfImage2 = copyCrop(image,
  //       x: 0,
  //       y: 3 * image.height ~/ 4,
  //       width: image.width,
  //       height: image.height);
  //
  //   foodImageBytes = encodeJpg(halfImage1!);
  //   creditCardImageBytes = encodeJpg(halfImage2!);
  //
  //   FirebaseStorage.instance
  //       .ref()
  //       .child('meals/${DateTime.now()} FoodImage.jpg')
  //       .putData(foodImageBytes!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       FirebaseStorage.instance
  //           .ref()
  //           .child('meals/${DateTime.now()} CreditCardImage.jpg')
  //           .putData(creditCardImageBytes!)
  //           .then((value) {
  //         value.ref.getDownloadURL().then((value) {
  //           // call api to predict
  //
  //           emit(UploadImageSuccessState());
  //         }).catchError((error) {});
  //       });
  //     }).catchError((error) {});
  //   }).catchError((error) {
  //     emit(UploadImageErrorState());
  //   });
  // }

  List<material.TableRow> tableRows = [];

  void fillTableRows() {
    tableRows.clear();
    for (int i = 0; i < mealModel!.ingredients.length; i++) {
      tableRows.add(tableRow(
        ingredient: mealModel!.ingredients[i],
        calories: mealModel!.calories[i],
      ));
    }
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
