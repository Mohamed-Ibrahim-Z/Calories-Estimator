import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_layout/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
                defaultText(
                    text: meal.title,
                    style: Theme.of(context).textTheme.bodyMedium),
                defaultText(
                    text: '${meal.calories} Calories',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ),
    );

