import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/register_screen.dart';

Widget rowBelowLoginBtn(context, cubit) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultText(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16.sp,
                    )),
            SizedBox(
              width: 1.w,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: defaultColor),
                  ),
                ),
                onPressed: () {
                  navigateTo(
                      nextPage: const RegisterScreen(), context: context);
                },
                child: defaultText(
                    text: 'Register',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17.sp,
                          color: defaultColor,
                        ))),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
          width: 80.w,
          height: 7.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                defaultColor,
                Colors.blue[900]!,
              ],
            ),
          ),
          child: InkWell(
            onTap: () {
              cubit.loginWithGmail();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  googleImagePath,
                  width: 5.w,
                  height: 5.w,
                ),
                SizedBox(width: 2.w),
                defaultText(
                    text: 'Continue with Google',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
              ],
            ),
          ),
        )
      ],
    );
