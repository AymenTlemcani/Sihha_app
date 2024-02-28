import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CupSlideControl extends StatefulWidget {
  const CupSlideControl({super.key});

  @override
  State<CupSlideControl> createState() => _CupSlideControlState();
}

class _CupSlideControlState extends State<CupSlideControl> {
  int? _sliding = 0;
  Color TextColor0 = Colors.white;
  Color TextColor1 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      thumbColor: HexColor("509776"),
      onValueChanged: (int? value) {
        setState(() {
          _sliding = value;
          // value==1 ? TextColor1=Colors.white : TextColor1=Colors.black54;
          if (value == 1) {
            TextColor1 = Colors.white;
            TextColor0 = Colors.grey;
          } else {
            TextColor1 = Colors.grey;
            TextColor0 = Colors.white;
          }
        });
      },
      children: {
        0: Container(
          padding: EdgeInsets.all(4),
          // width: 120,
          child: Text(
            "Adulte",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: TextColor0,
              letterSpacing: 2,
            ),
          ),
        ),
        1: Container(
          padding: EdgeInsets.all(4),
          // width: 120,
          child: Text(
            "Mineur",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: TextColor1,
              letterSpacing: 2,
            ),
          ),
        ),
      },
      groupValue: _sliding,
    );
  }
}
