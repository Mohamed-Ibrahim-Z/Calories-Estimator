import 'package:calorie_me/core/utils/theme.dart';
import 'package:calorie_me/core/widgets/widgets.dart';
import 'package:calorie_me/features/login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:calorie_me/features/login/presentation/views/login_screen.dart';
import 'package:calorie_me/features/register/presentation/manager/register_cubit/register_cubit.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_cubit.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'features/edit_profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'features/home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
        BlocProvider<AppThemeCubit>(create: (context) => AppThemeCubit()),
        BlocProvider<CameraCubit>(create: (context) => CameraCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),

      ],
      child: ResponsiveSizer(
        builder: (context, p0, p1) =>
            BlocBuilder<AppThemeCubit, AppThemeStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: splashScreen(nextScreen: const LoginScreen()),
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
