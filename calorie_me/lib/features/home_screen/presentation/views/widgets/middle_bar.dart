import 'package:calorie_me/features/register/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';
import 'custom_percent_indicator.dart';

Widget middleBar(
        {required BuildContext context, required UserModel currentUser}) =>
    Padding(
      padding: EdgeInsets.only(
        left: 3.w,
        right: 3.w,
        bottom: 2.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.w,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                borderRadius: defaultBorderRadius,
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Colors.amber,
                  width: 5,
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
                              fontSize: 21.sp,
                            )),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  defaultText(
                      text: "kcal eaten",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16.sp,
                          )),
                ],
              ),
            ),
          ),
          customPercentIndicator(context, currentUser),
        ],
      ),
    );
