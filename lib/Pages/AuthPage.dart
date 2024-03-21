// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sahha_app/Common/Variables.dart';
// import 'package:sahha_app/Pages/ActiveScreen.dart';
// import 'package:sahha_app/Pages/LoginPage.dart';

// class AuthPage extends StatefulWidget {
//   AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   late Stream<bool?> loginStream;

//   Stream<bool?> loginStatus() async* {
//     await Future.delayed(Duration(seconds: 1));
//     yield isLoggedIN;
//   }

//   @override
//   void initState() {
//     super.initState();
//     loginStream = loginStatus();
//   }

//   void refresh() {
//     setState(() {
//       isLoggedIN;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<bool?>(
//         stream: loginStream,
//         builder: (context, snapshot) {
//           //user is logged in
//           if (snapshot.hasData) {
//             isLoggedIN = snapshot.data!;
//             return isLoggedIN ? ActiveScreen() : LoginPage();

//             // HomePage();
//           }
//           //user is NOT logged in
//           else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/ActiveScreen.dart';
import 'package:sahha_app/Pages/LoginPage.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late StreamController<bool> _loginStreamController;
  late Stream<bool> _loginStream;

  @override
  void initState() {
    super.initState();
    _loginStreamController = StreamController<bool>();
    _loginStream = _loginStreamController.stream;
    _initializeLoginStatus();
  }

  void _initializeLoginStatus() {
    // Simulate async login status check
    Future.delayed(Duration(seconds: 1), () {
      _loginStreamController.add(isLoggedIN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: _loginStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return snapshot.data!
                ? ActiveScreen(loginStreamController: _loginStreamController)
                : LoginPage(loginStreamController: _loginStreamController);
          } else {
            return Container(); // Handle error case
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _loginStreamController.close();
    super.dispose();
  }
}
