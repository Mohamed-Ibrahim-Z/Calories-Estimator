part of 'camera_cubit.dart';

abstract class CameraStates {}

class CameraInitial extends CameraStates {}
class ImagePickedSuccessState extends CameraStates {}
class UploadImageLoadingState extends CameraStates {}
class UploadImageSuccessState extends CameraStates {}
class UploadImageErrorState extends CameraStates {}
class AddMealLoadingState extends CameraStates {}
class AddMealSuccessState extends CameraStates {}
class AddMealErrorState extends CameraStates {}
class PredictImageLoadingState extends CameraStates {}
class PredictImageSuccessState extends CameraStates {}
class PredictImageErrorState extends CameraStates {}
class ToggleFlashState extends CameraStates {}
