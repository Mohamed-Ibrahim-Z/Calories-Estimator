import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

Widget chooseGender({required cubit, required context}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).iconTheme.color),
                value: "Male",
                groupValue: cubit.gender,
                onChanged: (value) {
                  cubit.changeGender(value.toString());
                }),
            defaultText(
              text: 'Male',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16.sp,
              ),
            )
          ],
        ),
        Row(
          children: [
            Radio(
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).iconTheme.color),
                value: "Female",
                groupValue: cubit.gender,
                onChanged: (value) {
                  cubit.changeGender(value.toString());
                }),
            defaultText(
              text: 'Female',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16.sp,
              ),
            )
          ],
        ),
      ],
    );
