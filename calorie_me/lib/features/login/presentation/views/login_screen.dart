import 'package:calorie_me/constants.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/login_screen_body.dart';
import 'package:calorie_me/features/login/presentation/views/widgets/painter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomPaint(
              painter: Painter(), child: LoginScreenBody())),
    );
  }
}
