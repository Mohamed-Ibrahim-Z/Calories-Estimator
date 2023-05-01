import 'dart:io';
import 'package:calorie_me/core/utils/calculate_bmr.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final ImagePicker profileImagePicker = ImagePicker();
  File? profileImagePath;

  void changeProfilePhoto() {
    profileImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      profileImagePath = File(value.path);
      emit(UploadProfileImageSuccessState());
    });
  }

  Future<void> updateProfilePhoto(
      {required UserModel updateUserModel, UserModel? currentUser}) async {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImagePath!.path).pathSegments.last}')
        .putFile(profileImagePath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserModel.profilePhoto = value;
        updateProfile(
            updateUserModel: updateUserModel, currentUserModel: currentUser);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  Future<void> updateProfile({
    required UserModel updateUserModel,
    UserModel? currentUserModel,
  }) async {
    if (updateUserModel.email != updateUserModel.email) {
      FirebaseAuth.instance.currentUser!.updateEmail(updateUserModel.email);
    }
    if (updateUserModel.password != updateUserModel.password) {
      FirebaseAuth.instance.currentUser!
          .updatePassword(updateUserModel.password!);
    }
    if (currentUserModel!.weight != updateUserModel.weight ||
        currentUserModel.height != updateUserModel.height ||
        currentUserModel.age != updateUserModel.age) {
      calculateBMR(userModel: updateUserModel);
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(updateUserModel.uId)
        .update(updateUserModel.toMap())
        .then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  void updateUserInfo({
    required UserModel updateUserModel,
    UserModel? currentUserModel,
  }) async {
    emit(UpdateUserDataLoadingState());
    if (profileImagePath != null) {
      await updateProfilePhoto(
          updateUserModel: updateUserModel, currentUser: currentUserModel);
    } else {
      await updateProfile(
          updateUserModel: updateUserModel, currentUserModel: currentUserModel);
    }
  }
}
