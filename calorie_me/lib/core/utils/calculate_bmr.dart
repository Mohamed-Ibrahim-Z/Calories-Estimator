import '../../features/register/data/model/user_model.dart';

void calculateBMR({required UserModel? userModel}) {
  if (userModel!.gender == "Male") {
    userModel.bmr = 88.362 +
        (13.397 * userModel.weight) +
        (4.799 * userModel.height) -
        (5.677 * userModel.age!.toInt());
  } else {
    userModel.bmr = 447.593 +
        (9.247 * userModel.weight) +
        (3.098 * userModel.height) -
        (4.330 * userModel.age!.toInt());
  }
}
