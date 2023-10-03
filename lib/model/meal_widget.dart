
import 'package:alimentracker/data/MealService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class MealWidget extends StatelessWidget {
  final String id;
  final String name;
  final int kcal;
  final String conteudo;
  final String horario;

  MealWidget({required this.id, required this.name, required this.kcal, required this.conteudo, required this.horario});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => {
                  MealService().deleteMeal(id)
                },
                icon: Icons.delete,
                backgroundColor: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(57, 57, 57, 1), borderRadius: BorderRadius.circular(20)),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, overflow: TextOverflow.fade, maxLines: 1, style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                      Text(conteudo, overflow: TextOverflow.fade, maxLines: 2,  style: GoogleFonts.lato(color: Colors.white, fontSize: 12)),
                    ],
                  )),
                  Expanded(flex: 1, child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$kcal kcal", style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                      Text(horario, style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                    ],
                  )),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
