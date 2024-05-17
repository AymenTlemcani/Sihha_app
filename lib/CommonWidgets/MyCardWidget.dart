import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 20,
              offset: Offset(0, 5))
        ],
        // color: SihhaGreen1.withOpacity(0.1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: SihhaGreen1.withOpacity(0.03),
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(
                  300,
                  (300 * 1.6666666666666667)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                  ],
                ),
                //TODO APP NAME
                SizedBox(height: 20),
                MyProfilePicture(
                  URL: user!.profilePicUrl,
                  radius: 70,
                  ImageHeight: 132,
                  ImageWidth: 132,
                  borderColor: SihhaGreen2,
                  iconSize: 60,
                ),
                SizedBox(height: 10),
                Text(
                  '${user!.familyName} ${user!.name}',
                  style: SihhaPoppins3.copyWith(fontSize: 20),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  '#${user!.IDN}',
                  style: SihhaPoppins3.copyWith(
                      fontSize: 15, color: Colors.black54),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text(
                  '${user!.birthDay} . ${user!.birthMonth! < 10 ? '0' : ''}${user!.birthMonth} . ${user!.birthYear}  |  ${user!.birthPlace}',
                  style: SihhaPoppins3.copyWith(
                      fontSize: 15, color: Colors.black54),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      ),
                  height: 90,
                  child: PrettyQrView.data(
                    data: user!.documentId ?? '',
                    decoration: PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          color: SihhaGreen2,
                          roundFactor: 0.5,
                        ),
                        background: Colors.white),
                  ),
                ),
                Spacer(),
                Container(
                  height: 10,
                  // color: SihhaGreen3,
                )
              ],
            )
            // Transform.translate(
            //   offset: Offset(0, 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Logo(),
            //     ],
            //   ),
            // ),
            //********************************** */
            // Transform.translate(
            //   offset: Offset(0, 90),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           MyProfilePicture(
            //             URL: user!.profilePicUrl,
            //             radius: 70,
            //             ImageHeight: 132,
            //             ImageWidth: 132,
            //             borderColor: SihhaGreen2,
            //             iconSize: 60,
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 10),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             '${user!.familyName} ${user!.name}',
            //             style: SihhaPoppins3.copyWith(fontSize: 20),
            //             maxLines: 2,
            //             textAlign: TextAlign.center,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            //***************** */
          ],
        ),
      ),
    );
  }
}

Widget Logo() {
  return Container(
    child: Column(
      children: [
        SvgPicture.asset(
          "assets/svg-cropped.svg",
          height: 50,
        ),
      ],
    ),
  );
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = SihhaGreen1.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8933000, size.height * 0.0304800);
    path_0.cubicTo(
        size.width * 0.6976333,
        size.height * -0.0228600,
        size.width * 0.5089000,
        size.height * -0.0000200,
        size.width * 0.2468667,
        size.height * 0.0906800);
    path_0.cubicTo(
        size.width * 0.1247667,
        size.height * 0.1675600,
        size.width * 0.1112667,
        size.height * 0.2372000,
        size.width * 0.3269000,
        size.height * 0.3689800);
    path_0.quadraticBezierTo(size.width * 0.6568000, size.height * 0.5442200,
        size.width * 0.9969037, size.height * 0.2379936);
    path_0.quadraticBezierTo(size.width * 1.0268333, size.height * 0.0876200,
        size.width * 0.8933000, size.height * 0.0304800);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(0, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
