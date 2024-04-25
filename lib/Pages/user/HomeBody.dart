import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/DossierMedical.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/Pages/admin/CreateUser.dart';
import 'package:sahha_app/Pages/user/Profile.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Widget> tiles = [
    // List of MyTile widgets here
    Visibility(
      //FIXME add mode Admin Toggle and remove isAdmin
      visible: isAdmin || modeAdmin,
      child: MyTile(
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
    ),
    Visibility(
      visible: isAdmin || modeAdmin || isMedcin,
      child: MyTile(
        icon: LineAwesomeIcons.qrcode,
        title: 'Scanner un Code QR',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped Qr Scanner');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeScannerPage(),
            ),
          );
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
      visible: isAdmin || modeAdmin,
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
  // List<String> prescriptions = [];
  List<Map<String, dynamic>> prescriptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AddOrdonnance(),
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarHomePage(),
            SizedBox(height: 20),
            Titre('Accés rapide'),
            // Use either ListView or Wrap 3la 7sab lplatform
            _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
            SizedBox(height: 10),
            Titre('Les ordonnances'),
            OrdonnancesListView(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton AddOrdonnance() {
    return FloatingActionButton(
      onPressed: () {
        if (prescriptions.length < 8) {
          DateTime now = DateTime.now();
          setState(() {
            prescriptions.add({
              'doctorName': '(Nom de Medcin) ${prescriptions.length + 1}',
              'specialty': 'Specialty',
              'dateOfCreation': now,
              'prescriptionId': 'ID_${now.microsecondsSinceEpoch}',
            });
          });
        }
      },
      tooltip: 'Add Prescription',
      child: Icon(Icons.add),
    );
  }

  Padding OrdonnancesListView() {
    int totalPrescriptions = prescriptions.length;

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
              children: prescriptions.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> prescriptionTileData = entry.value;
                return Ordonnance(
                  prescriptionTileData['doctorName'],
                  prescriptionTileData['specialty'],
                  prescriptionTileData['dateOfCreation'],
                  prescriptionTileData['prescriptionId'],
                  index,
                  totalPrescriptions,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget Ordonnance(
    String doctorName,
    String specialty,
    DateTime dateOfCreation,
    String prescriptionId,
    int index,
    int totalPrescriptions,
  ) {
    return Column(
      children: [
        Container(
          height: 70,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyProfilePicture(URL: profilePicUrl, radius: 20),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      doctorName,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 1.3),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        if (index == totalPrescriptions - 1) SizedBox(height: 10),
        if (index < totalPrescriptions - 1) // Check if it's not the last item
          Divider(
            endIndent: 10,
            indent: 60,
            thickness: 0.4,
          )
      ],
    );
  }

  ListTile OrdonnanceNoDetails(String prescription) {
    return ListTile(
      leading: MyProfilePicture(
        URL: profilePicUrl,
        radius: 20,
      ),
      title: Text(
        prescription,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          // color: Colors.black54,
        ),
      ),
    );
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
          )),
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
                  : Text(gender == 'male' ? 'M. ' : 'Mme. ',
                      style: SihhaPoppins2),
              Text(
                  name == null
                      ? 'userName'.toUpperCase()
                      : '${familyName} ${name!.split(' ')[0]}',
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
              print("User Pressed on Profile");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            child: MyProfilePicture(
                URL: profilePicUrl,
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
