import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';

Widget kcalEatenContainer({required BuildContext context}) => Padding(
      padding: EdgeInsets.only(
        left: 3.w,
      ),
      child: Column(
        children: [
          Container(
            width: 29.5.w,
            height: 8.5.h,
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: .8.h),
            decoration: BoxDecoration(
              borderRadius: defaultBorderRadius,
              color: backgroundColor,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 20.w,
                  alignment: Alignment.center,
                  child: defaultText(
                      text: "$caloriesConsumed",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 19.sp,
                            color: Colors.black,
                          )),
                ),
                .3.ph,
                defaultText(
                    text: "kcal eaten",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.2,
                          color: Colors.black,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
