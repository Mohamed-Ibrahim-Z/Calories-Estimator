import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'category_item.dart';

Widget categoriesListView({
  required HomeScreenCubit homeScreenCubit,
  required Animation<Offset> evenItem,
  required Animation<Offset> oddItem,
}) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 3.h),
    separatorBuilder: (context, index) => 3.ph,
    itemBuilder: (context, index) {
      bool isEven = index % 2 == 0;
      return SlideTransition(
        position: isEven ? evenItem : oddItem,
        child: categoryItem(
          context: context,
          homeScreenCubit: homeScreenCubit,
          index: index,
        ),
      );
    },
    itemCount: mealsCategories.length,
  );
}
