import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  bool modeAdmin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.medium(
          backgroundColor: Color.fromARGB(255, 80, 150, 118),
          flexibleSpace: Row(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: GestureDetector(
                      onLongPress: () {
                        debugPrint("LOOOOOONG");
                      },
                      child: CircleAvatar(
                        foregroundImage: AssetImage('assets/Etchiali.jpeg'),
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
                visible: false,
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff1D1617).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 0.0)
                        ]),

                    width: 280,
                    height: 45,
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
                            focusColor: Color.fromARGB(200, 109, 206, 161),
                            activeColor: Color.fromARGB(255, 109, 206, 161),
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
          ),
          // leadingWidth: ,
          // title: ,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: signUserOut,
              color: Colors.white,
            ),
          ],
        )
      ]),
    );
  }
}
