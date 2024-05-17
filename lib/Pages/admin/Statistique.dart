import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class Statistique extends StatefulWidget {
  const Statistique({super.key});

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Statistique',
        style: SihhaPoppins3,
      )),
    );
  }
}
