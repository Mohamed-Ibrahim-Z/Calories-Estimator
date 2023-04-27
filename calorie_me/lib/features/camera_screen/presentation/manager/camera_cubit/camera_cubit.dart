import 'dart:io';
import 'dart:typed_data';
import 'package:calorie_me/core/constants/constants.dart';
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

part 'camera_states.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitial());

  static CameraCubit get(context) => BlocProvider.of(context);
  File image = File('');

  double creditCardWidth = 36.w,
      creditCardHeight = 13.h,
      creditCardPixels = 0.0;

  void pickPhotoFromCameraPreview(XFile photo) {
    image = File(photo.path);
    emit(ImagePickedSuccessState());
  }

  Uint8List imageBytes = Uint8List(0);

  void pickImage({
    required bool isCamera,
  }) {
    ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) async {
      if (value == null) return;
      image = File(value.path);
      imageBytes = await image.readAsBytes();
      emit(ImagePickedSuccessState());
    });
  }

  String imageUrl = "";
  final fireStorage = FirebaseStorage.instance;
  Uint8List imageCutBytes = Uint8List(0);

  void cutImage() {
    emit(UploadImageLoadingState());
    Image decodedImage = decodeImage(image.readAsBytesSync())!;
    final width = decodedImage.width;
    final height = decodedImage.height;

    for (var y = (height * 0.75).floor(); y < height; y++) {
      for (var x = 0; x < width; x++) {
        decodedImage.setPixelRgba(x, y, 0, 0, 0, 255);
      }
    }
    imageCutBytes = encodePng(decodedImage);
    creditCardPixels = creditCardWidth * creditCardHeight;
    predictImage();
  }

  void uploadFullImage() {
    emit(UploadImageLoadingState());
    fireStorage
        .ref()
        .child('meals/${Uri
        .file(image.path)
        .pathSegments
        .last}')
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
    MealModel addMealModel = MealModel(
      dateTime: DateTime.now().toString(),
      ingredients: mealModel.ingredients,
      imageUrl: imageUrl,
      mealCalories: mealModel.mealCalories,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .add(addMealModel.toMap())
        .then((value) {
      emit(AddMealSuccessState());
    }).catchError((error) {
      emit(AddMealErrorState());
    });
  }

  FormData formData = FormData.fromMap({});
  String errorMessage = "";
  int numOfTabs = 0;

  bool doubleTapped() {
    numOfTabs++;
    if (numOfTabs < 2) {
      emit(DoubleTapState());
    } else if (numOfTabs == 2) {
      numOfTabs = 0;
      // cancel request if it's still loading
      if (mealModel.ingredients.isEmpty) {
        cancelToken.cancel();
      }
      return true;
    }
    return false;
  }

  CancelToken cancelToken = CancelToken();

  void predictImage() async {
    cancelToken = CancelToken();
    emit(PredictImageLoadingState());
    print("Predicting Image");
    !newVersion
        ? formData = FormData.fromMap({
      "img_bytes": MultipartFile.fromBytes(imageCutBytes,
          filename: Uri
              .file(image.path)
              .pathSegments
              .last),
      "ref_pixels": creditCardPixels.round(),
    })
        : formData = FormData.fromMap({
      "img_bytes": MultipartFile.fromBytes(imageBytes,
          filename: Uri
              .file(image.path)
              .pathSegments
              .last),
    });
    try {
      await DioHelper.postData(
          endPoint: !newVersion ? "/CalorieMe-V1" : "/CalorieMe-V2",
          data: formData,
          cancelToken: cancelToken)
          .then((value) {
        // if (value.data['error'] != null) {
        //   print("HEREEEE");
        //   print(value.data['error']);
        //   emit(PredictImageErrorState());
        // }
        mealModel = MealModel.fromJson(value.data);
        fillTableRows();
        emit(PredictImageSuccessState());
      });
    } on DioError catch (error) {
      handleAPIError(error);
      emit(PredictImageErrorState());
    }
  }

  void handleAPIError(DioError error) {
    print(error.toString());
    switch (error.type) {
      case DioErrorType.sendTimeout:
        errorMessage = "Send Timeout";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive Timeout";
        break;
      case DioErrorType.cancel:
        errorMessage = "Request Cancelled";
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = "Connection Timeout";
        break;
      case DioErrorType.badResponse:
        errorMessage = "Bad Response";
        break;
      case DioErrorType.connectionError:
        errorMessage = "Connection Error";
        break;
      case DioErrorType.badCertificate:
        errorMessage = "Bad Certificate";
        break;
      default:
        errorMessage = error.toString();
        break;
    }
  }

  double cameraHeight = 72.h;

  List<material.TableRow> tableRows = [];
  dynamic totalMealCalories = 0;

  void fillTableRows() {
    if (tableRows.isEmpty) {
      totalMealCalories = 0;
      mealModel.ingredients.forEach((key, value) {
        tableRows.add(tableRow(ingredient: key, calories: value));
        totalMealCalories += value;
      });
      tableRows.add(
          tableRow(ingredient: "Total Calories", calories: totalMealCalories));
    }
    // emit(FillTableSuccessState());
  }

  void clearTableRowsAndMealModel() {
    tableRows.clear();
    mealModel = MealModel(
      dateTime: '',
      ingredients: {},
      imageUrl: '',
    );
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
