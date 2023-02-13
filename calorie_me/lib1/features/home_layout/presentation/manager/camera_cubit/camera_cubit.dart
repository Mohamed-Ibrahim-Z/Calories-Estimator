import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());
  static CameraCubit get(context) => BlocProvider.of(context);
  final ImagePicker cameraImagePicker = ImagePicker();
  File? cameraImagePath;

  void pickImageFromCamera() {
   cameraImagePicker.pickImage(source: ImageSource.camera).then((value)
   {
     cameraImagePath = File(value!.path);
     emit(CameraImagePickedSuccessState());
   });
  }
  void clearCameraImage() {
    cameraImagePath = null;
    emit(CameraImageClearSuccessState());
  }

  final ImagePicker galleryImagePicker = ImagePicker();
  File? galleryImagePath;

  void pickImageFromGallery() {
    galleryImagePicker.pickImage(source: ImageSource.gallery).then((value)
    {
      galleryImagePath = File(value!.path);
      emit(GalleryImagePickedSuccessState());
    });
  }
  void clearGalleryImage() {
    galleryImagePath = null;
    emit(GalleryImageClearSuccessState());
  }
}
