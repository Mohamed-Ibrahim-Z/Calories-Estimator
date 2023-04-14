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
      mealCalories += value;
    });
    dateTime = DateTime.now().toIso8601String();
  }

  MealModel.fromFireStore(Map<String, dynamic> map,String mealId) {
    ingredients = map['ingredients'];
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
