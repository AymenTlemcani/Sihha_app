import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTile extends StatelessWidget {
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
  final Function(BuildContext)? onTapFunction; // Updated function signature

  const MyTile({
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
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashFactory: InkRipple.splashFactory,
        enableFeedback: true,
        onTap: () {
          // Call onTapFunction with the context
          onTapFunction?.call(context);
        },
        onTapCancel: () {
          print('user stopped pressing down on the list');
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
              color: itemColor ?? itemColor1,
              borderRadius: BorderRadius.circular(30),
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
              radius: 27,
              child: Icon(
                icon,
                color: iconColor ?? iconColor1,
                size: 35,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              color: titleColor1 ?? titleColor,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
