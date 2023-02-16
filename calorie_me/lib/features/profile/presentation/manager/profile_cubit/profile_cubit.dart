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

  String? profileImageUrl = '';

  void updateProfilePhoto() {
    emit(UploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImagePath!.path).pathSegments.last}')
        .putFile(profileImagePath!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(profileImageUrl);
        // profileImagePath = null;
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateProfile({
    String? username,
    String? email,
    String? password,
    String? age,
    String? weight,
    String? height,
    required UserModel userLogged,
  }) {
    emit(UpdateUserDataLoadingState());

    FirebaseAuth.instance.currentUser!.updateEmail(email!);
    FirebaseAuth.instance.currentUser!.updatePassword(password!);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'username': username,
      'email': email,
      'password': password,
      'age': age,
      'weight': weight,
      'height': height,
      'profilePhoto': profileImageUrl ?? userLogged.profilePhoto,
    }).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }
}
