import 'package:flutter/material.dart';

class InheritedMeal extends InheritedWidget {
  InheritedMeal({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  late int calorias;

  static InheritedMeal of(BuildContext context) {
    final InheritedMeal? result =
        context.dependOnInheritedWidgetOfExactType<InheritedMeal>();
    assert(result != null, 'No InheritedMeal found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedMeal oldWidget) => true;
}
