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
        hintText: 'Username',
        keyboardType: TextInputType.name,
        controller: usernameController,
        validationString: 'Username',
      ),
      defaultTextFormField(
        hintText: 'Email',
        context: context,
        keyboardType: TextInputType.emailAddress,
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
        controller: ageController,
        validationString: 'Age',
      ),
      defaultTextFormField(
        hintText: 'Weight',
        context: context,
        keyboardType: TextInputType.number,
        controller: weightController,
        validationString: 'Weight',
      ),
      defaultTextFormField(
        hintText: 'Height',
        context: context,
        keyboardType: TextInputType.number,
        controller: heightController,
        validationString: 'Height',
      ),
    ];
