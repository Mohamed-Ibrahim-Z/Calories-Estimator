import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/kcal_eaten_container.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/macros_indicator.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'custom_percent_indicator.dart';

Widget middleBar({
  required BuildContext context,
  required UserModel currentUser,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 3.w,
      right: 3.w,
      bottom: 2.h,
    ),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kcalEatenContainer(context: context),
            2.ph,
            macrosIndicator(context: context, currentUser: currentUser),
          ],
        ),
        customPercentIndicator(context, currentUser),
      ],
    ),
  );
}
