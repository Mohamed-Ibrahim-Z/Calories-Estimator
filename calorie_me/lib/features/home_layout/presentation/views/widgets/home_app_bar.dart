import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:calorie_me/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AppBar homeAppBar(
        {required context,
        required LoginCubit loginCubit,
        required ProfileCubit profileCubit}) =>
    AppBar(
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      leading: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: profilePhoto(
              cubit: profileCubit, userLogged: loginCubit.userLogged!)),
      title: Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: Text(
          'Hello ${loginCubit.userLogged!.userName}',
        ),
      ),
    );
