import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';

Widget loginButton(
        {required LoginCubit loginCubit,
        required TextEditingController emailController,
        required TextEditingController passwordController,
        required BuildContext context}) =>
    Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            color: defaultColor,
            elevation: 10,
            height: 7.h,
            minWidth: 80.w,
            shape: RoundedRectangleBorder(
              borderRadius: defaultBorderRadius,
            ),
            onPressed: () {
              loginCubit.userLogin(
                  email: emailController.text,
                  password: passwordController.text);
            },
            child: Row(
              children: [
                Icon(
                  Icons.login,
                  size: 20.sp,
                ),
                SizedBox(
                  width: 30.w,
                ),
                defaultText(
                  text: 'Get In',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 17.sp,
                      ),
                ),
              ],
            ),
          )),
    );
