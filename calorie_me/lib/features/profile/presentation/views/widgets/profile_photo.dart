import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/profile/presentation/views/profile_screen.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';

Widget profilePhoto(
        {required ProfileCubit cubit,
        required UserModel currentUser,
        double? radius,
        double? endRadius,
        bool isProfileScreen = false,
        context}) =>
    GestureDetector(
      onTap: () => isProfileScreen
          ? showImage(cubit: cubit, currentUser: currentUser, context: context)
          : navigateTo(
              context: context,
              nextPage: ProfileScreen(),
              pageTransitionType: PageTransitionType.rightToLeft),
      child: cubit.profileImagePath == null
          ? !isProfileScreen
              ? ClipRRect(
                  borderRadius: defaultBorderRadius,
                  child: CachedNetworkImage(
                    imageUrl: currentUser.profilePhoto!,
                    width: 12.w,
                  ),
                )
              : CircleAvatar(
                  radius: radius ?? 9.0.h,
                  backgroundImage: CachedNetworkImageProvider(
                    currentUser.profilePhoto!,
                  ),
                )
          : Image.file(cubit.profileImagePath!),
    );

Future showImage(
        {required ProfileCubit cubit,
        required UserModel currentUser,
        required context}) =>
    showModal(
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        context: context,
        builder: (context) => profilePhoto(
              cubit: cubit,
              currentUser: currentUser,
              radius: 20.0.h,
            ));
