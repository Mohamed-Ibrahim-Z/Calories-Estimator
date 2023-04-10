import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/cache_helper.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_states.dart';
import 'package:calorie_me/features/settings/data/presentation/views/widgets/setting_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
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
        BlocBuilder<AppThemeCubit, AppThemeStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).iconTheme.color),
                          value: false,
                          groupValue: newVersion,
                          onChanged: (value) {
                            appThemeCubit.changeAppVersion(value);
                          }),
                      defaultText(
                        text: 'Version 1',
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).iconTheme.color),
                          value: true,
                          groupValue: newVersion,
                          onChanged: (value) {
                            appThemeCubit.changeAppVersion(value);
                          }),
                      defaultText(
                        text: 'Version 2',
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
