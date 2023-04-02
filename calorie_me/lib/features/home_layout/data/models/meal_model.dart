class MealModel {
  String imageUrl = "", dateTime = "";
  List<String> ingredients = [];
  List<String> calories = [];

  MealModel(
      {required this.imageUrl,
      required this.ingredients,
      required this.calories,
      required this.dateTime});

  MealModel.fromJson(Map<String, dynamic> json) {
    json['ingredients'].forEach((ingredient) {
      ingredients.add(ingredient);
    });
    json['calories'].forEach((calorie) {
      calories.add(calorie);
    });
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'calories': calories,
        'dateTime': dateTime,
      };
}
