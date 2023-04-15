part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}

class LoginInitial extends LoginStates {}
class ChangePasswordVisibilityState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {}
class NewGoogleAccountState extends LoginStates {}
class LoginErrorState extends LoginStates {}
class GetUserDataLoadingState extends LoginStates {}
class GetUserDataSuccessState extends LoginStates {}
class GetUserDataErrorState extends LoginStates {}
class ResetPasswordLoadingState extends LoginStates {}
class ResetPasswordSuccessState extends LoginStates {}
class ResetPasswordErrorState extends LoginStates {}
class ChangeGenderState extends LoginStates {}
