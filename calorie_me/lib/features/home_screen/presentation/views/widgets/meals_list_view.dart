import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'meals_item_shimmer.dart';
import 'meals_list_view_item.dart';

Widget mealsListView({
  required HomeScreenCubit homeScreenCubit,
  required AnimationController listViewAnimationController,
  required Animation<Offset> evenItem,
  required Animation<Offset> oddItem,
  required CameraStates cameraState,
}) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 3.h),
    separatorBuilder: (context, index) => SizedBox(
      height: 3.h,
    ),
    itemBuilder: (context, index) {
      bool isEven = index % 2 == 0;
      return cameraState is AddMealLoadingState ||
              cameraState is UploadImageLoadingState
          ? mealsItemShimmer()
          : isEven
              ? SlideTransition(
                  position: evenItem,
                  child: mealsItem(
                      meal: homeScreenCubit.mealsList[index],
                      context: context,
                      homeScreenCubit: homeScreenCubit,
                      index: index),
                )
              : SlideTransition(
                  position: oddItem,
                  child: mealsItem(
                      meal: homeScreenCubit.mealsList[index],
                      context: context,
                      homeScreenCubit: homeScreenCubit,
                      index: index));
    },
    itemCount: homeScreenCubit.mealsList.length,
  );
}
