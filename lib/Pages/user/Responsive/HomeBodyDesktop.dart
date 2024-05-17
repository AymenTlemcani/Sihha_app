import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/DossierMedical.dart';
import 'package:sahha_app/Pages/admin/CreateUser.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnanceDetails.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/Pages/user/Profile.dart';

class HomeBodyDesktop extends StatefulWidget {
  HomeBodyDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBodyDesktop> createState() => _HomeBodyDesktopState();
}

class _HomeBodyDesktopState extends State<HomeBodyDesktop> {
  List<Widget> tiles = [
    // List of MyTile widgets here
    Visibility(
      //FIXME add mode Admin Toggle and remove isAdmin
      visible: user!.isAdmin || modeAdmin,
      child: MyTile(
        icon: LineAwesomeIcons.user_plus,
        title: 'Créer un compte',
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
    ),
    Visibility(
      visible:
          user!.isAdmin || modeAdmin || user!.isMedcin || user!.isPharmacie,
      child: MyTile(
        icon: LineAwesomeIcons.qrcode,
        title: 'Scanner',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          // //TODO Add Qr USB SCAN for pc
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
    ),
    MyTile(
      icon: LineAwesomeIcons.heartbeat,
      title: 'Dossier Medical',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {
        print('user tapped Dossier Medical');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DossierMedical(),
          ),
        );
      },
    ),
    Visibility(
      visible: user!.isAdmin || modeAdmin,
      child: MyTile(
        icon: LineAwesomeIcons.user_edit,
        title: 'Modifier un compte',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {},
      ),
    ),

    MyTile(
      icon: LineAwesomeIcons.laptop_code,
      title: 'item1',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.laptop_medical,
      title: 'item2',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.address_card,
      title: 'item3',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.folder_open,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.alternate_medical_file,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.file_signature,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.user_check,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.syringe,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.pills,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),

    // Add other MyTile widgets as needed
  ];
  @override
  void initState() {
    user!.fetchOrdonnances();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            print(user!.documentId);
            print(user!.adresse);
            print(user!.isPharmacie);

            // print(user!.ordonnances![0].medicaments![0].name);
            // print(user!.speciality);
            // print(patients?.length);
            // print(patients?[0].familyName ?? '');
            // patients?.clear();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBarHomePage(),
                // SizedBox(height: 20),
                Titre('Accès rapide'),
                _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
                SizedBox(height: 10),
                Titre('Les ordonnances'),
                FutureBuilder<void>(
                  future: user!.fetchOrdonnances(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return OrdonnancesListView();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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
    if (user == null || user!.ordonnances == null) {
      return NoDataContainer();
    }

    if (user!.ordonnances!.isEmpty) {
      return NoDataContainer();
    }

    // Sort ordonnances by date of creation in descending order
    user!.ordonnances!
        .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

    // Take the last 5 ordonnances
    List<Ordonnance?> displayedOrdonnances =
        user!.ordonnances!.take(5).toList();

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

  // Padding OrdonnancesListView() {
  //   if (user == null || user!.ordonnances == null) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30),
  //           color: SihhaGreen1.withOpacity(0.18),
  //         ),
  //         child: Center(
  //           child: Text(
  //             'Chargement...',
  //             style: GoogleFonts.poppins(
  //               color: Colors.grey,
  //               fontWeight: FontWeight.w400,
  //               fontSize: 16,
  //               letterSpacing: 1.3,
  //             ), // Adjust the style as needed
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   // Sort ordonnances by date of creation in descending order
  //   user!.ordonnances!
  //       .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

  //   // Take the last 5 ordonnances
  //   List<Ordonnance?> displayedOrdonnances =
  //       user!.ordonnances!.take(5).toList();

  //   int totalOrdonnaces = displayedOrdonnances.length;
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30),
  //         color: SihhaGreen1.withOpacity(0.18),
  //       ),
  //       child: Center(
  //         child: SingleChildScrollView(
  //           physics: NeverScrollableScrollPhysics(), // Disable scrolling
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: displayedOrdonnances.asMap().entries.map((entry) {
  //               int index = entry.key;
  //               Ordonnance ordonnance = entry.value!;
  //               return Column(
  //                 children: [
  //                   OrdonnanceTile(ordonnance: ordonnance),
  //                   if (index <
  //                       totalOrdonnaces - 1) // Check if it's not the last item
  //                     Divider(
  //                       endIndent: 10,
  //                       indent: 60,
  //                       thickness: 0.4,
  //                     )
  //                   else
  //                     SizedBox(
  //                         height:
  //                             10), // Use SizedBox instead of Divider for the last item
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

//TODO Switch Tiles to inkwells that navigate to a page with more details about each prescription
  Widget OrdonnanceTile({required Ordonnance ordonnance}) {
    return FutureBuilder<List<String?>>(
      future: ordonnance.fetchDoctorProfilePicUrls([ordonnance.doctorIDN!]),
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
                builder: (context) =>
                    OrdonnanceDetails(ordonnance: ordonnance, patient: user!),
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
                        child: MyProfilePicture(URL: url, radius: 20),
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
                        ordonnance.doctorName!,
                        //
                        style:
                            //
                            SihhaPoppins3.copyWith(
                                fontSize: 16, letterSpacing: 1.2),
                        overflow: TextOverflow.ellipsis,
                        //
                        // GoogleFonts.poppins(
                        //   color: Colors.black,
                        //   fontWeight: FontWeight.w400,
                        //   fontSize: 16,
                        //   letterSpacing: 1.3,
                        // ),
                        //
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      ordonnance.doctorSpeciality!,
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

  bool _shouldUseWrap() {
    return !(defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  // Wrap for Web platform
  Widget WrapAccesRapide() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          // alignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: tiles,
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
          padding: EdgeInsets.all(12),
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: tiles),
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
                  : Text(user!.gender == 'male' ? 'M. ' : 'Mme. ',
                      style: SihhaPoppins2),
              Text(
                  user!.name == null
                      ? 'userName'.toUpperCase()
                      : '${user!.familyName} ${user!.name!.split(' ')[0]}',
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
            child: MyProfilePicture(
                URL: user!.profilePicUrl,
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
