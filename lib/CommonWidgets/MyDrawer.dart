import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/CommonWidgets/MyDrawerTile.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Providers/DesktopNavigationProvider.dart';
import 'package:sahha_app/Providers/ModeProvider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //NOT USED
  void _onDrawerTilePressed(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final modeProvider = context.watch<ModeProvider>();

    // final loginProvider = Provider.of<LoginControllerProvider>(context);
    // User? user = loginProvider.user;
    return Drawer(
      width: 250,
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            _DrawerHeader(() => _onDrawerTilePressed(0), context),
            // ...getTiles(context),
            Visibility(
              visible: true,
              // (!modeProvider.modeAdmin &&
              //     !modeProvider.modeMedcin &&
              //     !modeProvider.modePharmacie),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: MyDrawerTile(
                  label: 'Accueil',
                  selectedIcon: CupertinoIcons.house_fill,
                  unselectedIcon: CupertinoIcons.house,
                  onTap: () => context
                      .read<DesktopNavigationProvider>()
                      .setSelectedIndex(1),
                  selectedIndex:
                      context.watch<DesktopNavigationProvider>().selectedIndex,
                  index: 1,
                  // onTap: () => _onDrawerTilePressed(1),
                  // selectedIndex: selectedIndex,
                  // index: 1,
                ),
              ),
            ),
            Visibility(
              visible: (!modeProvider.modeAdmin &&
                  !modeProvider.modeMedcin &&
                  !modeProvider.modePharmacie),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: MyDrawerTile(
                  label: 'Cards',
                  selectedIcon: CupertinoIcons.creditcard_fill,
                  unselectedIcon: CupertinoIcons.creditcard,
                  onTap: () => context
                      .read<DesktopNavigationProvider>()
                      .setSelectedIndex(2),
                  selectedIndex:
                      context.watch<DesktopNavigationProvider>().selectedIndex,
                  index: 2,
                ),
              ),
            ),
            Visibility(
              visible: (!modeProvider.modeAdmin &&
                  !modeProvider.modeMedcin &&
                  !modeProvider.modePharmacie),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: MyDrawerTile(
                  label: 'Médical',
                  selectedIcon: CupertinoIcons.heart_fill,
                  unselectedIcon: CupertinoIcons.heart,
                  onTap: () => context
                      .read<DesktopNavigationProvider>()
                      .setSelectedIndex(3),
                  selectedIndex:
                      context.watch<DesktopNavigationProvider>().selectedIndex,
                  index: 3,
                ),
              ),
            ),
            Visibility(
              visible: (!modeProvider.modeAdmin &&
                  !modeProvider.modeMedcin &&
                  !modeProvider.modePharmacie),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: MyDrawerTile(
                  label: 'Famille',
                  selectedIcon: CupertinoIcons.person_3_fill,
                  unselectedIcon: CupertinoIcons.person_3,
                  onTap: () => context
                      .read<DesktopNavigationProvider>()
                      .setSelectedIndex(4),
                  selectedIndex:
                      context.watch<DesktopNavigationProvider>().selectedIndex,
                  index: 4,
                ),
              ),
            ),
            Visibility(
              visible: modeProvider.modeAdmin,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                child: MyDrawerTile(
                  label: 'Statistiques',
                  selectedIcon: CupertinoIcons.graph_square_fill,
                  unselectedIcon: CupertinoIcons.graph_square_fill,
                  onTap: () => context
                      .read<DesktopNavigationProvider>()
                      .setSelectedIndex(5),
                  selectedIndex:
                      context.watch<DesktopNavigationProvider>().selectedIndex,
                  index: 5,
                ),
              ),
            ),
            // Visibility(
            //   visible: modeProvider.modeAdmin,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
            //     child: MyDrawerTile(
            //       label: 'Comptes',
            //       selectedIcon: CupertinoIcons.person_2_fill,
            //       unselectedIcon: CupertinoIcons.person_2,
            //       onTap: () => context
            //           .read<DesktopNavigationProvider>()
            //           .setSelectedIndex(6),
            //       selectedIndex:
            //           context.watch<DesktopNavigationProvider>().selectedIndex,
            //       index: 6,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// InkWell(
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 20,
//                             spreadRadius: 0.2),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(width: 12),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: SihhaGreen1.withOpacity(0.3),
//                                     blurRadius: 10,
//                                     spreadRadius: 0.3),
//                               ]),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Icon(
//                               CupertinoIcons.house,
//                               size: 20,
//                               color: CupertinoColors.systemGrey,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Text(
//                           'Home',
//                           style: SihhaFont.copyWith(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: CupertinoColors.systemGrey,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

Widget _DrawerHeader(VoidCallback onProfilePictureTap, BuildContext context) {
  // final loginProvider = Provider.of<LoginControllerProvider>(context);
  // User? user = loginProvider.user;
  return IntrinsicHeight(
    child: Container(
      // height: 210,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/back3.png"),
            fit: BoxFit.fill,
          )),
      child: Column(
          //
          crossAxisAlignment: CrossAxisAlignment.start,
          //
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    hoverColor: SihhaGreen1.withOpacity(0.18),
                    // onTap: onProfilePictureTap,
                    onTap: () => context
                        .read<DesktopNavigationProvider>()
                        .setSelectedIndex(0),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: MyProfilePicture2(
                        URL: globalUser!.profilePicUrl,
                        frameRadius: 25,
                        pictureRadius: 22,
                        borderColor: SihhaGreen2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${globalUser!.familyName}',
                        style: SihhaPoppins3.copyWith(fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '${globalUser!.name}',
                        style: SihhaPoppins3.copyWith(fontSize: 14),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
            //
            SizedBox(height: 30),
          ]),
    ),
  );
}

List<Widget> getTiles(BuildContext context) {
  List<Widget> tiles = [];

  final modeProvider = context.watch<ModeProvider>();

  // If MODE ADMIN
  if (modeProvider.modeAdmin) {
    tiles.addAll([]);
  }
  // // if MODE MEDCIN
  // if (modeProvider.modeMedcin) {
  //   tiles.addAll([
  //     MyTile(
  //       icon: LineAwesomeIcons.qrcode,
  //       title: 'Scanner',
  //       iconColor: SihhaGreen2,
  //       itemColor1: SihhaGreen1.withOpacity(0.18),
  //       smallCircleColor1: Colors.white,
  //       onTapFunction: (BuildContext context) {
  //         //********************************************************************************* */
  //         // Patient.fetchPatientData('QSLvoTr1Tdf0XU9TwfTB').then(
  //         //   (patient) {
  //         //     Navigator.push(
  //         //       context,
  //         //       MaterialPageRoute(
  //         //         builder: (context) => PatientPage(patient: patient),
  //         //       ),
  //         //     );
  //         //   },
  //         // );
  //         //********************************************************************************* */
  //         //********************************************************************************* */
  //         print('user tapped Qr Scanner');
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => QRCodeScannerPage(),
  //           ),
  //         );
  //         //********************************************************************************* */
  //       },
  //     ),
  //   ]);
  // }
  // // IF MODE PHARMACIE
  // if (modeProvider.modePharmacie) {
  //   tiles.addAll([
  //     MyTile(
  //       icon: LineAwesomeIcons.qrcode,
  //       title: 'Scanner',
  //       iconColor: SihhaGreen2,
  //       itemColor1: SihhaGreen1.withOpacity(0.18),
  //       smallCircleColor1: Colors.white,
  //       onTapFunction: (BuildContext context) {
  //         //********************************************************************************* */
  //         // Patient.fetchPatientData('QSLvoTr1Tdf0XU9TwfTB').then(
  //         //   (patient) {
  //         //     Navigator.push(
  //         //       context,
  //         //       MaterialPageRoute(
  //         //         builder: (context) => PatientPage(patient: patient),
  //         //       ),
  //         //     );
  //         //   },
  //         // );
  //         //********************************************************************************* */
  //         //********************************************************************************* */
  //         print('user tapped Qr Scanner');
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => QRCodeScannerPage(),
  //           ),
  //         );
  //         //********************************************************************************* */
  //       },
  //     ),
  //     MyTile(
  //       icon: LineAwesomeIcons.pills,
  //       title: 'Ajouter Medicament',
  //       iconColor: SihhaGreen2,
  //       itemColor1: SihhaGreen1.withOpacity(0.18),
  //       smallCircleColor1: Colors.white,
  //       onTapFunction: (BuildContext context) {},
  //     ),
  //   ]);
  // }
  // NORMAL
  if (!modeProvider.modeAdmin &&
      !modeProvider.modeMedcin &&
      !modeProvider.modePharmacie) {
    tiles.addAll([]);
  }

  // Additional common tiles or tiles for other modes can be added similarly
  // ...

  return tiles;
}
