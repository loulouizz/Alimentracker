import 'package:alimentracker/DAO/mealImplBD.dart';
import 'package:alimentracker/model/meal_widget.dart';
import 'package:alimentracker/models/meal.dart';
import 'package:alimentracker/repositories/mealrepository.dart';
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
  TextEditingController conteudoEC = TextEditingController();
  TextEditingController dataEC = TextEditingController();

  MealRepository mealRepository = MealRepository();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(36, 32, 32, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            MealWidget(name: "Café da manhã", kcal: 100, conteudo: "1 pão com 2 ovos", horario: "7:10"),
            /*ListView.builder(
                itemCount: mealRepository.todaysMeals.length,
                itemBuilder: (context, index){
                  List<Meal> mealList = mealRepository.todaysMeals;
                  return MealWidget(name: mealList[index].name, kcal: mealList[index].kcal, conteudo: "", horario: mealList[index].horario);
                })*/
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: _addMealDialog, child: Icon(Icons.add, color: Colors.white,), backgroundColor: Colors.black,),
      );
  }

  _addMealDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.black),
        child: AlertDialog(
          backgroundColor: Colors.grey,
          content: SingleChildScrollView( // Envolve o conteúdo com um SingleChildScrollView
            child: Container(
              height: 312,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nome"),
                  TextField(
                    controller: nomeEC,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                  Text("Descrição"),
                  TextField(
                    controller: descricaoEC,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                  Text("Horário"),
                  TextField(
                    controller: horarioEC,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                  Text("Calorias"),
                  TextField(
                    controller: caloriasEC,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Meal m = Meal(name: nomeEC.text, kcal: int.parse(caloriasEC.text), conteudo: conteudoEC.text, horario: '10:00:00', data: '2023-08-18');
                MealImplDB().create(m);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text("Adicionar"),
            )
          ],
        ),
      );
    });
  }


}
