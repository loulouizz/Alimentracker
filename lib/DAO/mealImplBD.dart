import 'package:alimentracker/DAO/mealDAO.dart';
import 'package:alimentracker/data/db.dart';
import 'package:alimentracker/models/meal.dart';
import 'package:alimentracker/repositories/mealrepository.dart';
import 'package:sqflite/sqflite.dart';

class MealImplDB implements MealDAO{

  @override
  void create(Meal m) async {
    Database db = await DB.instance.database;
    int id = await db.rawInsert(
      'INSERT into meal(nome, calorias, data, horario, conteudo) VALUES (?, ?, ?, ?, ?)',
      [m.name, m.kcal, m.data, m.horario, m.conteudo],
    );
    MealRepository().updateList();
    print("ID of the inserted meal: $id");
  }

  @override
  void delete(Meal m) {
    // TODO: implement delete
  }

  @override
  void list() {
    // TODO: implement list
  }

  @override
  void read(Meal m) {
    // TODO: implement read
  }

  @override
  void update(Meal m) {
    // TODO: implement update
  }

}