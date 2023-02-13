import 'package:calorie_me/features/settings/data/presentation/views/widgets/setting_container.dart';
import 'package:flutter/material.dart';
import '../manager/app_theme_cubit/app_theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppThemeCubit.get(context);
    return settingContainer(cubit, context);
  }
}
