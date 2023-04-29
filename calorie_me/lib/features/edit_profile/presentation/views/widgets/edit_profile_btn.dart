import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';
import '../edit_profile_screen.dart';

Widget editProfileBtn({required context}) => Center(
      child: TextButton.icon(
        onPressed: () {
          navigateTo(
              nextPage: const EditProfileScreen(),
              context: context,
              pageTransitionType: PageTransitionType.bottomToTop);
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
        style: TextButton.styleFrom(
          elevation: 5,
          minimumSize: Size(75.w, 7.h),
          backgroundColor: defaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
        label: defaultText(
          text: 'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.3,
          ),
        ),
      ),
    );
