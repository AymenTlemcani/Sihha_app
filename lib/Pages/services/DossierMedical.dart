import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';

class DossierMedical extends StatefulWidget {
  const DossierMedical({super.key});

  @override
  State<DossierMedical> createState() => _DossierMedicalState();
}

class _DossierMedicalState extends State<DossierMedical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor1,
      appBar: AppBar(
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => HomeBody(),
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Dossier Medical',
          style: SihhaPoppins3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
            child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    CupertinoIcons.share,
                    color: SihhaGreen2,
                    size: 27,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
