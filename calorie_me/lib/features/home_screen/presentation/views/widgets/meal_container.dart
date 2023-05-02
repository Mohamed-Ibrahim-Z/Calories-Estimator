import 'package:calorie_me/features/camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meals_list_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'categories_list_view.dart';

Widget mealContainer({
  required BuildContext context,
  required HomeScreenCubit homeScreenCubit,
  required HomeScreenStates screenState,
  required CameraStates cameraState,
  required AnimationController listController,
  required Animation<Offset> evenItem,
  required Animation<Offset> oddItem,
}) {
  return homeScreenCubit.state is OnCategorySelectState &&
          homeScreenCubit.categoryOpacity == 0
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
