import 'package:calorie_me/features/camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'meals_list_view.dart';

Widget mealsContainer({
  required BuildContext context,
  required HomeScreenCubit homeScreenCubit,
  required HomeScreenStates screenState,
  required CameraStates cameraState,
  required AnimationController listController,
  required Animation<Offset> evenItemOfListAnimation,
  required Animation<Offset> oddItemOfListAnimation,
}) =>
    homeScreenCubit.mealsList.isEmpty
        ? Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Center(
              child: defaultText(
                text: "No Meals Found",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        )
        : mealsListView(
            homeScreenCubit: homeScreenCubit,
            listViewAnimationController: listController,
            evenItem: evenItemOfListAnimation,
            oddItem: oddItemOfListAnimation,
            cameraState: cameraState,
          );
