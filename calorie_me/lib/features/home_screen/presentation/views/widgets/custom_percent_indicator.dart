import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';

Widget customPercentIndicator(context, UserModel currentUser) {
  caloriesRemaining = currentUser.bmr!.round() - caloriesConsumed;
  if (caloriesRemaining < 0) caloriesRemaining = 0;
  return Padding(
    padding: EdgeInsets.only(
      right: 2.w,
    ),
    child: CircularPercentIndicator(
        backgroundColor: Color(0xFFFAF8F1),
        animation: true,
        animationDuration: 1200,
        animateFromLastPercent: true,
        percent: (caloriesRemaining / currentUser.bmr!).clamp(0.0, 1.0),
        backgroundWidth: 28,
        lineWidth: 13,
        linearGradient: LinearGradient(
          colors: [
            Colors.amber,
            defaultColor,
          ],
        ),
        circularStrokeCap: CircularStrokeCap.round,
        radius: 23.w,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultText(
                text: "$caloriesRemaining",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black)),
            defaultText(
                text: 'kcal',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black)),
            SizedBox(
              height: 1.h,
            ),
            defaultText(
                text: 'REMAINING',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 15.sp,
                    )),
          ],
        )),
  );
}
