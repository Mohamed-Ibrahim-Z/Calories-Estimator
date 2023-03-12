import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

TableRow tableRow({required String ingredient, required String calories}) =>
    TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: defaultText(
            text: ingredient,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: defaultText(
            text: calories,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ]);
List<TableRow> tableRows = [
  tableRow(ingredient: 'ingredient', calories: 'calories'),
  tableRow(ingredient: 'ingredient', calories: 'calories'),
  tableRow(ingredient: 'ingredient', calories: 'calories'),
  tableRow(ingredient: 'ingredient', calories: 'calories'),
];
