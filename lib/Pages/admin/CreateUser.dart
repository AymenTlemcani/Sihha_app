import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahha_app/Common/MyBackButton.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/HomeBody.dart';

class CreateUser extends StatelessWidget {
  final StreamController<bool> loginStreamController;
  const CreateUser({super.key, required this.loginStreamController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Créer un compte',
          style: SihhaPoppins3,
        ),
        leading: MyBackButton(
          OnTapFunction: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeBody(loginStreamController: loginStreamController),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: []),
      ),
    );
  }
}
