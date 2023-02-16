import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

Shimmer shimmerHomeAppBar() => Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(bottom: 3.h),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, top: 1.h),
              child: const CircleAvatar(
                radius: 20,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Container(
                width: 30.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
