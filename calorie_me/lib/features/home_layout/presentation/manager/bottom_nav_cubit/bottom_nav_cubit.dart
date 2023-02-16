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
}
