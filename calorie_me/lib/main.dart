import 'package:calorie_me/core/constants/constants.dart';
import 'package:calorie_me/core/utils/cache_helper.dart';
import 'package:calorie_me/core/utils/theme.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/home_screen/presentation/manager/home_screen_cubit.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:calorie_me/features/login/presentation/views/login_screen.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_cubit.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'core/utils/dio.dart';
import 'features/camera_screen/presentation/manager/camera_cubit/camera_cubit.dart';
import 'features/edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'features/home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'features/home_layout/presentation/views/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();
  loggedUserID = CacheHelper.getData(key: 'token');
  isGoogleAccount = CacheHelper.getData(key: 'isGoogleAccount');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget screen = const LoginScreen();
    if (loggedUserID != null) {
      screen = const HomeLayout();
    }
    isGoogleAccount ??= false;
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
        BlocProvider<AppThemeCubit>(create: (context) => AppThemeCubit()),
        BlocProvider<CameraCubit>(create: (context) => CameraCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<HomeScreenCubit>(
            create: (context) => HomeScreenCubit()
              ..getUserData()
              ..getMealsList()),
      ],
      child: ResponsiveSizer(
        builder: (context, p0, p1) =>
            BlocBuilder<AppThemeCubit, AppThemeStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: splashScreen(
                nextScreen: screen,
              ),
              themeMode: AppThemeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightMode,
              darkTheme: darkMode,
            );
          },
        ),
      ),
    );
  }
}
