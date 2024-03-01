import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Common/Persistent_nav.dart';
import 'package:sahha_app/Pages/LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return
                //
                PersistentTabSreen();
            // HomePage();
          }
          //user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
