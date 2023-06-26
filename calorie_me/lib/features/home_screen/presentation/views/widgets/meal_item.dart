import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meal_macros.dart';
import 'package:calorie_me/features/image_details/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'meal_image.dart';

Widget mealItem(
    {required HomeScreenCubit homeScreenCubit,
    required BuildContext context,
    required MealModel meal,
    required int index}) {
  String time = homeScreenCubit.getTimeDifference(dateTime: meal.dateTime);
  List<String> ingredients = [];
  meal.ingredients.forEach((key, value) {
    if (!key.toLowerCase().contains('total')) ingredients.add(key);
  });
  return AnimatedOpacity(
    opacity: homeScreenCubit.isCategorySelected ? 1 : 0,
    duration: Duration(milliseconds: 500),
    child: DateTime.parse(meal.dateTime).day == homeScreenCubit.days.last.day
        ? Dismissible(
            key: Key(meal.mealID),
            behavior: HitTestBehavior.deferToChild,
            onDismissed: (direction) {
              homeScreenCubit.deleteMeal(index: index, meal: meal);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      children: [
                        mealImage(mealImageUrl: meal.imageUrl),
                        3.pw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: defaultText(
                                  text: ingredients.join(', ').toString(),
                                  maxLines: 15,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              1.ph,
                              Column(
                                children:
                                    mealMacros(context: context, meal: meal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 13.w,
                      child: Column(
                        children: [
                          defaultText(
                              text: time,
                              style: Theme.of(context).textTheme.bodySmall),
                          4.ph,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              defaultText(
                                text: meal.mealCalories.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Color(0xFFC58940),
                                    ),
                              ),
                              defaultText(
                                text: "Kcal",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: Color(0xFFC58940),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        // Another Day
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    children: [
                      mealImage(mealImageUrl: meal.imageUrl),
                      3.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50.w,
                              child: defaultText(
                                text: ingredients.join(', ').toString(),
                                maxLines: 15,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            1.ph,
                            Column(
                              children:
                                  mealMacros(context: context, meal: meal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 13.w,
                    child: Column(
                      children: [
                        defaultText(
                            text: time,
                            style: Theme.of(context).textTheme.bodySmall),
                        4.ph,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            defaultText(
                              text: homeScreenCubit
                                  .categoryCaloriesConsumed[index]
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Color(0xFFC58940),
                                  ),
                            ),
                            defaultText(
                              text: "Kcal",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Color(0xFFC58940),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
  );
}
