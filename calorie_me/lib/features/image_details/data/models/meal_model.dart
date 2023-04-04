class MealModel {
  String imageUrl = "", dateTime = "";
  Map<String, dynamic> ingredients = {};

  MealModel({
    required this.imageUrl,
    required this.ingredients,
    required this.dateTime,
  });

  MealModel.fromJson(Map<String, dynamic> json, String imageFullUrl) {
    ingredients = json;
    imageUrl = imageFullUrl;
    dateTime = DateTime.now().toString();
  }

  MealModel.fromFireStore(Map<String, dynamic> map) {
    ingredients = map['ingredients'];
    imageUrl = map['imageUrl'];
    dateTime = map['dateTime'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'dateTime': dateTime,
      };
}
