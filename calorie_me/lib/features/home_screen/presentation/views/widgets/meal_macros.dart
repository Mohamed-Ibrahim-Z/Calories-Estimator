import 'package:calorie_me/features/image_details/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/widgets/widgets.dart';

List<Row> mealMacros(
        {required BuildContext context, required MealModel meal}) =>
    [
      Row(
        children: [
          defaultText(
            text: "Carbs: ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            width: 1.w,
          ),
          defaultText(
            text: "${meal.ingredients['total_carb']} g",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
          SizedBox(
            width: 1.w,
          ),
          defaultText(
            text: "${meal.ingredients['total_fat']} g",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Color(0xFFC58940),
                ),
          ),
        ],
      ),
      Row(
        children: [
          defaultText(
            text: "Protein: ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            width: 1.w,
          ),
          defaultText(
            text: "${meal.ingredients['total_protein']} g",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Color(0xFFC58940),
                ),
          ),
        ],
      ),
    ];
