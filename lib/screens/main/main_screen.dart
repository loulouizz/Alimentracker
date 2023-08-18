import 'package:alimentracker/model/meal_widget.dart';
import 'package:alimentracker/screens/main/header.dart';
import 'package:flutter/material.dart';
import 'package:alimentracker/my_widgets/my_animated_icon_button.dart';
import 'package:alimentracker/DAO/mealDAO.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isPressed = false;

  TextEditingController nomeEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController horarioEC = TextEditingController();
  TextEditingController caloriasEC = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(36, 32, 32, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            MealWidget(name: "Café da manhã", kcal: 100, conteudo: "1 pão com 2 ovos", horario: "7:10"),
            MyAnimatedIconButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: _addMealDialog, child: Icon(Icons.add, color: Colors.white,), backgroundColor: Colors.black,),
      );
  }

  _addMealDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content:  Column(
          children: [
            Text("Nome"),
            TextField(
              controller: nomeEC,
            ),

            Text("Descrição"),
            TextField(
              controller: descricaoEC,
            ),

            Text("Horário"),
            TextField(
              controller: horarioEC,
            ),

            Text("Calorias"),
            TextField(
              controller: caloriasEC,
            ),
          ],
        ),
      );
    });
  }
}
