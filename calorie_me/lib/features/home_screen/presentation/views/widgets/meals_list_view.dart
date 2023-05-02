import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meal_item.dart';
import 'package:calorie_me/features/image_details/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../manager/home_screen_cubit.dart';

Widget mealsListView({
  required HomeScreenCubit homeScreenCubit,
  required Animation<Offset> evenItem,
  required Animation<Offset> oddItem,
  required BuildContext context,
}) {
  return Column(
    children: [
      homeScreenCubit.isCategorySelected
          ? defaultTextButton(
              context: context,
              child: defaultText(
                  text: "Back to Categories",
                  style: Theme.of(context).textTheme.bodySmall),
              onPressed: () {
                homeScreenCubit.changeCategoryOpacity();
              })
          : SizedBox(),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.h),
        separatorBuilder: (context, index) => 3.ph,
        itemBuilder: (context, index) {
          bool isEven = index % 2 == 0;
          return SlideTransition(
            position: isEven ? evenItem : oddItem,
            child: mealItem(
                homeScreenCubit: homeScreenCubit,
                context: context,
                meal: homeScreenCubit.meals[index]),
          );
        },
        itemCount: homeScreenCubit.meals.length,
      ),
    ],
  );
}
