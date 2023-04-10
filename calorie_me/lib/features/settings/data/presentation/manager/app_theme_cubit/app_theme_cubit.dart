import 'package:calorie_me/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme_states.dart';

class AppThemeCubit extends Cubit<AppThemeStates> {
  AppThemeCubit() : super(AppThemeInitial());
  static AppThemeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppTheme() {
    isDark = !isDark;
    emit(AppThemeChangeState());
  }
  void changeAppVersion(value) {
    newVersion = value;
    emit(AppVersionChangeState());
  }
}
