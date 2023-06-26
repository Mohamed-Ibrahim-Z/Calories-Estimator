import 'package:calorie_me/features/home_screen/presentation/views/widgets/macro.dart';
import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/constants.dart';
import 'custom_linear_percent_indicator.dart';

Widget macrosIndicator(
    {required BuildContext context, required UserModel currentUser}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 3.w,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        macro(
            context: context,
            macroName: "Carbs: ",
            macroValue: carbConsumed,
            goal: currentUser.carbsGoal!,
            indicatorColor: Colors.red.shade400),
        .8.ph,
        macro(
            context: context,
            macroName: "Fats: ",
            macroValue: fatsConsumed,
            goal: currentUser.fatsGoal!,
            indicatorColor: Colors.red.shade600),
        .8.ph,
        macro(
          context: context,
          macroName: "Protein: ",
          macroValue: proteinConsumed,
          goal: currentUser.proteinGoal!,
          indicatorColor: Colors.red.shade700,
        ),
      ],
    ),
  );
}
