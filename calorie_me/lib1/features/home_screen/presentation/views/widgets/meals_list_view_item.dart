import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget mealsListViewItem(context) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 1.h, bottom: 1.h),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/85039719?v=4'),
            ),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                    text: 'Breakfast',
                    style: Theme.of(context).textTheme.bodyMedium),
                defaultText(
                    text: 'Egg, Toast, Coffee',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ),
    );
