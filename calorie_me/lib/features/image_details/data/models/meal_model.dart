class MealModel {
  String imageUrl = "", dateTime = "";
  Map<String, dynamic> ingredients = {};
  int mealCalories = 0;

  MealModel({
    required this.imageUrl,
    required this.ingredients,
    required this.dateTime,
    this.mealCalories = 0,
  });

  MealModel.fromJson(Map<String, dynamic> json) {
    ingredients = json;
    dateTime = DateTime.now().toIso8601String();
  }

  MealModel.fromFireStore(Map<String, dynamic> map) {
    ingredients = map['ingredients'];
    imageUrl = map['imageUrl'];
    dateTime = map['dateTime'];
    mealCalories = map['mealCalories'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'dateTime': dateTime,
        'mealCalories': mealCalories,
      };
}
