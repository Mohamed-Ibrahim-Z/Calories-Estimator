import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

Widget mealsItemShimmer() => Shimmer.fromColors(
  baseColor: Colors.grey,
  highlightColor: Colors.white,
  child: Padding(
    padding: EdgeInsets.only(left: 4.w, top: 1.h, bottom: 1.h),
    child: Row(
      children: [
        Container(
          height: 17.w,
          width: 17.w,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 2.h,
              width: 32.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 2.h,
              width: 22.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
