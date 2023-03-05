import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/register/presentation/views/widgets/register_screen_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: backgroundAnimationStack(screenBody: const RegisterScreenBody()));
  }
}
