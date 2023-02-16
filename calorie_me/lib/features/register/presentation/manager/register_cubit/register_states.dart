part of 'register_cubit.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}
class ChangePasswordVisibilityState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {}
class RegisterCreateUserSuccessState extends RegisterStates {}
class RegisterCreateUserErrorState extends RegisterStates {}
class ChangeGenderState extends RegisterStates {}