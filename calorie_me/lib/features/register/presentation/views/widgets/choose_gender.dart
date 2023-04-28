import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/widgets.dart';

Widget chooseGender({required cubit, required context}) => Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        border: Border.all(
          color: Colors.grey,
        ),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio(
                  fillColor: MaterialStateProperty.all(cubit.gender == "Male"
                      ? Theme.of(context).iconTheme.color
                      : Colors.grey),
                  value: "Male",
                  groupValue: cubit.gender,
                  onChanged: (value) {
                    cubit.changeGender(value.toString());
                  }),
              defaultText(
                text: 'Male',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16.sp,
                      color:
                          cubit.gender == "Male" ? Colors.black : Colors.grey,
                    ),
              )
            ],
          ),
          Row(
            children: [
              Radio(
                  fillColor: MaterialStateProperty.all(cubit.gender == "Female"
                      ? Theme.of(context).iconTheme.color
                      : Colors.grey),
                  value: "Female",
                  groupValue: cubit.gender,
                  onChanged: (value) {
                    cubit.changeGender(value.toString());
                  }),
              defaultText(
                text: 'Female',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16.sp,
                      color:
                          cubit.gender == "Female" ? Colors.black : Colors.grey,
                    ),
              )
            ],
          ),
        ],
      ),
    );
