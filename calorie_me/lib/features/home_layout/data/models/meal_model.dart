class MealModel {
  String imageUrl = "", title = "", calories = "", dateTime = "";

  MealModel(
      {required this.imageUrl,
      required this.title,
      required this.calories,
      required this.dateTime});

  MealModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    calories = json['calories'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() => {
        'imageUrl': imageUrl,
        'title': title,
        'calories': calories,
        'dateTime': dateTime,
      };
}
