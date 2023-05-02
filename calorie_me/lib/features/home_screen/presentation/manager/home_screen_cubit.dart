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
  List<MealModel> snacksMeals = [];
  List<String> mealsIds = [];
  List<dynamic> categoryCaloriesConsumed = [0, 0, 0, 0];
  var subscription;

  Future<void> getMealsList({int? day}) async {
    if (loggedUserID != null) {
      if (day == null) {
        emit(GetMealsLoadingState());
      }
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(loggedUserID)
          .get();
      // Getting breakfast meals
      subscription = userSnapshot.reference
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
      userSnapshot.reference
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
      userSnapshot.reference
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
      // Getting snacks meals
      userSnapshot.reference
          .collection("Snacks")
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        getCategoryMeals(
          mealsList: snacksMeals,
          event: event,
          day: day,
        );
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
        if (DateTime.parse(element.doc.data()!['dateTime']).day == day &&
            !mealsIds.contains(element.doc.id)) {
          // New meal
          if (mealIndex == -1) {
            mealsList.add(
                MealModel.fromFireStore(element.doc.data()!, element.doc.id));
            meals.add(mealsList.last);
            updateCaloriesConsumed(
                mealsList: mealsList, calories: meals.last.mealCalories);
          }
          // Undo meal
          else {
            mealsList.insert(mealIndex,
                MealModel.fromFireStore(element.doc.data()!, element.doc.id));
            meals.insert(mealIndex, mealsList.elementAt(mealIndex));
            updateCaloriesConsumed(
                mealsList: mealsList,
                calories: meals.elementAt(mealIndex).mealCalories);
          }
          mealsIds.add(element.doc.id);
        }
      }
    }
    emit(GetMealsSuccessState());
  }

  void updateCaloriesConsumed(
      {required List<MealModel> mealsList, required int calories}) {
    caloriesConsumed += calories;
    if (mealsList == breakFastMeals) {
      categoryCaloriesConsumed[0] += calories;
    } else if (mealsList == lunchMeals) {
      categoryCaloriesConsumed[1] += calories;
    } else if (mealsList == dinnerMeals) {
      categoryCaloriesConsumed[2] += calories;
    } else {
      categoryCaloriesConsumed[3] += calories;
    }
  }

  MealModel? deletedMeal;

  void deleteMeal({required int index, required MealModel meal}) {
    if (selectedCategoryIndex == 0) {
      categoryCaloriesConsumed[0] -= meal.mealCalories;
      breakFastMeals.removeAt(index);
    } else if (selectedCategoryIndex == 1) {
      categoryCaloriesConsumed[1] -= meal.mealCalories;
      lunchMeals.removeAt(index);
    } else if (selectedCategoryIndex == 2) {
      categoryCaloriesConsumed[2] -= meal.mealCalories;
      dinnerMeals.removeAt(index);
    } else {
      categoryCaloriesConsumed[3] -= meal.mealCalories;
      snacksMeals.removeAt(index);
    }
    meals.removeAt(index);
    mealsIds.removeAt(index);
    deletedMeal = meal;
    caloriesConsumed -= meal.mealCalories;
    mealIndex = index;
    emit(DeleteMealLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUserID)
        .collection(selectedCategory)
        .doc(meal.mealID)
        .delete()
        .then((value) {
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
        .collection(selectedCategory)
        .doc()
        .set(deletedMeal!.toMap())
        .then((value) {
      mealIndex = -1;
      emit(UndoDeleteMealSuccessState());
    }).catchError((error) {
      emit(UndoDeleteMealErrorState());
    });
  }

  void clearUserData() {
    breakFastMeals.clear();
    lunchMeals.clear();
    dinnerMeals.clear();
    snacksMeals.clear();
    meals.clear();
    mealsIds.clear();
    userLogged = null;
    caloriesConsumed = 0;
    mealIndex = -1;
    selectedCategoryIndex = 0;
    isCategorySelected = false;
    categoryCaloriesConsumed = [0, 0, 0, 0];
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
    snacksMeals.clear();
    meals.clear();
    mealsIds.clear();
    categoryCaloriesConsumed = [0, 0, 0, 0];
    caloriesConsumed = 0;
    categoryOpacity = 1;
    isCategorySelected = false;
    if (subscription != null) {
      subscription!.cancel();
    }
    await getMealsList(day: days[index].day);
    emit(ChangeSelectedDateSuccessState());
  }

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
  String selectedCategory = '';

  void getCurrentCategoryMeals() {
    meals.clear();
    if (selectedCategoryIndex == 0) {
      meals.addAll(breakFastMeals);
      selectedCategory = 'Breakfast';
    } else if (selectedCategoryIndex == 1) {
      meals.addAll(lunchMeals);
      selectedCategory = 'Lunch';
    } else if (selectedCategoryIndex == 2) {
      meals.addAll(dinnerMeals);
      selectedCategory = 'Dinner';
    } else {
      selectedCategory = 'Snacks';
      meals.addAll(snacksMeals);
    }
  }
}
