part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenStates {}

class HomeScreenInitial extends HomeScreenStates {}
class GetMealsLoadingState extends HomeScreenStates {}
class GetMealsSuccessState extends HomeScreenStates {}
class GetMealsErrorState extends HomeScreenStates {}
