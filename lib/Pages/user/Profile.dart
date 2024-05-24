import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';
import 'package:sahha_app/Providers/DesktopNavigationProvider.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';
import 'package:sahha_app/Providers/ModeProvider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference<Map<String, dynamic>> _reference =
      FirebaseFirestore.instance.collection('users');

  // Add a boolean variable to track if the image is being uploaded
  // ignore: unused_field
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginControllerProvider>(context);
    // User? user = loginProvider.user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: !Platform.isWindows
          ? AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: Text(
                            "Déconnexion",
                            style: SihhaFont,
                          ),
                          content: Text(
                            "Voulez-vous vraiment vous déconnecter ?",
                            style: SihhaFont,
                          ),
                          actions: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.read<ModeProvider>().turnOffAllModes();
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
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: SihhaGreen2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Oui',
                                      style: SihhaFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CupertinoColors.systemRed,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Non',
                                      style: SihhaFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //   ElevatedButton(
                            //     onPressed: () {
                            //       //TODO Add LastLogin field to users collection
                            //       DesktopNavigationProvider navigationProvider =
                            //           Provider.of<DesktopNavigationProvider>(
                            //               context,
                            //               listen: false);
                            //       navigationProvider.setSelectedIndex(1);
                            //       Provider.of<LoginControllerProvider>(
                            //         context,
                            //         listen: false,
                            //       ).logout();
                            //       Navigator.of(context).pop();
                            //     },
                            //     child: Text(
                            //       "Oui",
                            //       style: SihhaFont,
                            //     ),
                            //   ),
                            //   OutlinedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //     child: Text(
                            //       "Non",
                            //       style: SihhaFont,
                            //     ),
                            //   ),
                          ],
                        );
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        // width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          // color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   'Déconnecter',
                              //   style: SihhaFont.copyWith(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  CupertinoIcons.square_arrow_right,
                                  color: CupertinoColors.systemRed,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              leading: MyBackButton(
                onTapFunction: () {
                  print(
                      "User Pressed on Back Button to  go back to the Home Page");
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeBody(),
                    ),
                  );
                },
              ),
              surfaceTintColor: Colors.white,
              elevation: 0.5,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.white,
              shadowColor: Colors.black54,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Profile',
                style: SihhaPoppins3,
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (!Platform.isWindows) ...[
              Transform.translate(
                offset: Offset(-50, 0),
                child: CustomPaint(
                  size: Size(
                      250,
                      (250 * 1.6666666666666667)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
              ),
            ],
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- IMAGE
                  if (!Platform.isWindows) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfilePicWithEditButton(),
                          SizedBox(height: 10),
                          Text(
                            '${globalUser!.familyName} ${globalUser!.name}',
                            style: SihhaPoppins3,
                          ),
                          Text(
                            '#${globalUser!.IDN}',
                            style: SihhaPoppins3.copyWith(
                                fontSize: 16, color: Colors.black54),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 15,
                      // width: double.infinity,
                      color: SihhaGreen1.withOpacity(0.1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ModeToggles(context),
                    )

                    // _buildDetailsTab(),
                    //
                    // const SizedBox(height: 15),
                  ],
                  if (Platform.isWindows) ...[
                    _AppBarDesktop(),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: double.infinity,
                      // color: Colors.amber,
                      child: ModeToggles(context),
                    )
                  ],

                  // const SizedBox(height: 20),

                  //   // -- MENU
                  //   MyProfileMenuWidget(
                  //     title: "Informations personnelles",
                  //     icon: Icons.person,
                  //     onPress: () {},
                  //   ),
                  //   MyProfileMenuWidget(
                  //     title: "Settings",
                  //     icon: Icons.settings,
                  //     onPress: () {},
                  //   ),
                  //   if (globalUser!.isAdmin)
                  //     MyProfileMenuWidget(
                  //       title: "Administration",
                  //       icon: Icons.admin_panel_settings,
                  //       onPress: () {},
                  //     ),
                  //   const Divider(thickness: 0.5),
                  //   const SizedBox(height: 10),
                  //   MyProfileMenuWidget(
                  //     title: "Support",
                  //     icon: Icons.info,
                  //     onPress: () {},
                  //   ),
                  // MyProfileMenuWidget(
                  //   title: "Déconnecter",
                  //   icon: Icons.logout,
                  //   textColor: Colors.red,
                  //   endIcon: false,
                  //   onPress: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text("Déconnexion"),
                  //           content:
                  //               Text("Voulez-vous vraiment vous déconnecter ?"),
                  //           actions: [
                  //             ElevatedButton(
                  //               onPressed: () {
                  //                 //TODO Add LastLogin field to users collection
                  //                 DesktopNavigationProvider navigationProvider =
                  //                     Provider.of<DesktopNavigationProvider>(
                  //                         context,
                  //                         listen: false);
                  //                 navigationProvider.setSelectedIndex(1);
                  //                 Provider.of<LoginControllerProvider>(
                  //                   context,
                  //                   listen: false,
                  //                 ).logout();
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text("Oui"),
                  //             ),
                  //             OutlinedButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text("Non"),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column ModeToggles(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: globalUser!.isAdmin,
          child: CupertinoListTile(
            title: Text(
              "Mode Admin",
              style: SihhaFont.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            trailing: CupertinoSwitch(
              activeColor: SihhaGreen2,
              value: context.watch<ModeProvider>().modeAdmin,
              onChanged: (bool value) {
                context.read<ModeProvider>().toggleAdmin();
              },
            ),
          ),

          // SwitchListTile(
          //   // inactiveThumbColor: amber,
          //   splashRadius: 0,
          //   activeColor: SihhaGreen2,
          //   hoverColor: SihhaGreen1.withOpacity(0.18),
          //   title: Text(
          //     "Mode Admin",
          //     style: SihhaFont.copyWith(
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black87),
          //   ),
          //   value: context.watch<ModeProvider>().modeAdmin,
          //   onChanged: (bool value) {
          //     context.read<ModeProvider>().toggleAdmin();
          //   },
          // ),
        ),
        Visibility(
          visible: globalUser!.isMedcin,
          child: CupertinoListTile(
            title: Text(
              "Mode Médecin",
              style: SihhaFont.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            trailing: CupertinoSwitch(
              activeColor: SihhaGreen2,
              value: context.watch<ModeProvider>().modeMedcin,
              onChanged: (bool value) {
                context.read<ModeProvider>().toggleMedcin();
              },
            ),
          ),
          // SwitchListTile(
          //   title: Text(
          //     "Mode Médecin",
          //     style: SihhaFont.copyWith(
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black87),
          //   ),
          //   value: context.watch<ModeProvider>().modeMedcin,
          //   onChanged: (bool value) {
          //     context.read<ModeProvider>().toggleMedcin();
          //   },
          // ),
        ),
        Visibility(
          visible: globalUser!.isPharmacien,
          child: CupertinoListTile(
            title: Text(
              "Mode Pharmacien",
              style: SihhaFont.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            trailing: CupertinoSwitch(
              activeColor: SihhaGreen2,
              value: context.watch<ModeProvider>().modePharmacie,
              onChanged: (bool value) {
                context.read<ModeProvider>().togglePharmacie();
              },
            ),
          ),

          // SwitchListTile(
          //   title: Text(
          //     "Mode Pharmacien",
          //     style: SihhaFont.copyWith(
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.black87),
          //   ),
          //   value:
          //       context.watch<ModeProvider>().modePharmacie,
          //   onChanged: (bool value) {
          //     context.read<ModeProvider>().togglePharmacie();
          //   },
          // ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Expanded(
        //   child:
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  // border: Border.all(color: SihhaGreen1.withOpacity(0.5)),
                  color: SihhaGreen1.withOpacity(0.18),
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: _buildUserInfo()),
        ),
        // ),
        Container(
          height: 5,
          // color: Colors.black,
        )
      ],
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsLine(
            'Nom : ${globalUser!.familyName} \nPrenom : ${globalUser!.name}',
            Colors.black,
            LineAwesomeIcons.identification_card,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${globalUser!.birthDate!.toDate().day} . ${globalUser!.birthDate!.toDate().month} . ${globalUser!.birthDate!.toDate().year}    |     ${(DateTime.now().year - (globalUser!.birthDate!.toDate().year))} ans',
            Colors.black,
            LineAwesomeIcons.birthday_cake,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${globalUser!.birthPlace ?? 'N/A'}',
            Colors.black,
            LineAwesomeIcons.map_marker,
          ),
          SizedBox(height: 16),
          DetailsLine(
            globalUser!.gender != null && globalUser!.gender == 'male'
                ? '${globalUser!.gender ?? 'N/A'}'
                : '${globalUser!.gender ?? 'N/A'}',
            Colors.black,
            globalUser!.gender != null && globalUser!.gender == 'male'
                ? LineAwesomeIcons.male
                : LineAwesomeIcons.female,
          ),
          SizedBox(height: 16),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.amber,
                width: 120,
                child: DetailsLine(
                  '${globalUser!.weights?.last ?? 'null' + '  Kg'}',
                  Colors.black,
                  LineAwesomeIcons.hanging_weight,
                ),
              ),
              Container(
                // color: Colors.amber,
                width: 120,
                child: DetailsLine(
                  '${globalUser!.heights?.last ?? 'null' + '  cm'}',
                  Colors.black,
                  LineAwesomeIcons.ruler,
                ),
              ),
              Container(
                // color: Colors.amber,
                width: 84,
                child: DetailsLine(
                  // '${globalUser!.bloodType ?? 'O+'}',

                  '${globalUser!.bloodGroup}',
                  Colors.black,
                  LineAwesomeIcons.tint,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Container DetailsLine(String text, Color textColor, IconData icon) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: Icon(
                icon,
                size: 30,
                color: SihhaGreen2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: SihhaFont.copyWith(fontSize: 17, color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Stack ProfilePicWithEditButton() {
    return Stack(
      children: [
        MyProfilePicture2(
          URL: globalUser!.profilePicUrl,
          frameRadius: 74,
          pictureRadius: 70,
          iconSize: 80,
          borderColor: SihhaGreen2,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: SihhaGreen2.withOpacity(1),
            ),
            child: IconButton(
              alignment: Alignment.center,
              onPressed: PickAndUpload,
              icon: Icon(
                // CupertinoIcons.pencil_outline,
                CupertinoIcons.photo_camera_solid,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  PickAndUpload() async {
    // final loginProvider = Provider.of<LoginControllerProvider>(context);
    // User? user = loginProvider.user;
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
    Reference referenceImageToUploaod = referenceDirProfilePics
        .child("${globalUser!.familyName}_${globalUser!.name}.jpeg");

    print(globalUser!.documentId.toString());

    try {
      //Upload to Firebase Storage
      await referenceImageToUploaod.putFile(File(pickedFile.path));
      // Get the download URL and update it in Firestore Database
      String url = await referenceImageToUploaod.getDownloadURL();
      globalUser!.profilePicUrl = url;
      // user!.updateProfilePicUrl(url);
      print(globalUser!.profilePicUrl);
      Map<String, dynamic> dataToUpload = {
        'profilePicUrl': globalUser!.profilePicUrl.toString(),
      };
      //Update User Data in Firestore
      await _reference.doc(globalUser!.documentId).update(dataToUpload);
    } catch (e) {
      print('error while uploading : $e');
    }

    setState(() {
      _isUploading = false; // Hide loading indicator
    });
  }

  Container _AppBarDesktop() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.black12.withOpacity(0.03),
        //       spreadRadius: 2,
        //       blurRadius: 50,
        //       offset: Offset(0, 100))
        // ],
        borderRadius: BorderRadius.circular(8),
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        shape: BoxShape.rectangle,
        // image: DecorationImage(
        //   image: AssetImage("assets/back3.png"),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Column(
          //
          crossAxisAlignment: CrossAxisAlignment.start,
          //
          children: [
            //back button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!Platform.isWindows) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 35),
                    child: MyBackButton(
                      onTapFunction: () {
                        print(
                            "User Pressed on Back Button to go back to the QR scan Page");
                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ),
                ],

                // Padding(
                //   padding: const EdgeInsets.only(left: 10, top: 25),
                //   child: Text(
                //       '${globalUser!.familyName} ${globalUser!.name}',
                //       style: SihhaPoppins3.copyWith(fontSize: 17)),
                // ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          title: Text(
                            "Déconnexion",
                            style: SihhaFont,
                          ),
                          content: Text(
                            "Voulez-vous vraiment vous déconnecter ?",
                            style: SihhaFont,
                          ),
                          actions: [
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.read<ModeProvider>().turnOffAllModes();
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
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: SihhaGreen2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Oui',
                                      style: SihhaFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CupertinoColors.systemRed,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Non',
                                      style: SihhaFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //   ElevatedButton(
                            //     onPressed: () {
                            //       //TODO Add LastLogin field to users collection
                            //       DesktopNavigationProvider navigationProvider =
                            //           Provider.of<DesktopNavigationProvider>(
                            //               context,
                            //               listen: false);
                            //       navigationProvider.setSelectedIndex(1);
                            //       Provider.of<LoginControllerProvider>(
                            //         context,
                            //         listen: false,
                            //       ).logout();
                            //       Navigator.of(context).pop();
                            //     },
                            //     child: Text(
                            //       "Oui",
                            //       style: SihhaFont,
                            //     ),
                            //   ),
                            //   OutlinedButton(
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //     child: Text(
                            //       "Non",
                            //       style: SihhaFont,
                            //     ),
                            //   ),
                          ],
                        );
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        // width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          // color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   'Déconnecter',
                              //   style: SihhaFont.copyWith(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  CupertinoIcons.square_arrow_right,
                                  color: CupertinoColors.systemRed,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: IconButton(
                //     onPressed:
                //     icon: Icon(CupertinoIcons.square_arrow_right_fill,
                //         color: CupertinoColors.systemRed),
                //   ),
                // )
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProfilePicWithEditButton(),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${globalUser!.familyName} ${globalUser!.name}',
                        style: SihhaPoppins3,
                      ),
                      Text(
                        '#${globalUser!.IDN}',
                        style: SihhaPoppins3.copyWith(
                            fontSize: 16, color: Colors.black54),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //
            SizedBox(height: 10),
          ]),
    );
  }

  // Stack ProfilePic2() {
  //   final loginProvider = Provider.of<LoginControllerProvider>(context);
  //   User? user = loginProvider.user;
  //   return Stack(
  //     children: [
  //       SizedBox(
  //         width: 120,
  //         height: 120,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(50),
  //           child: _isUploading
  //               ? Center(
  //                   child: CircularProgressIndicator(color: SihhaGreen1),
  //                 )
  //               : user!.profilePicUrl == null || user.profilePicUrl!.isEmpty
  //                   ? ColoredBox(
  //                       color: Colors.grey.shade100,
  //                       child: Icon(
  //                         CupertinoIcons.person_fill,
  //                         size: 100,
  //                         color: HexColor('aeb4b7'),
  //                       ),
  //                     )
  //                   : Image.network(
  //                       user.profilePicUrl!,
  //                       fit: BoxFit.cover,
  //                       errorBuilder: (BuildContext context, Object exception,
  //                           StackTrace? stackTrace) {
  //                         return ColoredBox(
  //                           color: Colors.grey.shade100,
  //                           child: Icon(
  //                             CupertinoIcons.exclamationmark_triangle,
  //                             size: 100,
  //                             color: Colors.red.shade100,
  //                           ),
  //                         );
  //                       },
  //                     ),
  //         ),
  //       ),
  //       Positioned(
  //         bottom: 0,
  //         right: 0,
  //         child: Container(
  //           width: 35,
  //           height: 35,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(50),
  //             color: SihhaGreen1.withOpacity(0.85),
  //           ),
  //           child: IconButton(
  //             alignment: Alignment.center,
  //             onPressed: () async {
  //               setState(() {
  //                 _isUploading = true; // Show loading indicator
  //               });

  //               // Pick the image
  //               ImagePicker imagePicker = ImagePicker();
  //               XFile? pickedFile =
  //                   await imagePicker.pickImage(source: ImageSource.gallery);
  //               print('PICKED FILE PATH : ${pickedFile?.path}');
  //               if (pickedFile == null) {
  //                 setState(() {
  //                   _isUploading = false; // Hide loading indicator
  //                 });
  //                 return;
  //               }

  //               // Get the ref
  //               Reference referenceRoot = FirebaseStorage.instance.ref();
  //               Reference referenceDirProfilePics =
  //                   referenceRoot.child("ProfilePics");
  //               Reference referenceImageToUpload = referenceDirProfilePics
  //                   .child("${user!.familyName}_${user!.name}.jpeg");

  //               print(documentId.toString());

  //               try {
  //                 // Upload to Firebase Storage
  //                 await referenceImageToUpload.putFile(File(pickedFile.path));
  //                 // Get the download URL and update it in Firestore Database
  //                 String url = await referenceImageToUpload.getDownloadURL();
  //                 user!.updateProfilePicUrl(url);
  //                 print(user!.profilePicUrl);
  //                 Map<String, dynamic> dataToUpload = {
  //                   'profilePicUrl': user!.profilePicUrl.toString(),
  //                 };
  //                 // Update User Data in Firestore
  //                 await _reference.doc(user!.documentId).update(dataToUpload);
  //               } catch (e) {
  //                 print(e);
  //               }

  //               setState(() {
  //                 _isUploading = false; // Hide loading indicator
  //               });
  //             },
  //             icon: Icon(
  //               LineAwesomeIcons.alternate_pencil,
  //               color: Colors.black,
  //               size: 20,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = SihhaGreen1.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8933000, size.height * 0.0304800);
    path_0.cubicTo(
        size.width * 0.6976333,
        size.height * -0.0228600,
        size.width * 0.5089000,
        size.height * -0.0000200,
        size.width * 0.2468667,
        size.height * 0.0906800);
    path_0.cubicTo(
        size.width * 0.1247667,
        size.height * 0.1675600,
        size.width * 0.1112667,
        size.height * 0.2372000,
        size.width * 0.3269000,
        size.height * 0.3689800);
    path_0.quadraticBezierTo(size.width * 0.6568000, size.height * 0.5442200,
        size.width * 0.9969037, size.height * 0.2379936);
    path_0.quadraticBezierTo(size.width * 1.0268333, size.height * 0.0876200,
        size.width * 0.8933000, size.height * 0.0304800);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
