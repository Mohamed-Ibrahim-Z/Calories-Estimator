import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../data/model/user_model.dart';

part 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPass = true;

  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPass = !isPass;
    suffixIcon =
        isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  String gender = "";

  void changeGender(String value) {
    gender = value;
    emit(ChangeGenderState());
  }

  String errorMessage = '';

  void userRegister(
      {required String email,
      required String userName,
      required String password,
      required int age,
      required double weight,
      required double height}) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          uId: value.user!.uid,
          userName: userName,
          email: email,
          password: password,
          age: age,
          weight: weight,
          height: height);

      emit(RegisterSuccessState());
    }).catchError((error) {
      // split the error message to get the error message only
      errorMessage = error.toString().split(']')[1];
      if (errorMessage.contains('network')) {
        errorMessage = 'No Internet Connection';
      }

      emit(RegisterErrorState());
    });
  }

  UserModel? userModel;

  void createUser(
      {required String email,
      required String userName,
      required String password,
      required String uId,
      required int age,
      required double weight,
      required double height}) {
    userModel = UserModel(
      userName: userName,
      email: email,
      password: password,
      gender: gender,
      uId: uId,
      age: age,
      profilePhoto: gender == 'Male'
          ? defaultMaleProfilePhoto
          : defaultFemaleProfilePhoto,
      weight: weight,
      height: height,
      bmr: 0,
    );
    calculateBMR();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel!.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState());
    });
  }

  void calculateBMR() {
    if (userModel!.gender == "Male") {
      userModel!.bmr = 88.362 +
          (13.397 * userModel!.weight) +
          (4.799 * userModel!.height) -
          (5.677 * userModel!.age!.toInt());
    } else {
      userModel!.bmr = 447.593 +
          (9.247 * userModel!.weight) +
          (3.098 * userModel!.height) -
          (4.330 * userModel!.age!.toInt());
    }
  }

  void clearGender() {
    gender = '';
  }
}
