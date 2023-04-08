import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

TableRow tableRow({required String ingredient, required int calories}) =>
    TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Center(
          child: defaultText(
            text: ingredient,
            textAlign: TextAlign.center,
            style: ingredient == "Total Calories"
                ? TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Center(
          child: defaultText(
            text: calories.toString(),
            textAlign: TextAlign.center,
            style: ingredient == "Total Calories"
                ? TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ),
      ),
    ]);
