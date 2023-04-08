import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../image_details/data/models/meal_model.dart';

Widget mealsItem({required MealModel meal, context}) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, top: 1.h, bottom: 1.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                fadeInCurve: Curves.easeIn,
                fadeOutCurve: Curves.easeOut,
                imageUrl: meal.imageUrl,
                fit: BoxFit.cover,
                height: 17.w,
                width: 17.w,
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50.w,
                  child: defaultText(
                      text: meal.ingredients.keys.join(', ').toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    defaultText(
                        text: "Calories: ",
                        style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(
                      width: 1.w,
                    ),
                    SizedBox(
                      width: 40.w,
                      child: defaultText(
                          text: meal.ingredients.values.join(', ').toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
