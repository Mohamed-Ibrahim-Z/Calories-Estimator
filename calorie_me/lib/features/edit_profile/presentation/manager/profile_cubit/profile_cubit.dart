import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

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

  String? profileImageUrl;

  Future<void> updateProfilePhoto({required UserModel userModel}) async {
    emit(UploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImagePath!.path).pathSegments.last}')
        .putFile(profileImagePath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        updateProfile(userModel: userModel);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  Future<void> updateProfile({
    required UserModel userModel,
    UserModel? currentUser,
  }) async {
    emit(UpdateUserDataLoadingState());

    if (userModel.email != userModel.email) {
      FirebaseAuth.instance.currentUser!.updateEmail(userModel.email);
    }
    if (userModel.password != userModel.password) {
      FirebaseAuth.instance.currentUser!.updatePassword(userModel.password!);
    }


    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uId)
        .update({
      'username': userModel.userName,
      'email': userModel.email,
      'password': userModel.password,
      'age': userModel.age,
      'weight': userModel.weight,
      'height': userModel.height,
      'profilePhoto': profileImageUrl ?? currentUser.profilePhoto,
    }).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }
}
