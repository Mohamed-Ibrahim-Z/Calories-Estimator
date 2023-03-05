part of 'camera_cubit.dart';

@immutable
abstract class CameraStates {}

class CameraInitial extends CameraStates {}
class CameraImagePickedSuccessState extends CameraStates {}
class CameraImageClearSuccessState extends CameraStates {}
class GalleryImagePickedSuccessState extends CameraStates {}
class GalleryImageClearSuccessState extends CameraStates {}
class UploadImageLoadingState extends CameraStates {}
class UploadImageSuccessState extends CameraStates {}
class UploadImageErrorState extends CameraStates {}
class GetMealsLoadingState extends CameraStates {}
class GetMealsSuccessState extends CameraStates {}
class GetMealsErrorState extends CameraStates {}
class AddMealLoadingState extends CameraStates {}
class AddMealSuccessState extends CameraStates {}
class AddMealErrorState extends CameraStates {}
class ClearImagePathsSuccessState extends CameraStates {}