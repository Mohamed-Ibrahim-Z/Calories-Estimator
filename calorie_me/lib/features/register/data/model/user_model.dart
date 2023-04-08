class UserModel {
  String email = "";
  String? userName = "";
  int? age = 0;
  String? gender;
  String? password;
  String? uId;
  String? profilePhoto;
  double weight = 0;
  double height = 0;
  double? bmr = 0;

  UserModel(
      {required this.userName,
      required this.email,
      this.password,
      required this.weight,
      this.uId,
      this.profilePhoto,
      required this.height,
      this.age,
      this.gender,
      this.bmr = 0,});

  UserModel.fromFireStore(Map<String, dynamic> map) {
    userName = map['username'];
    password = map['password'];
    email = map['email'];
    age = map['age'];
    weight = map['weight'];
    height = map['height'];
    bmr = map['bmr'];
    uId = map['uId'];
    gender = map['gender'];
    profilePhoto = map['profilePhoto'];
  }

  Map<String, dynamic> toMap() => {
        'username': userName,
        'email': email,
        'age': age,
        'gender': gender,
        'weight': weight,
        'height': height,
        'bmr': bmr,
        'uId': uId,
        'password': password,
        'profilePhoto': profilePhoto,
      };
}
