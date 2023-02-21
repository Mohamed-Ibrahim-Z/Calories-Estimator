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
      this.uId,
      this.profilePhoto,
      required this.height,
      this.age,
      this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['username'];
    password = json['password'];
    email = json['email'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    uId = json['uId'];
    gender = json['gender'];
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
