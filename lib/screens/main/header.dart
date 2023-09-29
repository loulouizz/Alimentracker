import 'package:alimentracker/data/MealService.dart';
import 'package:alimentracker/model/meal_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final _mealStream =
      FirebaseFirestore.instance.collection('meals').snapshots();

  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
          child: StreamBuilder(
              stream: MealService().getMealsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Connection error");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const Text("Loading..."));
                }

                final meals = snapshot.data!;
                final totalCalories = meals.fold<int>(0, (sum, meal) => sum + meal.kcal);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 64, color: Colors.white),
                        text: "${totalCalories}",
                        children: <TextSpan>[
                          TextSpan(
                            text: ' kcal',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
