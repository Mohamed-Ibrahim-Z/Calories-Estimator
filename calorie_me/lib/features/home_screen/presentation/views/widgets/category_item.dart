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
  return GestureDetector(
    onTap: () {
      homeScreenCubit.changeCategoryOpacity();
      homeScreenCubit.selectedCategoryIndex = index;
      homeScreenCubit.getCurrentCategoryMeals();
    },
    child: AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: homeScreenCubit.categoryOpacity,
      onEnd: () {
        homeScreenCubit.onCategorySelect();
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
            alignment: Alignment.bottomRight,
            children: [
              Row(
                children: [
                  mealImage(mealImageUrl: mealsCategoriesImages[index]),
                  3.pw,
                  Column(
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
                      1.ph,
                      Row(
                        children: [
                          defaultText(
                            text: "Protein: ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          1.pw,
                          defaultText(
                            text:
                                "${double.parse(homeScreenCubit.categoryProteinConsumed[index].toStringAsFixed(1))} g",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Color(0xFFC58940),
                                    ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          defaultText(
                            text: "Carbs: ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          1.pw,
                          defaultText(
                            text:
                                "${double.parse(homeScreenCubit.categoryCarbsConsumed[index].toStringAsFixed(1))} g",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Color(0xFFC58940),
                                    ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          defaultText(
                            text: "Fats: ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          1.pw,
                          defaultText(
                            text:
                                "${double.parse(homeScreenCubit.categoryFatsConsumed[index].toStringAsFixed(1))} g",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Color(0xFFC58940),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  defaultText(
                    text: homeScreenCubit.categoryCaloriesConsumed[index]
                        .toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFC58940),
                        ),
                  ),
                  defaultText(
                    text: "Kcal",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Color(0xFFC58940),
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
}
