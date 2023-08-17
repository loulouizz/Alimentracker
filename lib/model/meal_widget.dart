import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Meal_Widget extends StatefulWidget {
  final String name;
  final int kcal;
  final String conteudo;
  final String horario;

  const Meal_Widget({required this.name, required this.kcal, required this.conteudo, required this.horario, Key? key})
      : super(key: key);

  @override
  State<Meal_Widget> createState() => _Meal_WidgetState();
}

class _Meal_WidgetState extends State<Meal_Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(57, 57, 57, 1), borderRadius: BorderRadius.circular(20)),
          width: 300,
          height: 72,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                  ],
                )),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${widget.kcal} kcal", style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                    Text(widget.horario, style: GoogleFonts.lato(color: Colors.white, fontSize: 20)),
                  ],
                )),
              ],
            ),
          )
        ),
      ),
    );
  }
}
