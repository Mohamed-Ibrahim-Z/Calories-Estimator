import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/register_screen.dart';

Widget rowBelowLoginBtn(context, cubit) => Column(
      children: [
        TextButton(
            onPressed: () {
              cubit.loginWithGmail();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(googleImagePath, width: 7.w, height: 7.h),
                SizedBox(
                  width: 2.w,
                ),
                defaultText(
                  text: "Continue with Google",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.sp,
                    color: Colors.black,
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
            )),
      ],
    );
