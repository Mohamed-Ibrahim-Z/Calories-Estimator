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
        prefixIcon: const Icon(Icons.email_outlined),
        controller: emailController,
        validationString: 'Email',
      ),
      defaultTextFormField(
        hintText: 'Password',
        context: context,
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
            onPressed: () {
              cubit.changePasswordVisibility();
            },
            icon: Icon(cubit.suffixIcon)),
        isPassword: cubit.isPass,
        validationString: 'Password',
      ),
    ];
