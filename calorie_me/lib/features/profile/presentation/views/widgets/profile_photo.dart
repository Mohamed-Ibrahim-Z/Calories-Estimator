import 'package:avatar_glow/avatar_glow.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';

Widget profilePhoto(
        {required ProfileCubit cubit,
        required UserModel userLogged,
        double? radius,
        double? endRadius}) =>
    AvatarGlow(
      glowColor: defaultColor,
      endRadius: endRadius ?? 12.0.h,
      child: CircleAvatar(
        radius: radius ?? 9.0.h,
        backgroundImage: cubit.profileImagePath == null
            ? NetworkImage(
                userLogged.profilePhoto!,
              )
            : FileImage(cubit.profileImagePath!) as ImageProvider,
      ),
    );
