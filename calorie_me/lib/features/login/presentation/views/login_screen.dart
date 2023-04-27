import 'package:calorie_me/features/login/presentation/views/widgets/login_screen_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginScreenBody());
  }
}
