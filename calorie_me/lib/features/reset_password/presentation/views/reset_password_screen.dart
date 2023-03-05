import 'dart:ui';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/reset_password/presentation/views/widgets/reset_password_body.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: backgroundAnimationStack(screenBody: const ResetPasswordBody()));
  }
}
