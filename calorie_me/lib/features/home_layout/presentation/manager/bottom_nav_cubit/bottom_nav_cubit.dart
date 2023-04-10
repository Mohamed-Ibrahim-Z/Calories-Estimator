import 'dart:async';

import 'package:calorie_me/features/profile/presentation/views/profile_screen.dart';
import 'package:calorie_me/features/settings/data/presentation/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home_screen/presentation/views/home_screen.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitial());

  static BottomNavCubit get(context) => BlocProvider.of(context);

  List<IconData> bottomNavIcons = [
    Icons.home,
    Icons.search,
    Icons.person,
    Icons.settings,
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Search Screen')),
    const ProfileScreen(),
    const SettingsScreen()
  ];

  void changeBottomNavScreen(int index) {
    currentIndex = index;
    emit(BottomNavChangeState());
  }

  int numOfTabs = 0;

  bool doubleTapped() {
    if (currentIndex != 0) {
      changeBottomNavScreen(0);
      return false;
    } else {
      if (numOfTabs == 1) {
        numOfTabs = 0;
      } else {
        numOfTabs++;
        emit(BottomNavDoubleTapState());
        Timer(const Duration(seconds: 2), () {
          numOfTabs = 0;
        });
        return false;
      }
    }
    return true;
  }
}
