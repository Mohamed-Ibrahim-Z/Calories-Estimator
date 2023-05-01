import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/profile/presentation/views/profile_screen.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';

Widget profilePhoto(
    {required BuildContext context,
    required ProfileCubit cubit,
    required UserModel currentUser,
    double? radius}) {
  return cubit.profileImagePath == null
      ? CircleAvatar(
          radius: radius ?? 9.0.h,
          backgroundImage: CachedNetworkImageProvider(
            currentUser.profilePhoto!,
          ),
        )
      : CircleAvatar(
          backgroundImage: FileImage(cubit.profileImagePath!),
          radius: 9.0.h,
        );
}
