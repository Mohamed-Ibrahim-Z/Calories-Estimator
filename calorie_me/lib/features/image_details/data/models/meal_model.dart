class MealModel {
  String imageUrl = "", dateTime = "", mealID = "";
  Map<String, dynamic> ingredients = {};
  dynamic mealCalories = 0;

  MealModel({
    required this.imageUrl,
    required this.ingredients,
    required this.dateTime,
    this.mealCalories = 0,
  });

  MealModel.fromJson(Map<String, dynamic> json) {
    ingredients = json;
    ingredients.forEach((key, value) {
      if (!key.toLowerCase().contains("total")) mealCalories += value;
    });
    ingredients['total_carb'] =
        double.parse(ingredients['total_carb'].toStringAsFixed(1));
    ingredients['total_fat'] =
        double.parse(ingredients['total_fat'].toStringAsFixed(1));
    ingredients['total_protein'] =
        double.parse(ingredients['total_protein'].toStringAsFixed(1));
    dateTime = DateTime.now().toIso8601String();
  }

  MealModel.fromFireStore(Map<String, dynamic> map, String mealId) {
    ingredients = map['ingredients'];
    ingredients['total_carb'] =
        double.parse(ingredients['total_carb'].toStringAsFixed(1));
    ingredients['total_fat'] =
        double.parse(ingredients['total_fat'].toStringAsFixed(1));
    ingredients['total_protein'] =
        double.parse(ingredients['total_protein'].toStringAsFixed(1));
    imageUrl = map['imageUrl'];
    dateTime = map['dateTime'];
    mealID = mealId;
    mealCalories = map['mealCalories'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'dateTime': dateTime,
        'mealCalories': mealCalories,
      };
}
