import 'package:calorie_me/core/utils/cache_helper.dart';
import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:calorie_me/features/home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:calorie_me/features/login/presentation/views/login_screen.dart';
import 'package:calorie_me/features/settings/data/presentation/views/widgets/setting_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../manager/app_theme_cubit/app_theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appThemeCubit = AppThemeCubit.get(context);
    return Column(
      children: [
        appearanceContainer(appThemeCubit, context),
        SizedBox(height: 2.h),
        settingsContainer(
            context: context,
            text: 'Logout',
            icon: Icons.logout_outlined,
            onTap: () {
              CacheHelper.signOut(context);
            }),
      ],
    );
  }
}
