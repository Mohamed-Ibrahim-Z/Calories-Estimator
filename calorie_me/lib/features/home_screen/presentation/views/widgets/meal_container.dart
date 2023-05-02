import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meals_list_view.dart';
import 'package:flutter/material.dart';
import 'categories_list_view.dart';

Widget mealContainer({
  required BuildContext context,
  required HomeScreenCubit homeScreenCubit,
  required HomeScreenStates screenState,
  required AnimationController listController,
  required Animation<Offset> evenItem,
  required Animation<Offset> oddItem,
}) {
  return homeScreenCubit.categoryOpacity == 0 &&
          homeScreenCubit.isCategorySelected
      ? mealsListView(
          homeScreenCubit: homeScreenCubit,
          evenItem: evenItem,
          oddItem: oddItem,
          context: context,
        )
      : categoriesListView(
          homeScreenCubit: homeScreenCubit,
          evenItem: evenItem,
          oddItem: oddItem,
        );
}
