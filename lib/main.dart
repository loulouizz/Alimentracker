
import 'package:alimentracker/data/db.dart';
import 'package:alimentracker/repositories/mealrepository.dart';
import 'package:alimentracker/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => MealRepository(),
    child: MyApp(),),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MainScreen(),
    );
  }
}


