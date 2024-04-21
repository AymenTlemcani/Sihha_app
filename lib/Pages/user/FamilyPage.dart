import 'package:flutter/material.dart';
import 'package:sahha_app/utils/Variables.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor,
      body: Center(child: Text("Family")),
    );
  }
}
