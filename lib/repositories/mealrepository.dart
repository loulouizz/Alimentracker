import 'dart:collection';

import 'package:alimentracker/model/meal_widget.dart';
import 'package:flutter/cupertino.dart';

class MealRepository extends ChangeNotifier{
  List<MealWidget> _todaysMeals = [];

  UnmodifiableListView<MealWidget> get todaysMeals => UnmodifiableListView(_todaysMeals);

  int get todaysCalories{
    int calories = 0;

    _todaysMeals.forEach((meal) {
      calories += meal.kcal;
    });

    return calories;
  }
}