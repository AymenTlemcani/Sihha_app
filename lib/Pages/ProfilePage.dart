import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  bool modeAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        body: SingleChildScrollView(
            child:
                //Column ta3 ga3 LPAGA
                Column(children: [
          //APP BAR LI BELKHDAR FIHA PHOTO DE PROFILE W LOGOUT BUTTON W USERNAME
          Transform.translate(
            offset: Offset(0, 0),
            child: Container(
                height: MediaQuery.of(context).size.height * .28,
                width: double.infinity,
                color: Color.fromARGB(255, 80, 150, 118),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //STAR LWL FIH LOGOUT BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                          child: IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: signUserOut,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    //STAR ZAWJ FIH  USERNAME W PHOTO PROFILE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: GestureDetector(
                            onLongPress: () {
                              debugPrint("LOOOOOONG");
                            },
                            child: CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/Etchiali.jpeg'),
                              radius: 45,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform.translate(
                            offset: Offset(0, 0),
                            child: Text(
                              //USERNAME
                              'etchiali.abdelhak',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Visibility(
                      visible: true,
                      child: Transform.translate(
                        offset: Offset(0, 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff1D1617)
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 0.0)
                              ]),

                          width: 280,
                          height: 40,
                          // color: Colors.white,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Mode Admin',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(width: 100),
                                CupertinoSwitch(
                                  focusColor:
                                      Color.fromARGB(200, 109, 206, 161),
                                  activeColor:
                                      Color.fromARGB(255, 109, 206, 161),
                                  value: modeAdmin,
                                  onChanged: (value) {
                                    setState(() {
                                      modeAdmin = value;
                                    });
                                    debugPrint("ADMIN MODE : " +
                                        (modeAdmin.toString()).toUpperCase());
                                  },
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ] //
                    )));
  }
}
