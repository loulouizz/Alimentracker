import 'package:alimentracker/data/MealService.dart';
import 'package:alimentracker/model/meal_widget.dart';
import 'package:alimentracker/models/meal.dart';
import 'package:alimentracker/screens/main/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _mealStream = FirebaseFirestore.instance.collection('meals').snapshots();
  bool _isPressed = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  Timestamp _selectedTimestamp = Timestamp.now();

  List<Meal> todaysMeals = [];
  double totalKcal = 0;

  void _deleteMeal(BuildContext? context) {
    // Implementação da função
  }

  void _editMeal(BuildContext? context) {
    // Implementação da função
  }

  TextEditingController nomeEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController horarioEC = TextEditingController();
  TextEditingController caloriasEC = TextEditingController();
  TextEditingController conteudoEC = TextEditingController();
  TextEditingController dataEC = TextEditingController();

  FocusNode nomeFN = FocusNode();
  FocusNode conteudoFN = FocusNode();
  FocusNode horarioFN = FocusNode();
  FocusNode caloriasFN = FocusNode();


  @override
  void dispose() {
    nomeEC.dispose();
    descricaoEC.dispose();
    horarioEC.dispose();
    caloriasEC.dispose();
    conteudoEC.dispose();
    dataEC.dispose();

    nomeFN.dispose();
    conteudoFN.dispose();
    horarioFN.dispose();
    caloriasFN.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
              stream: _mealStream,
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Text("Connection error");
                }

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: const Text("Loading..."));
                }

                var docs = snapshot.data!.docs;


                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Header(),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index){
                            return MealWidget(id: docs[index].id, name: docs[index]['name'], kcal: docs[index]['kcal'], conteudo: docs[index]['conteudo'], horario: docs[index]['horario'].toString().substring(0,5));
                          }),
                    ),
                  ],
                );
              },
            ),
        floatingActionButton: FloatingActionButton(onPressed: _addMealDialog, child: Icon(Icons.add, color: Colors.white,),),
      );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        horarioEC.text = _selectedTime.format(context);
      });
      print(_selectedTime.toString());
      FocusScope.of(context).requestFocus(caloriasFN);
    }
  }

  _addMealDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 322,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nome"),
                TextField(
                  focusNode: nomeFN,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: (){
                    FocusScope.of(context).requestFocus(conteudoFN);
                  },
                  controller: nomeEC,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                    ),
                  ),
                  cursorColor: Colors.white,
                ),
                Text("Conteúdo"),
                TextField(
                  focusNode: conteudoFN,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: (){
                    FocusScope.of(context).requestFocus(horarioFN);
                  },
                  controller: conteudoEC,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                    ),
                  ),
                  cursorColor: Colors.white,
                ),
                Text("Horário"),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextField(
                        enabled: false,
                        controller: horarioEC,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                          ),
                          focusedBorder: OutlineInputBorder(
                          ),
                          enabledBorder: OutlineInputBorder(
                          ),
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8,),
                    Flexible(flex: 1, child: AspectRatio(aspectRatio: 1, child: ElevatedButton(focusNode: horarioFN, style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black87)), onPressed: ()=>_selectTime(context), child: Icon(Icons.timer_sharp),)))
                  ],
                ),
                Text("Calorias"),
                TextField(
                  focusNode: caloriasFN,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: caloriasEC,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
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
              print("nomeEC.text: ${nomeEC.text}");
              print("conteudoEC.text: ${conteudoEC.text}");
              Meal m = Meal(name: nomeEC.text, kcal: int.parse(caloriasEC.text), conteudo: conteudoEC.text, horario: "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}", data: '29/09/2023');
              MealService().addMeal(m);
              Navigator.of(context).pop();
              try{
              } catch(e){
                print("Excessão ao salvar: $e");
              } finally {
                nomeEC.clear();
                conteudoEC.clear();
                horarioEC.clear();
                caloriasEC.clear();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text("Adicionar"),
          )
        ],
      );
    });
  }


}
