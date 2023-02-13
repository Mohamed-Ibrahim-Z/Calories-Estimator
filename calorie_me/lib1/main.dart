import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calorie_me/constants.dart';
import 'package:calorie_me/core/utils/theme.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_cubit.dart';
import 'package:calorie_me/features/settings/data/presentation/manager/app_theme_cubit/app_theme_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'features/home_layout/presentation/manager/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'features/home_layout/presentation/manager/camera_cubit/camera_cubit.dart';
import 'features/home_layout/presentation/views/home_layout.dart';

void main() {
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
      ],
      child: ResponsiveSizer(
        builder: (context, p0, p1) =>
            BlocBuilder<AppThemeCubit, AppThemeStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: splashScreen(),
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

  Widget splashScreen() => AnimatedSplashScreen(
      splash: 'assets/images/logo1.png',
      nextScreen: const HomeLayout(),
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: defaultColor,
      splashIconSize: 700,
      curve: Curves.easeInOut,
      pageTransitionType: PageTransitionType.bottomToTop,
      duration: 2000);
}
