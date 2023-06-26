import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';

Widget customLinearPercentIndicator({
  required UserModel currentUser,
  required double percent,
}) =>
    LinearPercentIndicator(
      percent: percent,
      lineHeight: 1.h,
      width: 35.w,
      backgroundColor: Colors.grey[300],
      progressColor: Colors.red,
      barRadius: Radius.circular(10),
      animationDuration: 2000,
      curve: Curves.easeInOut,
    );
