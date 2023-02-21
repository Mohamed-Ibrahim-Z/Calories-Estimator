import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  UserModel? userLogged;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userLogged = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }
}
