import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahha_app/CommonWidgets/MyDrawer.dart';

class TabletView extends StatefulWidget {
  const TabletView({super.key});

  @override
  State<TabletView> createState() => _MobileViewState();
}

class _MobileViewState extends State<TabletView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/svg-cropped.svg",
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              "assets/Logo Green2.svg",
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
