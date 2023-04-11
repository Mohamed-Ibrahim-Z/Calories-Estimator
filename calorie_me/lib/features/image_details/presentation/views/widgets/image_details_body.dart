import 'package:calorie_me/features/image_details/presentation/views/widgets/footer_buttons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';

Widget imageDetailsBody({required context, required CameraCubit cameraCubit}) =>
    Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 11.w, right: 11.w, top: 3.h, bottom: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              defaultText(
                  text: 'Ingredients',
                  style: Theme.of(context).textTheme.bodyMedium),
              defaultText(
                  text: 'Calories',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Table(
          border: TableBorder.all(
            color: Theme.of(context).iconTheme.color!,
          ),
          children: cameraCubit.tableRows,
        ),
        SizedBox(
          height: 4.h,
        ),
        footerButtons(context: context, cameraCubit: cameraCubit),
      ],
    );
