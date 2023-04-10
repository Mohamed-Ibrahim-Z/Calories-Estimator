import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';

Widget customPercentIndicator(animation, context, UserModel currentUser) {
  int caloriesRemaining = currentUser.bmr!.round() - caloriesConsumed;
  if (caloriesRemaining < 0) caloriesRemaining = 0;
  return Center(
    child: CircularPercentIndicator(
        backgroundColor: Colors.grey[300]!,
        animation: true,
        animationDuration: 1200,
        animateFromLastPercent: true,
        percent: (caloriesRemaining / currentUser.bmr!).clamp(0.0, 1.0),
        backgroundWidth: 8,
        lineWidth: 15,
        linearGradient: const LinearGradient(
          colors: [
            Colors.amber,
            defaultColor,
          ],
        ),
        circularStrokeCap: CircularStrokeCap.round,
        radius: 135.0,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              shadows: [
                BoxShadow(
                  color: defaultColor[800]!,
                  blurRadius: animation!.value,
                  spreadRadius: animation!.value,
                ),
              ],
              Icons.bolt,
              // Make the color glow with the gradient
              color: defaultColor,
              size: 50,
            ),
            defaultText(
                text: "$caloriesRemaining",
                style: Theme.of(context).textTheme.displayLarge),
            defaultText(
                text: 'kcal', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(
              height: 1.h,
            ),
            defaultText(
                text: 'REMAINING',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    )),
          ],
        )),
  );
}
