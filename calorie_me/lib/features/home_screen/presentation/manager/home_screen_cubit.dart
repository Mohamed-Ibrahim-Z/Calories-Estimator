import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../image_details/data/models/meal_model.dart';
import '../../../register/data/model/user_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  UserModel? userLogged;

  void getUserData() {
    if (loggedUserID != null) {
      emit(GetUserDataLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedUserID)
          .get()
          .then((value) {
        userLogged = UserModel.fromFireStore(value.data()!);
        emit(GetUserDataSuccessState());
      }).catchError((error) {
        emit(GetUserDataErrorState());
      });
    }
  }

  List<MealModel> mealsList = [];
  List<String> mealsIDs = [];

  void getMealsList() {
    if (loggedUserID != null) {
      emit(GetMealsLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedUserID)
          .collection('meals')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        for (var element in event.docChanges) {
          if (element.type == DocumentChangeType.added) {
            mealIndex == -1
                ? mealsList.add(MealModel.fromFireStore(
                    element.doc.data()!, element.doc.id))
                : mealsList.insert(
                    mealIndex,
                    MealModel.fromFireStore(
                        element.doc.data()!, element.doc.id));
            caloriesConsumed += mealsList.last.mealCalories;
            mealsIDs.add(element.doc.id);
          }
        }
        emit(GetMealsSuccessState());
      });
    }
  }

  MealModel? deletedMeal;

  void deleteMeal({required int index}) {
    deletedMeal = mealsList[index];
    caloriesConsumed -= mealsList[index].mealCalories;
    mealsList.removeAt(index);
    mealIndex = index;
    emit(DeleteMealLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .doc(mealsIDs[index])
        .delete()
        .then((value) {
      mealsIDs.removeAt(index);
      emit(DeleteMealSuccessState());
    }).catchError((error) {
      emit(DeleteMealErrorState());
    });
  }

  void undoDeleteMeal() {
    emit(UndoDeleteMealLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection('meals')
        .doc()
        .set(deletedMeal!.toMap())
        .then((value) {
      mealIndex = -1;
      emit(UndoDeleteMealSuccessState());
    });
  }

  void clearUserData() {
    mealsList.clear();
    mealsIDs.clear();
    userLogged = null;
    caloriesConsumed = 0;
  }

  String getTimeDifference({required String dateTime}) {
    String time = "";
    if (DateTime.now().difference(DateTime.parse(dateTime)).inSeconds == 0) {
      time = 'Just now';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inMinutes < 1 &&
        DateTime.now().difference(DateTime.parse(dateTime)).inSeconds > 0) {
      time =
          '${DateTime.now().difference(DateTime.parse(dateTime)).inSeconds}s';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inMinutes >= 1) {
      time =
          '${DateTime.now().difference(DateTime.parse(dateTime)).inMinutes}m';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inHours >= 1) {
      time = '${DateTime.now().difference(DateTime.parse(dateTime)).inHours}h';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inDays >= 1) {
      time = '${DateTime.now().difference(DateTime.parse(dateTime)).inDays}d';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inDays >= 1 &&
        DateTime.now().difference(DateTime.parse(dateTime)).inDays % 7 == 0) {
      time =
          '${(DateTime.now().difference(DateTime.parse(dateTime)).inDays / 7).floor()}w';
    }
    if (DateTime.now().difference(DateTime.parse(dateTime)).inDays >= 1 &&
        DateTime.now().difference(DateTime.parse(dateTime)).inDays % 30 == 0) {
      time =
          '${(DateTime.now().difference(DateTime.parse(dateTime)).inDays / 30).floor()}m';
    }
    return time;
  }
}
