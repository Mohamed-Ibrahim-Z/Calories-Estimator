import 'package:flutter/material.dart';
import 'package:calorie_me/core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';

List<Widget> regTextFormFieldsList(
        {required context,
        dynamic usernameController,
        dynamic emailController,
        dynamic passwordController,
        required ageController,
        required weightController,
        required heightController,
        cubit, required List<String> textFormFieldsLabels}) =>
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
        enableEditing: isGoogleAccount ? false : true,
      ),
      cubit != null
          ? defaultTextFormField(
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
            )
          : const SizedBox(),
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
