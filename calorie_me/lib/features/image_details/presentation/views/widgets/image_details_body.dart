import 'package:calorie_me/features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import 'back_home_button.dart';

Widget imageDetailsBody({required context,required CameraCubit cubit})=>Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Center(
        child: Image.file(
          cubit.cameraImagePath != null
              ? cubit.cameraImagePath!
              : cubit.galleryImagePath!,
          width: 85.w,
        )),
    defaultText(text: 'Image Name'),
    defaultText(text: '200 Calories'),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: backHomeButton(context: context, cubit: cubit),
    )
  ],
);