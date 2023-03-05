import 'package:calorie_me/features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'meals_item_shimmer.dart';
import 'meals_list_view_item.dart';

Widget shaderMask({required CameraCubit cameraCubit, required state}) =>
    ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.white,
            Colors.white,
            Colors.transparent
          ],
          stops: [0.01, 0.05, 0.95, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: mealsListView(
        cameraCubit: cameraCubit,
        state: state,
      ),
    );

Widget mealsListView({required CameraCubit cameraCubit, required state}) =>
    ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 4.5.w),
      separatorBuilder: (context, index) => SizedBox(
        height: 2.h,
      ),
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: FadeInAnimation(
            curve: Curves.easeIn,
            child: state is UploadImageLoadingState
                ? mealsItemShimmer()
                : mealsItem(
                    meal: cameraCubit.mealsList[index], context: context),
          ),
        );
      },
      itemCount: cameraCubit.mealsList.length,
    );
