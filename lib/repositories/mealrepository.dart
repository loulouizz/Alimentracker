import 'dart:collection';

import 'package:alimentracker/data/db.dart';
import 'package:alimentracker/model/meal_widget.dart';
import 'package:alimentracker/models/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class MealRepository extends ChangeNotifier{

  late Database db;

  List<Meal> _todaysMeals = [];

  UnmodifiableListView<Meal> get todaysMeals => UnmodifiableListView(_todaysMeals);

  int get todaysCalories{
    int calories = 0;

    _todaysMeals.forEach((meal) {
      calories += meal.kcal;
    });

    return calories;
  }

  MealRepository(){
    _initRepository();
  }

  _initRepository() async{
    await _getList();
  }

  updateList(){
    _getList();
    notifyListeners();
  }

  _getList() async{
    db = await DB.instance.database;
    List mealList = await db.rawQuery('SELECT * FROM meal');
    mealList.forEach((meal) {
      _todaysMeals.add(Meal(name: meal['nome'] ?? "vazio", kcal: meal['calorias'] ?? "vazio", conteudo: meal['conteudo'] ?? "vazio", horario: meal['horario'] ?? "vazio", data:  meal['data'] ?? "vazio"));
    });
    notifyListeners();
  }
}