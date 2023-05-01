import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../reset_password/presentation/views/reset_password_screen.dart';

Widget forgotPassword({required BuildContext context}) => defaultTextButton(
  padding: EdgeInsets.only(right: 1.w),
      context: context,
      onPressed: () {
        navigateTo(nextPage: const ResetPasswordScreen(), context: context);
      },
      child: defaultText(
          text: 'Forgot Password',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15.sp,
              )),
    );
