// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:sahha_app/Models/Variables.dart';

// // class CupSlideControl extends StatefulWidget {
// //   const CupSlideControl({super.key});

// //   @override
// //   State<CupSlideControl> createState() => _CupSlideControlState();
// // }

// // class _CupSlideControlState extends State<CupSlideControl> {
// //   int? _sliding = 0;
// //   Color TextColor0 = Colors.white;
// //   Color TextColor1 = Colors.grey;

// //   @override
// //   Widget build(BuildContext context) {
// //     return CupertinoSlidingSegmentedControl(
// //       thumbColor: SihhaGreen1,
// //       onValueChanged: (int? value) {
// //         setState(() {
// //           _sliding = value;
// //           // value==1 ? TextColor1=Colors.white : TextColor1=Colors.black54;
// //           if (value == 1) {
// //             TextColor1 = Colors.white;
// //             TextColor0 = Colors.grey;
// //           } else {
// //             TextColor1 = Colors.grey;
// //             TextColor0 = Colors.white;
// //           }
// //         });
// //       },
// //       children: {
// //         0: Container(
// //           padding: EdgeInsets.all(4),
// //           // width: 120,
// //           child: Text(
// //             "Adulte",
// //             style: GoogleFonts.poppins(
// //               fontSize: 14,
// //               color: TextColor0,
// //               letterSpacing: 2,
// //             ),
// //           ),
// //         ),
// //         1: Container(
// //           padding: EdgeInsets.all(4),
// //           // width: 120,
// //           child: Text(
// //             "Mineur",
// //             style: GoogleFonts.poppins(
// //               fontSize: 14,
// //               color: TextColor1,
// //               letterSpacing: 2,
// //             ),
// //           ),
// //         ),
// //       },
// //       groupValue: _sliding,
// //     );
// //   }
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CupSlideControl extends StatefulWidget {
//   final Function(bool) function;
//   const CupSlideControl({Key? key, required this.function}) : super(key: key);

//   @override
//   State<CupSlideControl> createState() => _CupSlideControlState();
// }

// class _CupSlideControlState extends State<CupSlideControl> {
//   @override
//   Widget build(BuildContext context) {
//     Color textColor0 = sliding == 0 ? Colors.white : Colors.grey;
//     Color textColor1 = sliding == 1 ? Colors.white : Colors.grey;

//     return CupertinoSlidingSegmentedControl(
//       thumbColor: Colors.green, // Replace SihhaGreen1 with actual color
//       onValueChanged: widget.function,
//       groupValue: sliding,
//     );
//   }
// }
