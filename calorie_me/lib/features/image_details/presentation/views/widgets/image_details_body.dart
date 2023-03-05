import 'package:calorie_me/features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';

Widget imageDetailsBody({required context, required CameraCubit cameraCubit}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Image.file(
          cameraCubit.imagePath!,
          width: 85.w,
        )),
        defaultText(text: 'Image Name'),
        defaultText(text: '200 Calories'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            children: [
              Expanded(
                  child: defaultButton(
                      text: 'Back To Home',
                      onPressed: () {
                        Navigator.of(context).pop();
                        cameraCubit.clearImagePaths();
                      })),
              SizedBox(
                width: 2.w,
              ),
              Expanded(
                  child: defaultButton(
                      text: 'Add to Meals',
                      onPressed: () {
                        BottomNavCubit.get(context).changeBottomNavScreen(0);
                        cameraCubit.uploadImage();
                        Navigator.pop(context);
                      })),
            ],
          ),
        )
      ],
    );
