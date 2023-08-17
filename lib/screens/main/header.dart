import 'package:alimentracker/inherited_widgets/inherited_meal.dart';
import 'package:alimentracker/model/meal_widget.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 64, color: Colors.white),
                text: InheritedMeal.of(context).calorias.toString(),
                children: <TextSpan>[
                  TextSpan(
                    text: 'kcal',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 48, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
