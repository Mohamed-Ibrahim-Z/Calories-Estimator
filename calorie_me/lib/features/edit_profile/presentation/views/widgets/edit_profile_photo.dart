import 'package:calorie_me/constants.dart';
import 'package:calorie_me/features/profile/presentation/views/widgets/profile_photo.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../manager/profile_cubit/profile_cubit.dart';

Widget editProfilePhoto(
        {required ProfileCubit profileCubit,
        required UserModel currentUser,
        required context}) =>
    Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          profilePhoto(
              cubit: profileCubit,
              currentUser: currentUser,
              endRadius: 9.h,
              radius: 8.h,
              context: context),
          !isGoogleAccount
              ? CircleAvatar(
                  child: defaultIconButton(
                      icon: Icons.camera_alt_outlined,
                      onPressed: () {
                        profileCubit.changeProfilePhoto();
                      }))
              : const SizedBox(),
        ],
      ),
    );
