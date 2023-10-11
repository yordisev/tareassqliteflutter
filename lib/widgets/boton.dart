import 'package:alarmasqlite/config/temas.dart';
import 'package:flutter/material.dart';

class BotonWid extends StatelessWidget {
  final String nombre;
  final Function()? opTap;

  const BotonWid({super.key, required this.nombre, required this.opTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: opTap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: primaryCtUr),
        child: Center(
          child: Text(
            nombre,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
