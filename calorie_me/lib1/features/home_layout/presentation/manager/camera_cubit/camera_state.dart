part of 'camera_cubit.dart';

@immutable
abstract class CameraState {}

class CameraInitial extends CameraState {}
class CameraImagePickedSuccessState extends CameraState {}
class CameraImageClearSuccessState extends CameraState {}
class GalleryImagePickedSuccessState extends CameraState {}
class GalleryImageClearSuccessState extends CameraState {}
