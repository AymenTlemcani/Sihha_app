import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/CommonWidgets/MyDrawer.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/admin/AdminDashboard.dart';
import 'package:sahha_app/Pages/services/MEDICAL/MedicalPage.dart';
import 'package:sahha_app/Pages/user/CardPage.dart';
import 'package:sahha_app/Pages/user/FamilyPage.dart';
import 'package:sahha_app/Pages/user/Profile.dart';
import 'package:sahha_app/Pages/user/Responsive/HomeBodyDesktop.dart';
import 'package:sahha_app/Providers/DesktopNavigationProvider.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

final List<Widget> _screens = [
  Profile(),
  HomeBodyDesktop(),
  CardPage(),
  MedicalPage(),
  FamilyPage(),
  if (user!.isAdmin) AdminDashboard(),
];

class _DesktopViewState extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.outer,
                  color: Colors.black38,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(-25, 0),
                )
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: BorderDirectional(
                end: BorderSide(
                  style: BorderStyle.none,
                  // color: Colors.black12.withOpacity(0.1),
                  width: 15,
                ),
              ),
            ),
            child: MyDrawer(),
          ),
          Expanded(
            child: Consumer<DesktopNavigationProvider>(
              builder: (context, navProvider, _) {
                return Navigator(
                  key: navigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => HomeScafold(
                      navigatorKey.currentContext!,
                      selectedIndex: navProvider.selectedIndex,
                      screens: _screens,
                    ),
                  ),
                );
              },
            ),
          ),
          // Expanded(
          //   child: Consumer<DesktopNavigationProvider>(
          //     builder: (context, navProvider, _) {
          //       return HomeScafold(
          //         selectedIndex: navProvider.selectedIndex,
          //         screens: _screens,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Scaffold HomeScafold(BuildContext context,
      {required int selectedIndex, required List<Widget> screens}) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg-cropped.svg",
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              "assets/Logo Green2.svg",
              height: 17,
            ),
          ],
        ),
      ),
      // body: Navigator(
      //   onGenerateRoute: (settings) {
      //     return MaterialPageRoute(
      //       builder: (context) => screens[selectedIndex],
      //     );
      //   },
      // ),
      body: screens[selectedIndex],
    );
  }
//   Scaffold HomeScafold(BuildContext context,
//       {required int selectedIndex, required List<Widget> screens}) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         foregroundColor: Colors.white,
//         shadowColor: Colors.transparent,
//         surfaceTintColor: Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               "assets/svg-cropped.svg",
//               height: 30,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             SvgPicture.asset(
//               "assets/Logo Green2.svg",
//               height: 17,
//             ),
//           ],
//         ),
//       ),
//       body: screens[selectedIndex],
//     );
//   }
// }
}
