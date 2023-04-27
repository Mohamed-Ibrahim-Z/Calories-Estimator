import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../register/presentation/views/widgets/reg_text_form_fields_list.dart';

Widget editProfileListView(
        {required usernameController,
        required passwordController,
        required emailController,
        required ageController,
        required weightController,
        required heightController,
        required loginCubit,
        required List<String> textFormFieldsLabels}) =>
    BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return textFormFieldsListView(
            textFormFieldsLabels: textFormFieldsLabels,
            context: context,
            textFormFieldsList: regTextFormFieldsList(
                context: context,
                usernameController: usernameController,
                passwordController: passwordController,
                emailController: emailController,
                ageController: ageController,
                weightController: weightController,
                heightController: heightController,
                cubit: loginCubit,
                textFormFieldsLabels: textFormFieldsLabels));
      },
    );
