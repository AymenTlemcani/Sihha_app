import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahha_app/CommonWidgets/MyDrawer.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
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
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.green,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Padding _NameAndFamilyName() {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    ),
  );
}
