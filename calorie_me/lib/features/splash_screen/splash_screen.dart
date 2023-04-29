import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constants/constants.dart';

Widget splashScreen({required Widget nextScreen}) => AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset('assets/images/splash_background.png',
                  width: 100.w, height: 100.h, fit: BoxFit.cover),
              defaultProgressIndicator(),
            ],
          ),
        ],
      ),
      nextScreen: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.grey,
      splashIconSize: 4000,
      curve: Curves.easeInOut,
      duration: 2000,
    );
