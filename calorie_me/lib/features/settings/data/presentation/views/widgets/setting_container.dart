import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../manager/app_theme_cubit/app_theme_cubit.dart';

Widget settingsContainer(
    {required context,
    required String text,
    required IconData icon,
    required Function() onTap}) {
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      onTap();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 3.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        height: 8.h,
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(3, 3), blurRadius: 4)
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                icon,
                size: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 3.w),
            defaultText(
                text: text,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black)),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            )
          ],
        ),
      ),
    ),
  );
}

Widget appearanceContainer(AppThemeCubit cubit, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 3.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(3, 3), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.dark_mode_outlined,
              size: 24,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 3.w),
          defaultText(
              text: 'Appearance', style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black
          )),
          const Spacer(),
          Switch(
              value: cubit.isDark,
              activeColor: Colors.black,
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
