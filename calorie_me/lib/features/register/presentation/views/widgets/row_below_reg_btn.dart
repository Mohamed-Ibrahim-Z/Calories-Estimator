import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../login/presentation/views/login_screen.dart';

Widget rowBelowRegBtn(context, RegisterCubit cubit) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            navigateTo(
                nextPage: const LoginScreen(),
                context: context,
                pageTransitionType: PageTransitionType.leftToRight);
            cubit.clearGender();
            if (!cubit.isPass) {
              cubit.changePasswordVisibility();
            }
          },
          child: defaultText(
              text: 'Already have an account',
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
