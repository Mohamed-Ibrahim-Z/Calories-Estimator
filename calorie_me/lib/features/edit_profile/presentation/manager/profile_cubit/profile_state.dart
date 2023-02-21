part of 'profile_cubit.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}
class UpdateUserDataLoadingState extends ProfileStates {}
class UpdateUserDataSuccessState extends ProfileStates {}
class UpdateUserDataErrorState extends ProfileStates {}
class UploadProfileImageLoadingState extends ProfileStates {}
class UploadProfileImageSuccessState extends ProfileStates {}
class UploadProfileImageErrorState extends ProfileStates {}