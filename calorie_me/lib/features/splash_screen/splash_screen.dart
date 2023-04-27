import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constants/constants.dart';

Widget splashScreen({required Widget nextScreen}) => AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoImagePath,
              width: 70.w, height: 70.h, fit: BoxFit.contain),
          SizedBox(height: 6.h),
          SpinKitFadingCircle(
            color: defaultColor,
            size: 36.0.sp,
          ),
        ],
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Color(0xFFFAF8F1),
      splashIconSize: 1400,
      curve: Curves.easeInOut,
      duration: 2000,
    );
