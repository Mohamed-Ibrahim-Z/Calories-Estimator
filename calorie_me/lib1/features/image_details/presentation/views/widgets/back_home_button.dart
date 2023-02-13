import 'package:calorie_me/features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

Widget backHomeButton({required context,required CameraCubit cubit})=>ElevatedButton(
    style: ElevatedButton.styleFrom(
        shadowColor: Colors.grey[700],
        elevation: 5,
        animationDuration:
        const Duration(milliseconds: 500),
        minimumSize: Size(80.w, 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
    onPressed: () {
      Navigator.of(context).pop();
      cubit.clearCameraImage();
      cubit.clearGalleryImage();
    },
    child: defaultText(text: 'Back to Home Screen'));