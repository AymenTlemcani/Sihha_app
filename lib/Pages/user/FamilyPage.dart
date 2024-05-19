import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahha_app/Models/Variables.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Famille',
            style: SihhaPoppins2,
          ),
        ),
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "FamilyPage.dart /* NOT DONE*/",
          style: SihhaPoppins3,
        ),
      ),
    );
  }
}
