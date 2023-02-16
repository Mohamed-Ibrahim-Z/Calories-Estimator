import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/page_transition.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../register/presentation/views/register_screen.dart';

Widget rowBelowLoginBtn(context) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultText(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.bodySmall),
            TextButton(
                onPressed: () {
                  navigateTo(
                      nextPage: const RegisterScreen(), context: context);
                },
                child: defaultText(
                  text: 'Register',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: defaultColor,
                        fontSize: 18.sp,
                      ),
                )),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                child: Divider(
              color: Color(0xff979797),
              thickness: 1,
            )),
            defaultText(
                text: ' or continue with ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: const Color(0xff979797), fontSize: 16.sp)),
            const Expanded(child: Divider(color: Color(0xff979797), thickness: 1)),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(googleImagePath)),
            SizedBox(
              width:5.w,
            ),
            const Image(image: AssetImage(facebookImagePath)),
          ],
        ),
      ],
    );
