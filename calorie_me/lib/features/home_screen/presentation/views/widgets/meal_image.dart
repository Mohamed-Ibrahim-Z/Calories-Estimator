import 'package:cached_network_image/cached_network_image.dart';
import 'package:calorie_me/features/image_details/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget mealImage({required MealModel meal}) => ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        fadeInCurve: Curves.easeIn,
        fadeOutCurve: Curves.easeOut,
        imageUrl: meal.imageUrl,
        fit: BoxFit.cover,
        height: 20.w,
        width: 20.w,
        placeholder: (context, url) => Container(
          color: Colors.black12,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
