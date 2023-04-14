import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meal_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../image_details/data/models/meal_model.dart';

Widget mealsItem(
    {required MealModel meal,
    context,
    required HomeScreenCubit homeScreenCubit,
    required int index}) {
  String time = homeScreenCubit.getTimeDifference(dateTime: meal.dateTime);
  return Dismissible(
    key: Key(meal.mealID),
    behavior: HitTestBehavior.deferToChild,
    onDismissed: (direction) {
      homeScreenCubit.deleteMeal(index: index);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: defaultColor,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                mealImage(meal: meal),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: defaultText(
                          text: meal.ingredients.keys.join(', ').toString(),
                          maxLines: 15,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          defaultText(
                            text: "Calories: ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          defaultText(
                            text: "${meal.mealCalories} Kcal",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: defaultColor,

                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            defaultText(
                text: time, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    ),
  );
}
