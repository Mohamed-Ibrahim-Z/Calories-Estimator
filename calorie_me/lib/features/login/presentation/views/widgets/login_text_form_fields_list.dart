import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

List<Widget> loginTextFormFieldsList(
        {required context,
        required emailController,
        required passwordController,
        required LoginCubit cubit}) =>
    [
      defaultTextFormField(
        hintText: 'Email',
        context: context,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        validationString: 'Email',
      ),
      defaultTextFormField(
        hintText: 'Password',
        context: context,
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        suffixIcon: IconButton(
            onPressed: () {
              cubit.changePasswordVisibility();
            },
            icon: Icon(cubit.suffixIcon)),
        isPassword: cubit.isPass,
        validationString: 'Password',
        onFieldSubmitted: (value) {
          cubit.userLogin(
              email: emailController.text, password: passwordController.text);
        },
      ),
    ];
