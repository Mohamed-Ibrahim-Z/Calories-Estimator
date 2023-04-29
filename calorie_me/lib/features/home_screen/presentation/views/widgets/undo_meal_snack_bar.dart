import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> undoMealSnackBar(
    {required HomeScreenCubit homeScreenCubit, required BuildContext context}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      content: defaultText(
        text: "Meal Deleted Successfully",
      ),
      action: SnackBarAction(
        label: 'Undo',
        textColor: defaultColor.withOpacity(1),
        onPressed: () {
          homeScreenCubit.undoDeleteMeal();
        },
      ),
    ),
  );
}
