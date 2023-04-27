import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/widgets.dart';

Widget horizontalCalendar(
        {required HomeScreenCubit homeScreenCubit,
        required ScrollController calendarScrollController}) =>
    Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: ListView.separated(
        controller: calendarScrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeScreenCubit.days.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 2.w,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              homeScreenCubit.changeSelectedDate(index);
            },
            child: Container(
              width: 20.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: defaultColor,
                  width: 2,
                ),
                color: homeScreenCubit.selectedDateIndex == index
                    ? Color(0xFFE5BA73)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultText(
                    text: '${homeScreenCubit.days[index].day}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 5),
                  defaultText(
                    text:
                        '${DateFormat('EEE').format(homeScreenCubit.days[index])}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
