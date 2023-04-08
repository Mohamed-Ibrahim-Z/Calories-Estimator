import 'dart:io';
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
    emit(UploadProfileImageLoadingState());
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
    emit(UpdateUserDataLoadingState());

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
      updateBMR(updateUserModel: updateUserModel);
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

  void updateBMR({required UserModel updateUserModel}) {
    if (updateUserModel.gender == "Male") {
      updateUserModel.bmr = 88.362 +
          (13.397 * updateUserModel.weight) +
          (4.799 * updateUserModel.height) -
          (5.677 * updateUserModel.age!.toInt());
    } else {
      updateUserModel.bmr = 447.593 +
          (9.247 * updateUserModel.weight) +
          (3.098 * updateUserModel.height) -
          (4.330 * updateUserModel.age!.toInt());
    }
  }
}
