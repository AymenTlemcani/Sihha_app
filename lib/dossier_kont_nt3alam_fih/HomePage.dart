import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sahha_app/Pages/user/CardPage.dart';
import 'package:sahha_app/Pages/user/MedicalPage.dart';
import 'package:sahha_app/Pages/user/FamilyPage.dart';
import 'package:sahha_app/dossier_kont_nt3alam_fih/ProfilePage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  List _TabBarWidgets = [
    // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.home)),
    // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.person)),
    // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart_fill)),
    // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.person_3_fill)),
    // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.settings)),
    // HomeBody(),
    CardPage(),
    MedicalPage(),
    FamilyPage(),
    ProfilePage(),
  ];

// sign user out method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TabBarWidgets[_selectedindex],

      // Center(
      //     child: Text(
      //   'LOGGED IN AS : ' + user.email!,
      //   style: GoogleFonts.poppins(fontSize: 20),
      // )),
      bottomNavigationBar:
          // BottomNavBar2()
          BottomNavBar3(),
    );
  }

  NavigationBar BottomNavBar3() {
    return NavigationBar(
      indicatorShape: CircleBorder(),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      animationDuration: Duration(milliseconds: 500),
      height: 50,
      elevation: 0.3,
      selectedIndex: _selectedindex,
      onDestinationSelected: _navigateBottomBar,
      destinations: [
        NavigationDestination(label: "Home", icon: Icon(CupertinoIcons.home)),
        NavigationDestination(
            label: "Profile", icon: Icon(CupertinoIcons.person)),
        NavigationDestination(
            label: "Favorites", icon: Icon(CupertinoIcons.heart)),
        NavigationDestination(
            label: "Friends", icon: Icon(CupertinoIcons.person_3_fill)),
        NavigationDestination(
            label: "Settings", icon: Icon(CupertinoIcons.settings)),
      ],
    );
  }

  NavigationBar BottomNavBar2() {
    return NavigationBar(
      indicatorShape: CircleBorder(side: BorderSide.none, eccentricity: 1),
      indicatorColor: HexColor("11509776"),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      animationDuration: Duration(milliseconds: 500),
      height: 50,
      elevation: 0.3,
      selectedIndex: _selectedindex,
      onDestinationSelected: _navigateBottomBar,
      destinations: [
        NavigationDestination(label: "Home", icon: Icon(CupertinoIcons.home)),
        NavigationDestination(
            label: "Profile", icon: Icon(CupertinoIcons.person)),
        NavigationDestination(
            label: "Favorites", icon: Icon(CupertinoIcons.heart)),
        NavigationDestination(
            label: "Friends", icon: Icon(CupertinoIcons.person_3_fill)),
        NavigationDestination(
            label: "Settings", icon: Icon(CupertinoIcons.settings)),
      ],
    );
  }

  BottomNavigationBar BottomNavBar1() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,

      /// Selected
      selectedItemColor: HexColor('509776'),
      showSelectedLabels: true,
      selectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
      ),
      selectedIconTheme: CupertinoIconThemeData(size: 20),
      selectedFontSize: 12,

      /// Unselected
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      unselectedLabelStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.w400, letterSpacing: 2),
      unselectedIconTheme: CupertinoIconThemeData(size: 20),

      ///
      currentIndex: _selectedindex,
      onTap: _navigateBottomBar,
      items: [
        BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              CupertinoIcons.home,
              // color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              CupertinoIcons.person_fill,
              // color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: 'Medical',
            backgroundColor: Colors.white,
            icon: Icon(
              CupertinoIcons.heart_fill,
              // color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: 'Family',
            icon: Icon(
              CupertinoIcons.person_3_fill,
              // color: Colors.black,
            )),
        BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(
              CupertinoIcons.settings,
              // color: Colors.black,
            )),
      ],
    );
  }
}
