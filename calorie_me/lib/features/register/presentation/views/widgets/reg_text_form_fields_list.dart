import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/widgets.dart';

List<Widget> regTextFormFieldsList(
        {required context,
        required usernameController,
        required emailController,
        required passwordController,
        required ageController,
        required weightController,
        required heightController,
        required cubit}) =>
    [
      defaultTextFormField(
        context: context,
        hintText: 'username',
        keyboardType: TextInputType.name,
        prefixIcon: const Icon(Icons.person_outline),
        controller: usernameController,
        validationString: 'Username',
      ),
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
      defaultTextFormField(
        hintText: 'Age',
        context: context,
        keyboardType: TextInputType.number,
        prefixIcon: const Icon(Icons.numbers),
        controller: ageController,
        validationString: 'Age',
      ),
      defaultTextFormField(
        hintText: 'Weight',
        context: context,
        keyboardType: TextInputType.number,
        prefixIcon: const Icon(Icons.line_weight),
        controller: weightController,
        validationString: 'Weight',
      ),
      defaultTextFormField(
        hintText: 'Height',
        context: context,
        keyboardType: TextInputType.number,
        prefixIcon: const Icon(Icons.height),
        controller: heightController,
        validationString: 'Height',
      ),
    ];
