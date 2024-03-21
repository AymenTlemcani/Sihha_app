import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Common/Variables.dart';

class MyTile1 extends StatelessWidget {
  final String title;
  final HexColor? titleColor;
  final HexColor? itemColor;
  final HexColor? smallCircleColor;
  final HexColor? iconColor;
  final Color? titleColor1;
  final Color? itemColor1;
  final Color? smallCircleColor1;
  final Color? iconColor1;
  final IconData icon;

  const MyTile1({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor,
    this.iconColor1,
    this.itemColor,
    this.itemColor1,
    this.smallCircleColor,
    this.smallCircleColor1,
    this.titleColor,
    this.titleColor1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        // focusColor: itemColor ?? itemColor1,
        // highlightColor: itemColor ?? itemColor1,
        splashColor: SihhaGreen1,
        hoverColor: SihhaGreen1.withOpacity(0.1),
        splashFactory: InkSparkle.splashFactory,

        enableFeedback: true,

        onTap: () {
          print('user tapped on list view item');
        },
        onTapCancel: () {
          print('user stopped pressing down on the list');
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: 160,
            decoration: BoxDecoration(
              color: itemColor ?? itemColor1,
              // Colors.grey.shade100.withOpacity(0.2),
              // SihhaGreen1.withOpacity(0.18),
              borderRadius: BorderRadius.circular(30),
              // border: Border.all(color: Colors.black12),
            ),
            child: c1(),
          ),
        ),
      ),
    );
  }

  Column c1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: smallCircleColor1 ?? smallCircleColor,
              // Colors.white,
              // SihhaGreen1.withOpacity(0.1),
              radius: 27,
              child: Icon(icon,
                  // CupertinoIcons.book_fill,
                  // LineAwesomeIcons.medical_file,
                  color: iconColor ?? iconColor1,
                  // SihhaGreen2.withOpacity(0.8),
                  // CupertinoColors.black,
                  size: 35),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: titleColor1 ?? titleColor,
                fontSize: 17),
          ),
        )
      ],
    );
  }
}
