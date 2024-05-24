import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/admin/CreateUser.dart';
import 'package:sahha_app/Pages/services/DossierMedicalPage.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnacesPage.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnanceDetails.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/Pages/user/Profile.dart';
import 'package:sahha_app/Providers/ModeProvider.dart';
import 'package:sahha_app/Services/OrdonnancesService.dart';
import 'package:sahha_app/Services/UserService.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Color ButtonColor = Colors.white;
  Color TextColor = SihhaGreen2;
  // late LoginControllerProvider loginProvider;
  // late User? CurrentUser;
  // final OrdonnancesService _ordonnancesService = OrdonnancesService();

  // List<Ordonnance> _currentUserOrdonnances = [];
  Map<String, String> _medcinProfilePicUrls = {};

  @override
  void initState() {
    super.initState();
    globalUser!.fetchOrdonnances();
    setState(() {});
    // _fetchOrdonnances().then((_) {
    //   setState(() {
    //     _currentUserOrdonnances = _ordonnancesService.ordonnances ?? [];
    //   });
    // }).catchError((error) {
    //   print('Error fetching ordonnances: $error');
    //   // Handle the error case, e.g., show an error message or perform any other necessary actions
    // });
  }

  // Future<void> _fetchOrdonnances() async {
  //   try {
  //     // Create a Set to store unique medcin IDNs
  //     final Set<String> medcinIDNs = {};

  //     // Call the fetchAndProcessOrdonnances method to fetch and process ordonnances
  //     await _ordonnancesService
  //         .fetchAndProcessOrdonnances(globalUser!.documentId!);

  //     // Collect unique medcin IDNs from the fetched ordonnances
  //     for (final ordonnance in _ordonnancesService.ordonnances ?? []) {
  //       if (ordonnance.medcin?.isNotEmpty ?? false) {
  //         medcinIDNs.add(ordonnance.medcin![0].IDN!);
  //       }
  //     }

  //     // Fetch profile pictures for the unique medcin IDNs
  //     final userService = UserService();
  //     _medcinProfilePicUrls = await userService.getProfilePicUrls(medcinIDNs);

  //     // After fetching and processing, update local state with the fetched ordonnances
  //     print('done fetching');
  //     setState(() {
  //       _currentUserOrdonnances = _ordonnancesService.ordonnances ?? [];
  //     });
  //   } catch (e) {
  //     print('Error fetching ordonnances: $e');
  //   } finally {}
  // }

  // Future<void> _refreshOrdonnances() async {
  //   await _fetchOrdonnances();
  // }

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginControllerProvider>(context);
    // final user = loginProvider.user;
    // ignore: unused_local_variable
    // final medcin = loginProvider.medcin;
    // ignore: unused_local_variable

    // OrdonnancesService _OrdonnancesService = OrdonnancesService();
// modeProvider = context.watch<ModeProvider>();
    final modeProvider = context.watch<ModeProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            print(globalUser!.documentId);
            // print(_currentUserOrdonnances[0].medcin![0].documentId);
            print(_medcinProfilePicUrls);
            // print(globalMedcin!.workPlace!.name);
            // print(globalUser!.adresse);
            // print(globalUser!.isPharmacien);

            // print(user!.ordonnances![0].medicaments![0].name);
            // print(user!.speciality);
            // print(patients?.length);
            // print(patients?[0].familyName ?? '');
            // patients?.clear();
          },
        ),
      ),
      body: RefreshIndicator(
        color: SihhaGreen1,
        strokeWidth: 4,
        onRefresh: () async {
          // await user!.fetchOrdonnances();
          // await _OrdonnancesService.fetchAndProcessOrdonnances(
          //     globalUser!.documentId!);
          await globalUser!.fetchOrdonnances();
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!Platform.isWindows) ...[
                    AppBarHomePage(),
                    SizedBox(height: 20),
                  ],
                  if (Platform.isWindows) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: TextButton(
                              onHover: (value) {
                                setState(() {
                                  ButtonColor =
                                      value ? SihhaGreen1 : Colors.white;
                                  TextColor =
                                      value ? Colors.white : SihhaGreen2;
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(ButtonColor),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              onPressed: () {
                                if (mounted) {
                                  // user!.fetchOrdonnances();
                                  globalUser!.fetchOrdonnances();
                                  setState(() {});
                                }
                              },
                              child: IntrinsicWidth(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.refresh_bold,
                                        color: TextColor,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Refresh',
                                        style: SihhaFont.copyWith(
                                            color: TextColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  Titre('Accès rapide'),
                  _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
                  SizedBox(height: 10),

                  if (!Platform.isWindows &&
                      !(modeProvider.modeAdmin ||
                          modeProvider.modeMedcin ||
                          modeProvider.modePharmacie)) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Titre('Les ordonnances'),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: GestureDetector(
                            onTap: () {
                              print('user tapped Voir tout on ordonnaces');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrdonnancePage(patient: globalUser!),
                                ),
                              );
                            },
                            child: Text(
                              'Voir tout',
                              style: SihhaFont.copyWith(
                                  fontSize: 12,
                                  color: SihhaGreen2,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 0.2,
                                  decorationColor: SihhaGreen2,
                                  letterSpacing: 2,
                                  decorationStyle: TextDecorationStyle.wavy),
                            ),
                          ),
                        ),
                      ],
                    ),
                    OrdonnancesListView()
                  ],

                  ///
                  if (Platform.isWindows &&
                      !(modeProvider.modeAdmin ||
                          modeProvider.modeMedcin ||
                          modeProvider.modePharmacie)) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1000,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Titre('Les ordonnances'),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 25, 0),
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                'user tapped Voir tout on ordonnaces');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrdonnancePage(
                                                        patient: globalUser!),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Voir tout',
                                            style: SihhaFont.copyWith(
                                                fontSize: 12,
                                                color: SihhaGreen2,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 0.2,
                                                decorationColor: SihhaGreen2,
                                                letterSpacing: 2,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                OrdonnancesListView(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            // color: Colors.teal,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NoDataContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: SihhaGreen1.withOpacity(0.05),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Center(
                child: Text(
                  'Aucune ordonnance trouvée.',
                  style:
                      SihhaPoppins3.copyWith(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget OrdonnancesListView() {
    if (globalUser == null ||
        globalUser!.ordonnances == null ||
        globalUser!.ordonnances!.isEmpty) {
      return NoDataContainer();
    }

    // Sort ordonnances by date of creation in descending order
    globalUser!.ordonnances!
        .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

    // Take the last 5 ordonnances
    List<Ordonnance?> displayedOrdonnances =
        globalUser!.ordonnances!.take(5).toList();

    int totalOrdonnaces = displayedOrdonnances.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: SihhaGreen1.withOpacity(0.18),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: displayedOrdonnances.asMap().entries.map((entry) {
                int index = entry.key;
                Ordonnance ordonnance = entry.value!;
                return Column(
                  children: [
                    OrdonnanceTile(ordonnance: ordonnance),
                    if (index <
                        totalOrdonnaces - 1) // Check if it's not the last item
                      Divider(
                        endIndent: 10,
                        indent: 60,
                        thickness: 0.4,
                      )
                    else
                      SizedBox(
                          height:
                              10), // Use SizedBox instead of Divider for the last item
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
//   Widget OrdonnancesListView() {
//     // if (CurrentUser == null || _currentUserOrdonnances == null) {
//     //   return NoDataContainer();
//     // }

//     if (_currentUserOrdonnances.isEmpty) {
//       return NoDataContainer();
//     }

// // Filter the sorted ordonnances to take only the active ones
//     // List<Ordonnance?> displayedOrdonnances = _currentUserOrdonnances
//     List<Ordonnance?> displayedOrdonnances = globalUser!.ordonnances!
//         .where((ordonnance) => ordonnance.status == 'active')
//         .take(5)
//         .toList();

//     int totalOrdonnaces = displayedOrdonnances.length;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: SihhaGreen1.withOpacity(0.18),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             physics: NeverScrollableScrollPhysics(), // Disable scrolling
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: displayedOrdonnances.asMap().entries.map((entry) {
//                 int index = entry.key;
//                 Ordonnance ordonnance = entry.value!;
//                 return Column(
//                   children: [
//                     OrdonnanceTile(ordonnance: ordonnance),
//                     if (index <
//                         totalOrdonnaces - 1) // Check if it's not the last item
//                       Divider(
//                         endIndent: 10,
//                         indent: 60,
//                         thickness: 0.4,
//                       )
//                     else
//                       SizedBox(
//                           height:
//                               10), // Use SizedBox instead of Divider for the last item
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  Widget OrdonnanceTile({required Ordonnance ordonnance}) {
    return FutureBuilder<List<String?>>(
      future:
          ordonnance.fetchDoctorProfilePicUrls([ordonnance.medcin![0].IDN!]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height: 70);
          // CircularProgressIndicator(color: Colors.white,);
        }
        if (snapshot.hasError) {
          return Text('Error fetching profile picture');
        }
        List<String?> doctorProfilePicUrls = snapshot.data ?? [];
        return InkWell(
          borderRadius: BorderRadius.circular(30),
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrdonnanceDetails(
                  ordonnance: ordonnance,
                  patient: globalUser!,
                  medcin: ordonnance.medcin![0],
                ),
              ),
            );
          },
          child: Container(
            height: 70,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: doctorProfilePicUrls.map((url) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MyProfilePicture2(
                          URL: url,
                          frameRadius: 23,
                          pictureRadius: 21,
                          borderColor: ordonnance.status == 'active'
                              ? SihhaGreen2
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
                        style: SihhaPoppins3.copyWith(
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${ordonnance.medcin![0].speciality}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '${ordonnance.dateOfFilling!.toDate().day}/${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${(ordonnance.dateOfFilling!.toDate().minute) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().minute}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 1.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // FloatingActionButton AddOrdonnance() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       if (prescriptions.length < 8) {
  //         DateTime now = DateTime.now();
  //         setState(() {
  //           prescriptions.add({
  //             'doctorName': '(Nom de Medcin) ${prescriptions.length + 1}',
  //             'specialty': 'Specialty',
  //             'dateOfFilling': now,
  //             'prescriptionId': 'ID_${now.microsecondsSinceEpoch}',
  //           });
  //         });
  //       }
  //     },
  //     tooltip: 'Add Prescription',
  //     child: Icon(Icons.add),
  //   );
  // }
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];

    final modeProvider = context.watch<ModeProvider>();

    // If MODE ADMIN
    if (modeProvider.modeAdmin) {
      tiles.addAll([
        MyTile(
          icon: LineAwesomeIcons.user_plus,
          title: 'Créer un\n compte',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            print('user tapped create an account');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateUser(),
              ),
            );
          },
        ),
        MyTile(
          icon: LineAwesomeIcons.qrcode,
          title: 'Scanner',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            // //TO DO Add Qr USB SCAN for pc DONE
            //********************************************************************************* */
            // Patient.fetchPatientData('QSLvoTr1Tdf0XU9TwfTB').then(
            //   (patient) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PatientPage(patient: patient),
            //       ),
            //     );
            //   },
            // );
            //********************************************************************************* */
            //********************************************************************************* */
            print('user tapped Qr Scanner');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeScannerPage(),
              ),
            );
            //********************************************************************************* */
          },
        ),
        MyTile(
          icon: LineAwesomeIcons.user_edit,
          title: 'Modifier un compte',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
        MyTile(
          icon: LineAwesomeIcons.laptop_code,
          title: 'Database Query',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
        MyTile(
          icon: LineAwesomeIcons.address_card,
          title: 'Demandes De Carte Sihha',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
        MyTile(
          icon: LineAwesomeIcons.alternate_medical_file,
          title: 'Statistiques',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
        MyTile(
          icon: LineAwesomeIcons.user_check,
          title: 'Authentification',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
      ]);
    }
    // if MODE MEDCIN
    if (modeProvider.modeMedcin) {
      tiles.addAll([
        MyTile(
          icon: LineAwesomeIcons.qrcode,
          title: 'Scanner',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            //********************************************************************************* */
            // Patient.fetchPatientData('QSLvoTr1Tdf0XU9TwfTB').then(
            //   (patient) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PatientPage(patient: patient),
            //       ),
            //     );
            //   },
            // );
            //********************************************************************************* */
            //********************************************************************************* */
            print('user tapped Qr Scanner');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeScannerPage(),
              ),
            );
            //********************************************************************************* */
          },
        ),
      ]);
    }
    // IF MODE PHARMACIE
    if (modeProvider.modePharmacie) {
      tiles.addAll([
        MyTile(
          icon: LineAwesomeIcons.qrcode,
          title: 'Scanner',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            //********************************************************************************* */
            // Patient.fetchPatientData('QSLvoTr1Tdf0XU9TwfTB').then(
            //   (patient) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PatientPage(patient: patient),
            //       ),
            //     );
            //   },
            // );
            //********************************************************************************* */
            //********************************************************************************* */
            print('user tapped Qr Scanner');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeScannerPage(),
              ),
            );
            //********************************************************************************* */
          },
        ),
        MyTile(
          icon: LineAwesomeIcons.pills,
          title: 'Ajouter Medicament',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
      ]);
    }
    // NORMAL
    if (!modeProvider.modeAdmin &&
        !modeProvider.modeMedcin &&
        !modeProvider.modePharmacie) {
      tiles.addAll([
        MyTile(
          icon: LineAwesomeIcons.folder_open,
          title: 'Dossier Medical',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            // print('user tapped create an account');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DossierMedicalPage(),
              ),
            );
          },
        ),
        MyTile(
          icon: LineAwesomeIcons.file_signature,
          title: 'Ordonnaces',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrdonnancePage(patient: globalUser!),
              ),
            );
          },
        ),
        MyTile(
          icon: LineAwesomeIcons.syringe,
          title: 'Vaccines',
          iconColor: SihhaGreen2,
          itemColor1: SihhaGreen1.withOpacity(0.18),
          smallCircleColor1: Colors.white,
          onTapFunction: (BuildContext context) {},
        ),
      ]);
    }

    // Additional common tiles or tiles for other modes can be added similarly
    // ...

    return tiles;
  }

  bool _shouldUseWrap() {
    return !(defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  // Wrap for Web platform
  Widget WrapAccesRapide() {
    return Material(
      color: Colors.white,
      child: Padding(
        // padding: EdgeInsets.fromLTRB(12, 0, 20, 12),
        padding: EdgeInsets.all(12),
        child: Wrap(
          // alignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: getTiles(context),
          // tiles.map((tile) => tile.build(context)).toList(),
        ),
      ),
    );
  }

  // ListView for non-Web platforms
  Widget ListViewAccesRapide() {
    return Container(
      height: 180,
      color: Colors.white,
      child: ListView(
          padding: EdgeInsets.fromLTRB(12, 0, 20, 12),
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: getTiles(context)),
    );
  }

  Padding Titre(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
      child: Text(text, style: SihhaPoppins3),
    );
  }

  Container AppBarHomePage() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //       color: const Color(0xff1D1617).withOpacity(0.1),
        //       blurRadius: 10,
        //       spreadRadius: 0.0)
        // ],
        // border: Border(bottom: BorderSide(color: Colors.black12)),
        // gradient: LinearGradient(
        //     colors: appBarGradientColors,
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight),
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/back3.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        firstRowProfileButtonAndLogo(),

        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 5, 5),
          child: Text('Bienvenu,',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 25)),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 5, 30),
          child: Row(
            children: [
              modeMedcin || modePharmacie
                  ? Text('Dr. ', style: SihhaPoppins2)
                  : Text(globalUser!.gender == 'male' ? 'M. ' : 'Mme. ',
                      style: SihhaPoppins2),
              Text(
                  globalUser!.name == null
                      ? 'userName'.toUpperCase()
                      : '${globalUser!.familyName} ${globalUser!.name!.split(' ')[0]}',
                  style: SihhaPoppins2),
            ],
          ),
        ),

        // Row(
        //   children: [
        //     Padding(
        //         padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //         child: welcomeMessage()),
        //   ],
        // ),
      ]),
    );
  }

  Row firstRowProfileButtonAndLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },

            //TODO ki nbdlo photo de profile w nwliw l homePage la photo marahach ttl3 khas 7eta dir logout
            //we can use stream builder or future buider to get the user image from firebase storage or in init state
            child: MyProfilePicture(
                URL: globalUser!.profilePicUrl,
                radius: 24,
                ImageHeight: 43,
                ImageWidth: 43,
                borderColor: Colors.white),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Transform.translate(
          offset: Offset(-35, 40),
          child: SvgPicture.asset(
            "assets/svg-cropped.svg",
            height: 70,
          ),
        ),
      ],
    );
  }
}
