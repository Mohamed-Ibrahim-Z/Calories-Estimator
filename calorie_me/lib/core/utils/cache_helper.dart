import 'package:calorie_me/core/utils/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../features/home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import '../../features/login/presentation/manager/login_cubit/login_cubit.dart';
import '../../features/login/presentation/views/login_screen.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    return await sharedPreferences!.setInt(key, value);
  }

  static void signOut(context) {
    loggedUserID = null;
    BottomNavCubit.get(context).changeBottomNavScreen(0);
    if (isGoogleAccount) {
      LoginCubit.get(context).signOutFromGmail();
    }
    FirebaseAuth.instance.signOut();
    navigateToAndRemoveUntil(nextPage: const LoginScreen(), context: context);
    sharedPreferences!.remove("token");
  }
}
