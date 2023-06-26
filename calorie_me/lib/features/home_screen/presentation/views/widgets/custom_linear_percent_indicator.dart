import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget customLinearPercentIndicator({
  required double percent,
  required BuildContext context,
  required Color indicatorColor,
}) =>
    LinearPercentIndicator(
      percent: percent,
      lineHeight: 1.h,
      width: 30.w,
      backgroundColor: backgroundColor,
      progressColor: indicatorColor,
      padding: EdgeInsets.zero,
      barRadius: Radius.circular(10),
      animationDuration: 2000,
      curve: Curves.easeInOut,
    );
