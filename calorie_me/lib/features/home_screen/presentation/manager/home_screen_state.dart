part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenStates {}

class HomeScreenInitial extends HomeScreenStates {}
class GetMealsLoadingState extends HomeScreenStates {}
class GetMealsSuccessState extends HomeScreenStates {}
class GetMealsErrorState extends HomeScreenStates {}
class GetUserDataLoadingState extends HomeScreenStates {}
class GetUserDataSuccessState extends HomeScreenStates {}
class GetUserDataErrorState extends HomeScreenStates {}