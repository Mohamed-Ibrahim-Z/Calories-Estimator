import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'custom_linear_percent_indicator.dart';

Widget macro({
  required BuildContext context,
  required String macroName,
  required dynamic macroValue,
  required double goal,
  required Color indicatorColor,
}) {
  print("macroValue: $macroValue");
  print("goal: $goal");
  return Column(
    children: [
      Row(
        children: [
          defaultText(
              text: macroName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black,
                  )),
          defaultText(
              text: "${macroValue.toStringAsFixed(1)}g",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16.sp,
                    color: indicatorColor,
                  )),
        ],
      ),
      1.ph,
      customLinearPercentIndicator(
        context: context,
        indicatorColor: indicatorColor,
        percent: (macroValue / goal).clamp(0, 1),
      ),
    ],
  );
}
