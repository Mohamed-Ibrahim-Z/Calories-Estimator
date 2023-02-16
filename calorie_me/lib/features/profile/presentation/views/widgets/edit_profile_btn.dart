import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../edit_profile_screen.dart';

Widget editProfileBtn({required context}) => Center(
      child: TextButton.icon(
        onPressed: () {
          navigateTo(nextPage: const EditProfileScreen(), context: context,
              pageTransitionType: PageTransitionType.fade);
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(
          minimumSize: Size(41.w, 5.h),
          backgroundColor: defaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        label: defaultText(
          text: 'Edit Profile',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
