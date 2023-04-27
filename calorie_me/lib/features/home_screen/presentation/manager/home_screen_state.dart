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
class DeleteMealLoadingState extends HomeScreenStates {}
class DeleteMealSuccessState extends HomeScreenStates {}
class DeleteMealErrorState extends HomeScreenStates {}
class UndoDeleteMealLoadingState extends HomeScreenStates {}
class UndoDeleteMealSuccessState extends HomeScreenStates {}
class UndoDeleteMealErrorState extends HomeScreenStates {}
class ChangeSelectedDateLoadingState extends HomeScreenStates {}
class ChangeSelectedDateSuccessState extends HomeScreenStates {}
class ChangeSelectedDateErrorState extends HomeScreenStates {}