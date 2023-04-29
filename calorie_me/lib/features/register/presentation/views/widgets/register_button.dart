import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

Widget registerButton({
  required RegisterCubit registerCubit,
  required usernameController,
  required emailController,
  required passwordController,
  required ageController,
  required weightController,
  required heightController,
  required GlobalKey<FormState> formKey,
}) =>
    Center(
      child: defaultButton(
          text: 'Register',
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (registerCubit.gender.isNotEmpty) {
                registerCubit.userRegister(
                  userName: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  age: int.parse(ageController.text),
                  weight: double.parse(weightController.text),
                  height: double.parse(heightController.text),
                );
              } else {
                defaultToast(
                    msg: 'Please Select Your Gender',
                    backgroundColor: Colors.red);
              }
            }
          }),
    );
