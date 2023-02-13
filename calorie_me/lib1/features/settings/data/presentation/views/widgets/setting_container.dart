import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../manager/app_theme_cubit/app_theme_cubit.dart';

Widget settingContainer(AppThemeCubit cubit, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 3.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(23),
        boxShadow: const [
          BoxShadow(color: defaultColor, offset: Offset(3, 3), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.dark_mode_outlined,
              size: 24,
            ),
          ),
          SizedBox(width: 3.w),
          defaultText(
              text: 'Appearance',
              style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Switch(
              value: cubit.isDark,
              onChanged: (
                bool value,
              ) {
                cubit.changeAppTheme();
              })
        ],
      ),
    ),
  );
}
