import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/Common/MyBackButton.dart';
import 'package:sahha_app/Common/MyProfileMenuWidget.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/HomeBody.dart';

class Profile extends StatefulWidget {
  final StreamController<bool> loginStreamController;
  Profile({
    super.key,
    required this.loginStreamController,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // late StreamController<bool> loginStreamController;

  // @override
  // void initState() {
  //   super.initState();
  //   loginStreamController = StreamController<bool>();
  // }

  // @override
  // void dispose() {
  //   loginStreamController.close();
  //   super.dispose();
  // }

  void logout(StreamController<bool>? loginStreamController) {
    // Perform any necessary logout operations, such as clearing user data, etc.

    // Emit false through the stream to indicate that the user is logged out
    setState(() {
      // Update any necessary state
      modeAdmin = false;
      isLoggedIN = false;
    });
    widget.loginStreamController!.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          OnTapFunction: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeBody(
                        loginStreamController: widget.loginStreamController)));
          },
        ),
        title: Text(
          'Profile',
          style: SihhaPoppins3,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const Image(
                            image: AssetImage('assets/Etchiali.jpeg'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: SihhaGreen1),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                '${familyName}' + ' ' + '${name}',
                style: SihhaPoppins3,
              ),
//TODO: hna n9dro nzido les info t7t le nom direct par example addresse wla tlf wla dare de naissance
              const SizedBox(height: 20),

              /// -- BUTTON
              // SizedBox(
              //   width: 200,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: SihhaGreen1,
              //         side: BorderSide.none,
              //         shape: const StadiumBorder()),
              //     child: Text(
              //       "Modifier le  profile",
              //       textAlign: TextAlign.center,
              //       style: GoogleFonts.poppins(
              //         color: HexColor("f8f8f8"),
              //         fontSize: 14,
              //         letterSpacing: 1,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30),
              const Divider(thickness: 0.5),
              const SizedBox(height: 10),

              /// -- MENU
              MyProfileMenuWidget(
                  title: "informations personnelles",
                  icon: CupertinoIcons.person_fill,
                  onPress: () {}),
              MyProfileMenuWidget(
                  title: "Settings",
                  icon:
                      // LineAwesomeIcons.cog,
                      CupertinoIcons.settings_solid,
                  onPress: () {}),
              Visibility(
                visible: isAdmin,
                child: MyProfileMenuWidget(
                    title: "Administration",
                    icon: CupertinoIcons.chevron_left_slash_chevron_right,
                    // LineAwesomeIcons.user_check,
                    onPress: () {}),
              ),
              const Divider(thickness: 0.5),
              const SizedBox(height: 10),
              MyProfileMenuWidget(
                  title: "Support", icon: CupertinoIcons.info, onPress: () {}),
              MyProfileMenuWidget(
                title: "Déconnecter",
                icon: Icons.logout,
                // LineAwesomeIcons.alternate_sign_out,
                textColor: CupertinoColors.systemRed,
                endIcon: false,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("LOGOUT"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              // Perform logout operations
                              logout(widget.loginStreamController);
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("Yes"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
