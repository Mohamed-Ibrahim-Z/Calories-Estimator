import '../../../../register/data/model/user_model.dart';

List<String> initUserInfoTexts({required UserModel currentUser}) => [
      '${currentUser.weight} kg',
      '${currentUser.height} cm',
      '${currentUser.age} years',
      '${currentUser.gender}',
    ];
