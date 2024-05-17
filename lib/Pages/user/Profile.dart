import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfileMenuWidget.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';
import 'package:sahha_app/Providers/DesktopNavigationProvider.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference<Map<String, dynamic>> _reference =
      FirebaseFirestore.instance.collection('users');

  // Add a boolean variable to track if the image is being uploaded
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          onTapFunction: () {
            print("User Pressed on Back Button to  go back to the Home Page");
            Navigator.pop(
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
              ProfilePic2(),
              const SizedBox(height: 15),
              Text(
                '${user!.familyName} ${user!.name}',
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
              if (user!.isAdmin)
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
                              //TODO Add LastLogin field to users collection
                              DesktopNavigationProvider navigationProvider =
                                  Provider.of<DesktopNavigationProvider>(
                                      context,
                                      listen: false);
                              navigationProvider.setSelectedIndex(1);
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

  Stack ProfilePic() {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _isUploading
                ? Center(
                    child: CircularProgressIndicator(color: SihhaGreen1),
                  )
                : user!.profilePicUrl == ''
                    ? ColoredBox(
                        color: HexColor('e4e6e7'),
                        child: Icon(
                          CupertinoIcons.person_fill,
                          size: 100,
                          color: HexColor('aeb4b7'),
                        ),
                      )
                    : Image.network(user!.profilePicUrl!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: SihhaGreen1.withOpacity(0.85),
            ),
            child: IconButton(
              alignment: Alignment.center,
              onPressed: PickAndUpload,
              icon: Icon(
                LineAwesomeIcons.alternate_pencil,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  PickAndUpload() async {
    setState(() {
      _isUploading = true; // Show loading indicator
    });

    //Pick the image
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print('PICKED FILE PATH : ${pickedFile?.path}');
    if (pickedFile == null) {
      setState(() {
        _isUploading = false; // Hide loading indicator
      });
      return;
    }

    //Get the ref
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirProfilePics = referenceRoot.child("ProfilePics");
    Reference referenceImageToUploaod =
        referenceDirProfilePics.child("${user!.familyName}_${user!.name}.jpeg");

    print(user!.documentId.toString());

    try {
      //Upload to Firebase Storage
      await referenceImageToUploaod.putFile(File(pickedFile.path));
      // Get the download URL and update it in Firestore Database
      String url = await referenceImageToUploaod.getDownloadURL();
      user!.updateProfilePicUrl(url);
      print(user!.profilePicUrl);
      Map<String, dynamic> dataToUpload = {
        'profilePicUrl': user!.profilePicUrl.toString(),
      };
      //Update User Data in Firestore
      await _reference.doc(user!.documentId).update(dataToUpload);
    } catch (e) {
      print('error while uploading : $e');
    }

    setState(() {
      _isUploading = false; // Hide loading indicator
    });
  }

  Stack ProfilePic2() {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _isUploading
                ? Center(
                    child: CircularProgressIndicator(color: SihhaGreen1),
                  )
                : user!.profilePicUrl == null || user!.profilePicUrl!.isEmpty
                    ? ColoredBox(
                        color: Colors.grey.shade100,
                        child: Icon(
                          CupertinoIcons.person_fill,
                          size: 100,
                          color: HexColor('aeb4b7'),
                        ),
                      )
                    : Image.network(
                        user!.profilePicUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return ColoredBox(
                            color: Colors.grey.shade100,
                            child: Icon(
                              CupertinoIcons.exclamationmark_triangle,
                              size: 100,
                              color: Colors.red.shade100,
                            ),
                          );
                        },
                      ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: SihhaGreen1.withOpacity(0.85),
            ),
            child: IconButton(
              alignment: Alignment.center,
              onPressed: () async {
                setState(() {
                  _isUploading = true; // Show loading indicator
                });

                // Pick the image
                ImagePicker imagePicker = ImagePicker();
                XFile? pickedFile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('PICKED FILE PATH : ${pickedFile?.path}');
                if (pickedFile == null) {
                  setState(() {
                    _isUploading = false; // Hide loading indicator
                  });
                  return;
                }

                // Get the ref
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirProfilePics =
                    referenceRoot.child("ProfilePics");
                Reference referenceImageToUpload = referenceDirProfilePics
                    .child("${user!.familyName}_${user!.name}.jpeg");

                print(documentId.toString());

                try {
                  // Upload to Firebase Storage
                  await referenceImageToUpload.putFile(File(pickedFile.path));
                  // Get the download URL and update it in Firestore Database
                  String url = await referenceImageToUpload.getDownloadURL();
                  user!.updateProfilePicUrl(url);
                  print(user!.profilePicUrl);
                  Map<String, dynamic> dataToUpload = {
                    'profilePicUrl': user!.profilePicUrl.toString(),
                  };
                  // Update User Data in Firestore
                  await _reference.doc(user!.documentId).update(dataToUpload);
                } catch (e) {
                  print(e);
                }

                setState(() {
                  _isUploading = false; // Hide loading indicator
                });
              },
              icon: Icon(
                LineAwesomeIcons.alternate_pencil,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
