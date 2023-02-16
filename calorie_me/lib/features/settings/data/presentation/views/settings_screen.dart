import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/login/presentation/views/login_screen.dart';
import 'package:calorie_me/features/settings/data/presentation/views/widgets/setting_container.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../manager/app_theme_cubit/app_theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppThemeCubit.get(context);
    return Column(
      children: [
        appearanceContainer(cubit, context),
        SizedBox(height: 2.h),
        settingsContainer(
            context: context,
            text: 'Logout',
            icon: Icons.logout_outlined,
            onTap: () {
              navigateTo(
                  nextPage: const LoginScreen(),
                  context: context,
                  pageTransitionType: PageTransitionType.fade);
            }),
      ],
    );
  }
}
