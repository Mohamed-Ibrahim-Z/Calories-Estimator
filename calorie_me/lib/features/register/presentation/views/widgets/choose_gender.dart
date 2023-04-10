import 'package:flutter/material.dart';

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
            )
          ],
        ),
      ],
    );
