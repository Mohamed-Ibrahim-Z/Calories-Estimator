import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';

Widget continueWithGoogle(context, LoginCubit cubit) => defaultTextButton(

      context: context,
      onPressed: () {
        cubit.loginWithGmail();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(googleImagePath, width: 6.w, height: 6.h),
          2.pw,
          defaultText(
            text: "Continue with Google",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 17.sp,
              shadows: [
                Shadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
