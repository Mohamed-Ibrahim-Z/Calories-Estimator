import 'dart:ui';
import 'package:calorie_me/features/login/presentation/views/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const RiveAnimation.asset(
          'assets/shapes.riv',
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
        const LoginScreenBody(),
      ],
    ));
  }
}
