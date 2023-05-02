import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/cache_helper.dart';
import 'package:calorie_me/features/settings/data/presentation/views/widgets/setting_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../manager/app_theme_cubit/app_theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appThemeCubit = AppThemeCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            text: "Settings",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          2.ph,
          appearanceContainer(appThemeCubit, context),
          2.ph,
          settingsContainer(
              context: context,
              text: 'Logout',
              icon: Icons.logout_outlined,
              onTap: () {
                CacheHelper.signOut(context);
              }),
        ],
      ),
    );
  }
}
