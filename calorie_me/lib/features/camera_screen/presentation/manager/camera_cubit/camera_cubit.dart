import 'dart:io';
import 'dart:typed_data';
import 'package:calorie_me/constants.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/dio.dart';
import '../../../../image_details/data/models/meal_model.dart';
import '../../../../image_details/presentation/views/widgets/table_row.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);
  File image = File('');

  double creditCardWidth = 36.w,
      creditCardHeight = 13.h,
      creditCardPixels = 0.0;

  void pickPhotoFromCamera(XFile photo) {
    image = File(photo.path);
    convertImageToPng(photo);
    emit(CameraImagePickedSuccessState());
  }

  void convertImageToPng(XFile photo) {
    Uint8List bytes = image.readAsBytesSync();
    Image? decImage = decodeImage(bytes);
    Uint8List pngBytes = encodePng(decImage!);
    File pngFile = File(photo.path.replaceAll('.jpg', '.png'));
    image = pngFile..writeAsBytesSync(pngBytes);
  }

  final ImagePicker galleryImagePicker = ImagePicker();

  void pickImageFromGallery() {
    galleryImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      image = File(value.path);
      emit(GalleryImagePickedSuccessState());
    });
  }

  String? imageUrl;
  String? imageCutUrl;
  final fireStorage = FirebaseStorage.instance;

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

    fireStorage
        .ref()
        .child('meals/${Uri.file(image.path).pathSegments.last}')
        .putData(encodedImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageCutUrl = value;
        print(imageCutUrl);
        // predictImage();
        fillTableRows();
        emit(UploadImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void uploadFullImage() {
    emit(UploadImageLoadingState());
    fireStorage
        .ref()
        .child('meals/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        addMealToList();
        emit(UploadImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  MealModel mealModel = MealModel(
    dateTime: '',
    ingredients: {},
    imageUrl: '',
  );

  void addMealToList() {
    emit(AddMealLoadingState());
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

  void predictImage() async {
    emit(PredictImageLoadingState());

    creditCardPixels = creditCardWidth * creditCardHeight;
    FormData formData = FormData.fromMap({
      "img_link": imageCutUrl,
      "img_pixels": creditCardPixels.round(),
    });
    // print("Pixels ${creditCardPixels.round()}");
    DioHelper.postData(endPoint: "/CalorieMe", data: formData).then((value) {
      print(value.data);
      mealModel = MealModel.fromJson(value.data, imageUrl!);
      fillTableRows();
      emit(PredictImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PredictImageErrorState());
    });
  }

  double cameraHeight = 72.h;

  List<material.TableRow> tableRows = [];

  void fillTableRows() {
    tableRows.clear();
    // mealModel.ingredients.forEach((key, value) {
    //   tableRows.add(tableRow(ingredient: key, calories: value));
    // });
    for(int i = 0;i<3;i++)
      {
        tableRows.add(tableRow(ingredient: 'asdasdasdasd', calories: '123123'));
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
