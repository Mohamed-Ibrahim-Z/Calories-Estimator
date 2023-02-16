import 'package:calorie_me/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';

Widget profilePhoto(
        {required ProfileCubit cubit, required UserModel userLogged}) =>
    CircleAvatar(
      radius: 10.5.h,
      backgroundColor: defaultColor,
      child: CircleAvatar(
        radius: 10.h,
        backgroundImage: cubit.profileImagePath == null
            ? NetworkImage(
                userLogged.profilePhoto!,
              )
            : FileImage(cubit.profileImagePath!) as ImageProvider,
      ),
    );
