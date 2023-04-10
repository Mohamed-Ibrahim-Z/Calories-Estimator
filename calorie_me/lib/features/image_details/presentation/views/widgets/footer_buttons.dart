import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/home_layout/presentation/views/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import '../../../../home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';

Widget footerButtons({required context, required CameraCubit cameraCubit}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
              child: defaultButton(
                  text: 'Back To Home',
                  onPressed: () {
                    navigateToAndRemoveUntil(
                        nextPage: const HomeLayout(),
                        context: context,
                        transition: PageTransitionType.fade);
                  })),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
              child: defaultButton(
                  text: 'Add to Meals',
                  onPressed: () {
                    BottomNavCubit.get(context).changeBottomNavScreen(0);
                    if (!newVersion) {
                      cameraCubit.uploadFullImage();
                    } else {
                      cameraCubit.addMealToList();
                    }
                    navigateToAndRemoveUntil(
                        nextPage: const HomeLayout(), context: context);
                  })),
        ],
      ),
    );
