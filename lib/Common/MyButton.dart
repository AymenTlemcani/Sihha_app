import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Common/Variables.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final HexColor ButtonColor;
  final HexColor TextButtonColor;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.ButtonColor,
    required this.TextButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      borderRadius: BorderRadius.circular(8),
      hoverColor: Colors.black12,
      highlightColor: Colors.transparent,
      splashColor: SihhaGreen2,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          // padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
          height: 55,

          width: MediaQuery.sizeOf(context).width < 600
              ? MediaQuery.sizeOf(context).width - 36
              : 600 - 36,
          decoration: BoxDecoration(
              color: ButtonColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.6),
                    blurRadius: 2,
                    spreadRadius: 0.0)
              ]),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: TextButtonColor,
                fontSize: 18,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
