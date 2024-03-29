import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/Common/MyTile.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/admin/CreateUser.dart';
import 'package:sahha_app/Pages/services/QR_scanner_Page.dart';
import 'package:sahha_app/Pages/user/Profile.dart';
// Import your custom ListViewTile widget

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
        title: 'Créer un compte',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped create an account');
          Navigator.pushReplacement(
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
        onTapFunction: (p0) {},
        // (BuildContext context) {
        //   print('user tapped Qr Scanner');
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => QRCodeScannerPage(),
        //     ),
        //   );
        // },
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Titre('Les ordonnances')
          ],
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                // CupertinoIcons.person_fill,
                LineAwesomeIcons.user_tie,
                color: SihhaGreen2,
                size: 29,
              ),
              radius: 24,
            ),
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
            )),
      ],
    );
  }
}
