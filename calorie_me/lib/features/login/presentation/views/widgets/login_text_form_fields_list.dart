import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

Widget loginTextFormFieldsList(
        {required context,
        required emailController,
        required passwordController,
        required LoginCubit cubit}) =>
    Column(
      children: [
        defaultTextFormField(
          hintText: 'Email',
          context: context,
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          validationString: 'Email',
          icon: Icons.email_outlined,
          label: 'Email',
        ),
        3.ph,
        defaultTextFormField(
          hintText: 'Password',
          context: context,
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock_outline,
          suffixIcon: IconButton(
              splashRadius: 1,
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
      ],
    );
