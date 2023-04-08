import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';

AppBar homeAppBar(
        {required context,
        required HomeScreenCubit homeScreenCubit,
        required ProfileCubit profileCubit}) =>
    AppBar(
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      leading: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: profilePhoto(
              cubit: profileCubit,
              currentUser: homeScreenCubit.userLogged!,
              context: context,
              radius: 5.w)),
      title: Padding(
        padding: EdgeInsets.only(top: 1.h),
        child: Text(
          'Hello ${homeScreenCubit.userLogged!.userName}',
        ),
      ),
    );
