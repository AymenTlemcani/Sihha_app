import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/Qr/OverlayQR.dart';
import 'package:sahha_app/Pages/services/Qr/USBScannerPage.dart';
import 'package:sahha_app/Pages/user/PatientPage.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';

bool isScanned = false;
bool isControllerStarted = false;

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerPage> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  // there was an error 'Called start() while already started' when you lock
  // the screen  and then try to open this page again, so we used a bool flag
  // to check if the cameraController has been initialized or not
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS || Platform.isAndroid) {
      if (!isControllerStarted) {
        try {
          cameraController.start();
          print('cameraController STARTED');
          isControllerStarted = true;
        } catch (e) {
          print('Error starting camera controller: $e');
        }
      }
    }
  }

  @override
  void dispose() {
    if (Platform.isIOS || Platform.isAndroid) {
      cameraController.dispose();
      print('cameraController DISPOSED');
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isAndroid) {
      return _PhoneVersion(context);
    } else {
      return UsbScannerPage();
      // Center(
      //   child: Text(
      //     'QR code Scanning on Windows.',
      //     style: SihhaPoppins1,
      //   ),
      // );
    }
  }

  Widget _PhoneVersion(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        setState(() {
          isScanned = false;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(CupertinoIcons.bolt,
                          color: CupertinoColors.systemGrey);
                    case TorchState.on:
                      return Icon(CupertinoIcons.bolt_fill, color: SihhaGreen1);
                  }
                },
              ),
              iconSize: 28.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            VerticalDivider(color: Colors.black45, endIndent: 16, indent: 16),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return Icon(Icons.flip_camera_ios, color: SihhaGreen1);
                      case CameraFacing.back:
                        return Icon(Icons.flip_camera_ios_outlined,
                            color: CupertinoColors.systemGrey);
                    }
                  },
                ),
                iconSize: 28.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: Text(
            'Scanner QR code',
            style: SihhaPoppins3,
          ),
          leading: MyBackButton(
            onTapFunction: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeBody(),
                ),
              );
            },
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mettez le code QR dans la zone',
                    style: SihhaPoppins3.copyWith(
                        color: Colors.black87,
                        letterSpacing: 1.5,
                        fontSize: 18),
                  ),
                  Text(
                    'La lecture sera lancée automatiquement',
                    textAlign: TextAlign.center,
                    style: SihhaPoppins3.copyWith(
                        letterSpacing: 0.3,
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: cameraController,
                    //the pharmacist can scan his own qr code but the medcin should not be able to do it  /* DONE */
                    //tip: to implement this we need to check if the user document ID matches with the one in the qrcode
                    onDetect: (barcodes) {
                      final scannedCode = barcodes.barcodes.first.rawValue;
                      //if the code is valid and not scanned
                      if ((scannedCode != null) &&
                          (scannedCode.length == 20) &&
                          (!isScanned)) {
                        //we add isScanned because we don't want to allow multiple scans of the same code
                        //if the user is scanning his own code
                        if (scannedCode == user!.documentId && user!.isMedcin) {
                          isScanned =
                              true; //to make sure the code is scanned once

                          showCupertinoDialog(
                            // Show a Cupertino dialog indicating that the user cannot scan their own QR code
                            context: context,
                            builder: (BuildContext context) {
                              return PopScope(
                                onPopInvoked: (didPop) {
                                  setState(() {
                                    isScanned = false; //to re-scan again
                                  });
                                },
                                child: CupertinoAlertDialog(
                                  title: Text(
                                    "Vous ne pouvez pas scanner votre propre code QR !",
                                    style: GoogleFonts.poppins(
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.w500,
                                      color: CupertinoColors.label,
                                    ),
                                  ),
                                  actions: [
                                    CupertinoButton(
                                      child: Icon(
                                        CupertinoIcons.refresh_thick,
                                        color: SihhaGreen3,
                                      ),
                                      onPressed: () {
                                        isScanned = false;
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                          //else if he is scanning another nigga's code
                        } else {
                          isScanned = true;
                          // fetchUserData(scannedCode);
                          Patient.fetchPatientData(scannedCode).then(
                            (patient) {
                              //and that nigga's code is valid
                              if (patient != null) {
                                // Check if patients list is not null before adding the patient
                                if (patients != null) {
                                  // Check if the patient is already in the list
                                  bool isPatientExists = patients!.any((p) =>
                                      p.documentId == patient.documentId);

                                  if (!isPatientExists) {
                                    patients!.add(patient);
                                    print(
                                        'Current number of patients : ${patients!.length}');
                                  } else {
                                    print('Patient already exists in the list');
                                  }
                                } else {
                                  // Initialize the patients list if it's null
                                  patients = [patient];
                                  print(
                                      'Current number of patients : ${patients!.length}');
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PatientPage(patient: patient),
                                  ),
                                );
                                // if that nigga's code is not valid tell em 'Nigga yo code aint valid'
                              } else {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PopScope(
                                      onPopInvoked: (didPop) {
                                        setState(() {
                                          isScanned = false;
                                        });
                                      },
                                      child: CupertinoAlertDialog(
                                        title: Text(
                                          "Utilisateur introuvable !",
                                          style: GoogleFonts.poppins(
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.w500,
                                            color: CupertinoColors.label,
                                          ),
                                        ),
                                        actions: [
                                          CupertinoButton(
                                            child: Icon(
                                              CupertinoIcons.refresh_thick,
                                              color: SihhaGreen3,
                                            ),
                                            onPressed: () {
                                              isScanned = false;
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          );
                        }
                      } //end if the code is valid and not scanned
                    },
                  ),
                  QRScannerOverlay(overlayColour: Colors.white),
                ],
              ),
            ),
            // we can do a button here to take picture or scan the qrcode
            //TODO: we can add a stream to show a card of user profile when data is loaded
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
// Patient? patient;
// patients.add(patient);
// void fetchUserData(String userId) {
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(userId)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       Map<String, dynamic>? userData =
//           documentSnapshot.data() as Map<String, dynamic>;
//       patient = Patient(
//         IDN: userData['IDN'],
//         familyName: userData['familyName'],
//         name: userData['name'],
//         gender: userData['gender'],
//         birthDay: userData['birthDay'],
//         birthMonth: userData['birthMonth'],
//         birthYear: userData['birthYear'],
//         birthPlace: userData['birthPlace'],
//         profilePicUrl: userData['profilePicUrl'],
//         bio: userData['bio'],
//         telephone: userData['telephone'],
//         documentId: documentSnapshot.id,
//         bloodType: userData['bloodType'],
//         weight: userData['weight'],
//         height: userData['height'],

//         //TODO add ordonannces and other fields
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PatientPage(patient: patient),
//         ),
//       );
//       print('User data: ${userData['name']}');
//       // print('User data: ${documentSnapshot.data()}');
//       // print('User data: ${documentSnapshot.id}');
//     } else {
//       //TODO Show alert dialog
//       showCupertinoDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return PopScope(
//             onPopInvoked: (didPop) {
//               setState(() {
//                 isScanned = false;
//               });
//             },
//             child: CupertinoAlertDialog(
//               title: Text(
//                 "Utilisateur introuvable !",
//                 // "User not found !",
//                 style: GoogleFonts.poppins(
//                     letterSpacing: 1.2,
//                     fontWeight: FontWeight.w500,
//                     color: CupertinoColors.label),
//               ),
//               // content: Text(
//               //   "would you like to try again?",
//               //   style: GoogleFonts.poppins(),
//               // ),
//               actions: [
//                 CupertinoButton(
//                   child: Icon(
//                     CupertinoIcons.refresh_thick,
//                     color: SihhaGreen3,
//                   ),
//                   onPressed: () {
//                     isScanned = false;
//                     Navigator.of(context).pop();
//                   },
//                   //   CupertinoDialogAction(
//                   //     isDestructiveAction: true,
//                   //     onPressed: () {
//                   //       Navigator.pop(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => HomeBody(),
//                   //         ),
//                   //       );
//                   //     },
//                   //     child: Text(
//                   //       "Non",
//                   //       style: GoogleFonts.poppins(),
//                   //     ),
//                   //   ),
//                   //   CupertinoDialogAction(
//                   //     onPressed: () {
//                   //       isScanned = false;
//                   //       Navigator.of(context).pop();
//                   //     },
//                   //     child: Text(
//                   //       "Oui",
//                   //       style: GoogleFonts.poppins(),
//                   //     ),
//                   //   ),
//                 )
//               ],
//             ),
//           );
//         },
//       );

//       print('User not found');
//       // setState(() {
//       // });
//     }
//   });
// }
