import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
          height: 55,
          width: MediaQuery.sizeOf(context).width < 1080
              ? MediaQuery.sizeOf(context).width - 36
              : 1080 - 36,
          decoration: BoxDecoration(
              color: ButtonColor,
              // HexColor("509776"),
              // HexColor('#44564a'),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 0.0)
              ]),
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
    );
  }
}
