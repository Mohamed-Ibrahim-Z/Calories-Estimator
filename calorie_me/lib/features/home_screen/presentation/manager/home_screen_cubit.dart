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

  List<MealModel> breakFastMeals = [];
  List<MealModel> lunchMeals = [];
  List<MealModel> dinnerMeals = [];
  List<dynamic> categoryCaloriesConsumed = [0, 0, 0];
  List<String> mealsIDs = [];

  Future<void> getMealsList({int? day}) async {
    if (loggedUserID != null) {
      emit(GetMealsLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedUserID)
          .get()
          .then((value) {
        // Getting breakFast meals
        value.reference
            .collection("Breakfast")
            .orderBy('dateTime', descending: true)
            .snapshots()
            .listen((event) {
          getCategoryMeals(
            mealsList: breakFastMeals,
            event: event,
            day: day,
          );
        });
        // Getting lunch meals
        value.reference
            .collection("Lunch")
            .orderBy('dateTime', descending: true)
            .snapshots()
            .listen((event) {
          getCategoryMeals(
            mealsList: lunchMeals,
            event: event,
            day: day,
          );
        });
        // Getting dinner meals
        value.reference
            .collection("Dinner")
            .orderBy('dateTime', descending: true)
            .snapshots()
            .listen((event) {
          getCategoryMeals(
            mealsList: dinnerMeals,
            event: event,
            day: day,
          );
        });
      });
    }
  }

  void getCategoryMeals(
      {required List<MealModel> mealsList,
      required QuerySnapshot<Map<String, dynamic>> event,
      int? day}) {
    if (day == null) {
      day = days.last.day;
    }
    for (var element in event.docChanges) {
      if (element.type == DocumentChangeType.added) {
        if (!mealsIDs.contains(element.doc.id) &&
            DateTime.parse(element.doc.data()!['dateTime']).day == day) {
          mealIndex == -1
              ? mealsList.add(
                  MealModel.fromFireStore(element.doc.data()!, element.doc.id))
              : mealsList.insert(mealIndex,
                  MealModel.fromFireStore(element.doc.data()!, element.doc.id));
          caloriesConsumed += mealsList.last.mealCalories;
          if (mealsList == breakFastMeals) {
            categoryCaloriesConsumed[0] += caloriesConsumed;
          } else if (mealsList == lunchMeals) {
            categoryCaloriesConsumed[1] += caloriesConsumed;
          } else {
            categoryCaloriesConsumed[2] += caloriesConsumed;
          }
          mealsIDs.add(element.doc.id);
        }
      }
    }
    emit(GetMealsSuccessState());
  }

  MealModel? deletedMeal;

  void deleteMeal({required int index}) {
    // deletedMeal = mealsList[index];
    // caloriesConsumed -= mealsList[index].mealCalories;
    // mealsList.removeAt(index);
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
    breakFastMeals.clear();
    lunchMeals.clear();
    dinnerMeals.clear();
    mealsIDs.clear();
    userLogged = null;
    caloriesConsumed = 0;
    mealIndex = -1;
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

  List<DateTime> days = List.generate(7, (index) {
    return DateTime.now().subtract(Duration(days: 6 - index));
  });
  int selectedDateIndex = 6;

  void changeSelectedDate(index) async {
    emit(ChangeSelectedDateLoadingState());
    selectedDateIndex = index;
    breakFastMeals.clear();
    lunchMeals.clear();
    dinnerMeals.clear();
    mealsIDs.clear();
    categoryCaloriesConsumed = [0, 0, 0];
    caloriesConsumed = 0;
    categoryOpacity = 1;
    await getMealsList(day: days[index].day);
    emit(ChangeSelectedDateSuccessState());
  }

  // mealsIDs.clear();
  // mealsList.clear();
  // value.docs.forEach((element) {
  //   if (DateTime.parse(element.data()['dateTime']).day == days[index].day) {
  //     // mealsList.add(MealModel.fromFireStore(element.data(), element.id));
  //     mealsIDs.add(element.id);
  //   }
  // });
  double categoryOpacity = 1;

  void changeCategoryOpacity() {
    if (categoryOpacity == 0) {
      categoryOpacity = 1;
    } else {
      categoryOpacity = 0;
    }

    isCategorySelected = false;
    emit(ChangeCategoryOpacityState());
  }

  bool isCategorySelected = false;
  int selectedCategoryIndex = 0;

  void onCategorySelect() {
    emit(OnCategorySelectState());
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        isCategorySelected = true;
        emit(OnCategorySelectState());
      },
    );
  }

  List<MealModel> meals = [];

  void getCurrentCategoryMeals() {
    meals.clear();
    if (selectedCategoryIndex == 0) {
      meals.addAll(breakFastMeals);
    } else if (selectedCategoryIndex == 1) {
      meals.addAll(lunchMeals);
    } else {
      meals.addAll(dinnerMeals);
    }
  }
}
