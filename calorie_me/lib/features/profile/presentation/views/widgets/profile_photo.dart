import 'package:animations/animations.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';

Widget profilePhoto(
        {required ProfileCubit cubit,
        required UserModel currentUser,
        double? radius,
        double? endRadius, context}) =>
    GestureDetector(
      onTap: () => showImage(
          cubit: cubit, currentUser: currentUser, context: context
      ),
      child: AvatarGlow(
        glowColor: defaultColor,
        endRadius: endRadius ?? 12.0.h,
        child: CircleAvatar(
          radius: radius ?? 9.0.h,
          backgroundImage: cubit.profileImagePath == null
              ? NetworkImage(
                  currentUser.profilePhoto!,
                )
              : FileImage(cubit.profileImagePath!) as ImageProvider,
        ),
      ),
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
