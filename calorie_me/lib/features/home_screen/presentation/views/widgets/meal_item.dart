import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/image_details/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'meal_image.dart';

Widget mealItem(
    {required HomeScreenCubit homeScreenCubit,
    required BuildContext context,
    required MealModel meal}) {
  String time = homeScreenCubit.getTimeDifference(dateTime: meal.dateTime);

  return AnimatedOpacity(
    opacity: homeScreenCubit.isCategorySelected ? 1 : 0,
    duration: Duration(milliseconds: 500),
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
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
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
            Container(
              width: 10.w,
              child: defaultText(
                  text: time, style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    ),
  );
}
