import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/Common/MyBackButton.dart';
import 'package:sahha_app/Common/MyProfileMenuWidget.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          onTapFunction: () {
            print("User Pressed on Back Button to  go back to the Home Page");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeBody(),
              ),
            );
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
              // -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const Image(
                        image: AssetImage('assets/Etchiali.jpeg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: SihhaGreen1,
                      ),
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
                '${familyName} ${name}',
                style: SihhaPoppins3,
              ),
              const SizedBox(height: 20),

              // -- MENU
              MyProfileMenuWidget(
                title: "Informations personnelles",
                icon: Icons.person,
                onPress: () {},
              ),
              MyProfileMenuWidget(
                title: "Settings",
                icon: Icons.settings,
                onPress: () {},
              ),
              if (isAdmin)
                MyProfileMenuWidget(
                  title: "Administration",
                  icon: Icons.admin_panel_settings,
                  onPress: () {},
                ),
              const Divider(thickness: 0.5),
              const SizedBox(height: 10),
              MyProfileMenuWidget(
                title: "Support",
                icon: Icons.info,
                onPress: () {},
              ),
              MyProfileMenuWidget(
                title: "Déconnecter",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Déconnexion"),
                        content:
                            Text("Voulez-vous vraiment vous déconnecter ?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<LoginControllerProvider>(
                                context,
                                listen: false,
                              ).logout();
                              Navigator.of(context).pop();
                            },
                            child: Text("Oui"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Non"),
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
