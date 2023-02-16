class UserModel {
  String email = "";
  String? userName;
  String? age;
  String? gender;
  String? password;
  String? uId;
  String? profilePhoto;
  String? weight;
  String? height;

  UserModel(
      {required this.userName,
      required this.email,
      this.password,
      required this.weight,
      required this.uId,
      required this.profilePhoto,
      required this.height,
      this.age,
      this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['username'];
    uId = json['uId'];
    email = json['email'];
    password = json['password'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toMap() => {
        'username': userName,
        'email': email,
        'age': age,
        'gender': gender,
        'weight': weight,
        'height': height,
        'uId': uId,
        'password': password,
        'profilePhoto': profilePhoto,
      };
}
