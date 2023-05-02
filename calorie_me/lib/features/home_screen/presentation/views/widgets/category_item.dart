import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/home_screen/presentation/views/widgets/meal_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget categoryItem({
  context,
  required HomeScreenCubit homeScreenCubit,
  required int index,
}) {
  print(homeScreenCubit.categoryCaloriesConsumed[index]);
  return GestureDetector(
    onTap: () {
      homeScreenCubit.changeCategoryOpacity();
      homeScreenCubit.selectedCategoryIndex = index;
    },
    child: AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: homeScreenCubit.categoryOpacity,
      onEnd: () {
        homeScreenCubit.onCategorySelect();
        homeScreenCubit.getCurrentCategoryMeals();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Row(
                children: [
                  mealImage(mealImageUrl: mealsCategoriesImages[index]),
                  3.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: defaultText(
                            text: mealsCategories[index],
                            maxLines: 15,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            defaultText(
                              text: "Calories: ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            1.pw,
                            defaultText(
                              text: homeScreenCubit
                                      .categoryCaloriesConsumed[index]
                                      .toString() +
                                  " cal",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Color(0xFFC58940),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  //   DateTime.parse(meal.dateTime).day == homeScreenCubit.days.last.day
  //     ? Dismissible(
  //         key: Key(meal.mealID),
  //         behavior: HitTestBehavior.deferToChild,
  //         onDismissed: (direction) {
  //           homeScreenCubit.deleteMeal(index: index);
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Theme.of(context).scaffoldBackgroundColor,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.6),
  //                 spreadRadius: 1,
  //                 blurRadius: 1,
  //                 offset: Offset(0, 1),
  //               ),
  //             ],
  //           ),
  //           child: Padding(
  //             padding:
  //                 EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
  //             child: Stack(
  //               alignment: Alignment.topRight,
  //               children: [
  //                 Row(
  //                   children: [
  //                     mealImage(meal: meal),
  //                     SizedBox(
  //                       width: 3.w,
  //                     ),
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           SizedBox(
  //                             width: 50.w,
  //                             child: defaultText(
  //                               text:
  //                                   meal.ingredients.keys.join(', ').toString(),
  //                               maxLines: 15,
  //                               style: Theme.of(context).textTheme.bodyMedium,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 1.h,
  //                           ),
  //                           Row(
  //                             children: [
  //                               defaultText(
  //                                 text: "Calories: ",
  //                                 style: Theme.of(context).textTheme.bodySmall,
  //                               ),
  //                               SizedBox(
  //                                 width: 1.w,
  //                               ),
  //                               defaultText(
  //                                 text: "${meal.mealCalories} Kcal",
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodySmall!
  //                                     .copyWith(
  //                                       color: Color(0xFFC58940),
  //                                     ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   width: 10.w,
  //                   child: defaultText(
  //                       text: time,
  //                       style: Theme.of(context).textTheme.bodySmall),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       )
  //     : Container(
  //   decoration: BoxDecoration(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //     borderRadius: BorderRadius.circular(20),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.black.withOpacity(0.6),
  //         spreadRadius: 1,
  //         blurRadius: 1,
  //         offset: Offset(0, 1),
  //       ),
  //     ],
  //   ),
  //   child: Padding(
  //     padding:
  //     EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 2.h),
  //     child: Stack(
  //       alignment: Alignment.topRight,
  //       children: [
  //         Row(
  //           children: [
  //             mealImage(meal: meal),
  //             SizedBox(
  //               width: 3.w,
  //             ),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: 50.w,
  //                     child: defaultText(
  //                       text:
  //                       meal.ingredients.keys.join(', ').toString(),
  //                       maxLines: 15,
  //                       style: Theme.of(context).textTheme.bodyMedium,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 1.h,
  //                   ),
  //                   Row(
  //                     children: [
  //                       defaultText(
  //                         text: "Calories: ",
  //                         style: Theme.of(context).textTheme.bodySmall,
  //                       ),
  //                       SizedBox(
  //                         width: 1.w,
  //                       ),
  //                       defaultText(
  //                         text: "${meal.mealCalories} Kcal",
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .bodySmall!
  //                             .copyWith(
  //                           color: Color(0xFFC58940),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         Container(
  //           width: 10.w,
  //           child: defaultText(
  //               text: time,
  //               style: Theme.of(context).textTheme.bodySmall),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
