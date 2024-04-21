import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sahha_app/utils/Variables.dart';

import 'package:sahha_app/Pages/user/CardPage.dart';
import 'package:sahha_app/Pages/user/FamilyPage.dart';
import 'package:sahha_app/Pages/user/HomeBody.dart';

class PersistentTabSreen extends StatefulWidget {
  const PersistentTabSreen({
    super.key,
  });

  @override
  State<PersistentTabSreen> createState() => _PersistentTabSreenState();
}

class _PersistentTabSreenState extends State<PersistentTabSreen> {
  late PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      HomeBody(),
      CardPage(),
      // DossierMedicalPage(),
      FamilyPage(),
      // Profile(),
      // ProfilePage(),
    ];
  }

  final TextStyle textstyle =
      GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600);
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.house_fill),

        // SvgPicture.asset("assets/Icons/home.svg"),
        inactiveIcon: Icon(CupertinoIcons.house),
        title: ("Home"),
        activeColorPrimary: SihhaGreen1,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: textstyle,
      ),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.creditcard_fill),

          // SvgPicture.asset("assets/Icons/card.svg"),
          inactiveIcon: Icon(CupertinoIcons.creditcard),
          title: ("Cards"),
          activeColorPrimary: SihhaGreen1,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: textstyle),
      /*PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.heart_fill),

          // SvgPicture.asset("assets/Icons/heart.svg"),
          inactiveIcon: Icon(CupertinoIcons.heart),
          title: ("Medical"),
          activeColorPrimary: SihhaGreen1,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: textstyle),*/
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_3_fill),
          // SvgPicture.asset("assets/Icons/Users.svg"),

          inactiveIcon: Icon(CupertinoIcons.person_3),
          title: ("Family"),
          activeColorPrimary: SihhaGreen1,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: textstyle),
      // PersistentBottomNavBarItem(
      //     icon: Icon(CupertinoIcons.person_fill),
      //     // CircleAvatar(
      //     //   // foregroundImage: AssetImage('assets/Etchiali.jpeg'),
      //     //   radius: 100,
      //     //   backgroundColor: SihhaGreen1,
      //     // ),
      //     // SvgPicture.asset("assets/Icons/user-circle.svg"),
      //     inactiveIcon: Icon(CupertinoIcons.person),
      //     //     CircleAvatar(
      //     //   // foregroundImage: AssetImage('assets/Etchiali.jpeg'),
      //     //   radius: 100,
      //     //   backgroundColor: SihhaGreen1,
      //     //   child: ClipOval(
      //     //       child: SizedBox.fromSize(
      //     //     size: Size.fromRadius(48),
      //     //     child: Image.asset('assets/Etchiali.jpeg'),
      //     //   )),
      //     // ),
      //     title: ("Profile"),
      //     // iconSize: ,
      //     activeColorPrimary: SihhaGreen1,
      //     inactiveColorPrimary: CupertinoColors.systemGrey,
      //     textStyle: textstyle),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      // navBarHeight: 55,

      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.black12)),
        borderRadius: BorderRadius.circular(8.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style11, // Choose the nav bar style with this property.
      padding: NavBarPadding.all(8),
      hideNavigationBar: false,
    );
  }
}
