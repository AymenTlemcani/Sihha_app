import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/utils/Variables.dart';
import 'package:sahha_app/Pages/user/ActiveScreen.dart';
import 'package:sahha_app/Pages/user/LoginPage.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Stream<bool> _loginStream;

  @override
  void initState() {
    super.initState();
    _initializeLoginStatus();
  }

  void _initializeLoginStatus() {
    final loginControllerProvider =
        Provider.of<LoginControllerProvider>(context, listen: false);
    _loginStream = loginControllerProvider.loginStreamController.stream;

    // Simulate async login status check
    Future.delayed(Duration(seconds: 1), () {
      loginControllerProvider.loginStreamController.add(isLoggedIN);
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
            return snapshot.data! ? ActiveScreen() : LoginPage();
          } else {
            return Container(); // Handle error case
          }
        },
      ),
    );
  }
}
