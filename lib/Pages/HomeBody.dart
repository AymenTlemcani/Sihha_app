import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/Common/Variables.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Color> appBarGradientColors = [
    Colors.grey.shade300,
    Colors.grey.shade300,
    Colors.grey.shade300,
    Colors.grey.shade300,
    Colors.grey.shade300,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade100,
    Colors.grey.shade100,
    Colors.grey.shade100,
  ];
  bool? isMale = true;
  String? userName = 'Aymen';
  bool isVisible = modeAdmin;
  bool isV() {
    setState(() {
      isVisible = modeAdmin;
    });
    return isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: [
              AppBarHomePage(),
              SizedBox(height: 15),
              Container(
                height: 1200,
              )
            ],
          )),
    );
  }

  Container AppBarHomePage() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0.0)
          ],
          border: Border(bottom: BorderSide(color: Colors.black12)),
          gradient: LinearGradient(
              colors: appBarGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          shape: BoxShape.rectangle
          // image: DecorationImage(
          //     image: AssetImage("assets/background1.png"), fit: BoxFit.cover)
          ),
      child: Column(children: [
        //Row of the picture
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 33, 0, 0),
              child: GestureDetector(
                onTap: () {
                  // print("Pressed");
                  // Navigator.pop(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProfilePage()));
                },
                child: CircleAvatar(
                  foregroundImage: AssetImage('assets/Etchiali.jpeg'),
                  radius: 20,
                ),
              ),
            ),
          ],
        ),

        // 2nd row fih logo and language selector
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.translate(
                offset: Offset(-30, -30),
                child: SvgPicture.asset(
                  "assets/svg-cropped.svg",
                  height: 70,
                )),
          ],
        ),

        Row(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: welcomeMessage()),
          ],
        ),
      ]),
    );
  }

  CustomScrollView sliverAppBar() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        actions: [],
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        // backgroundColor: Color.fromARGB(255, 80, 150, 118),
        pinned: false,
        floating: false,
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
            stretchModes: [StretchMode.fadeTitle],
            collapseMode: CollapseMode.pin,
            title: welcomeMessage(),
            background: Image.asset(
              'assets/HomePageAppBarBackground (1).png',
              fit: BoxFit.cover,
            )),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
          height: 1400,
          decoration: BoxDecoration(color: Colors.white),
        ),
      ]))
    ]);
  }

  RichText welcomeMessage() {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: 'Bienvenu,  ',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, color: Colors.black, fontSize: 18)),
      TextSpan(
          text: userName == null
              ? 'userName'.toUpperCase()
              : '${userName!.toUpperCase()}',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 25))
    ]));
  }
}
