import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Pages/services/DossierMedical.dart';
import 'package:sahha_app/utils/Variables.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

List<Widget> MedicalTiles = [
  // List of MyTile widgets here

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
bool _shouldUseWrap() {
  return !(defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android);
}

class _MedicalPageState extends State<MedicalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: SihhaGreen1,
        elevation: 0,
        scrolledUnderElevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Médical',
            style: SihhaPoppins2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: _shouldUseWrap() ? WebWrap() : PhoneGrid(),
      ),
    );
  }

  Widget WebWrap() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          // alignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: MedicalTiles,
          // tiles.map((tile) => tile.build(context)).toList(),
        ),
      ),
    );
  }

  OrientationBuilder PhoneGrid() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          childAspectRatio:
              orientation == Orientation.portrait ? 13 / 9 : 13 / 9,

          // if you want to use crossAxisCount: 3 in portrait mode use 5/6 aspect ratio
          // childAspectRatio: 5 / 6,
          children: MedicalTiles,
        );
      },
    );
  }
}