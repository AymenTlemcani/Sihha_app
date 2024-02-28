import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

// sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signUserOut, icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Center(
          child: Text(
        'LOGGED IN AS : ' + user.email!,
        style: GoogleFonts.poppins(fontSize: 20),
      )),
    );
  }
}
