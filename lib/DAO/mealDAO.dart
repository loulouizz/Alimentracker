import 'package:alimentracker/model/meal_widget.dart';
import 'package:flutter/material.dart';

class MealDAO{
  List mealList = [
    MealWidget(name: "name", kcal: 100, conteudo: "conteudo", horario: "00:00"),
    IconButton(onPressed: (){}, icon: Icon(Icons.add))
  ];

  void Create(String name, int kcal, String conteudo, String horario){
    MealWidget m = MealWidget(name: name, kcal: kcal, conteudo: conteudo, horario: horario);
    mealList.add(m);
  }


}