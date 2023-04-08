import 'package:calorie_me/core/utils/cache_helper.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../constants.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPass = true;

  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffixIcon =
        isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  String errorMessage = '';

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'token', value: value.user!.uid);
      loggedUserID = value.user!.uid;
      emit(LoginSuccessState());
    }).catchError((error) {
      // split the error message to get the error message only
      errorMessage = error.toString().split(']')[1];
      if (errorMessage.contains('network')) {
        errorMessage = 'No Internet Connection';
      } else if (errorMessage.contains('password')) {
        errorMessage = 'Wrong Password';
      }
      emit(LoginErrorState());
    });
  }

  final googleSignIn = GoogleSignIn();
  String googleUserId = '';

  void loginWithGmail() async {
    googleSignIn.signIn().then((user) {
      // authenticate user
      user!.authentication.then((googleKey) async {
        emit(LoginLoadingState());
        final credential = GoogleAuthProvider.credential(
          accessToken: googleKey.accessToken,
          idToken: googleKey.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }).then((value) {
        googleUserId = user.id;
        isGoogleAccount = true;
        UserModel userModel = UserModel(
          userName: user.displayName,
          email: user.email,
          password: 'password',
          gender: 'Male',
          uId: user.id,
          age: 0,
          profilePhoto: user.photoUrl,
          weight: 0,
          height: 0,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .get()
            .then((value) {
          CacheHelper.saveData(key: 'token', value: user.id);
          CacheHelper.saveData(key: 'isGoogleAccount', value: true);
          loggedUserID = user.id;
          if (value.exists) {
            emit(LoginSuccessState());
          } else {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.id)
                .set(userModel.toMap())
                .then((value) {
              emit(LoginSuccessState());
            });
          }
        });
      });
    });
  }

  void signOutFromGmail() async {
    await googleSignIn.signOut();
    googleUserId = '';
    isGoogleAccount = false;
    CacheHelper.sharedPreferences!.remove('isGoogleAccount');
  }

  void resetPassword({required String email}) {
    emit(ResetPasswordLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      emit(ResetPasswordErrorState());
    });
  }
}
