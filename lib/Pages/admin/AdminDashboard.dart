import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyTextForm.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/admin/CreateUserDesktop.dart';
import 'package:sahha_app/Pages/admin/Statistique.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminDashboard> createState() => _HomeBodyDesktopState();
}

class _HomeBodyDesktopState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  final List<Widget> _Adminscreens = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () async {
            print(user!.documentId);
            print(user!.adresse);
            print(user!.isPharmacien);
            // Map<String, int> numbers = await fetchNumbers();
            // print(numbers);

            // print(user!.ordonnances![0].medicaments![0].name);
            // print(user!.speciality);
            // print(patients?.length);
            // print(patients?[0].familyName ?? '');
            // patients?.clear();
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.white,
        title: TabBar(
          controller: _tabController,
          labelStyle: SihhaFont.copyWith(
              fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1.1),
          tabs: const [
            Tab(text: 'Statistiques'),
            Tab(text: 'Créer un compte'),
            Tab(text: 'Modifier un compte'),
            Tab(text: 'Demandes Carte Sihha'),
          ],
          labelColor: Colors.black,
          unselectedLabelStyle:
              SihhaFont.copyWith(fontSize: 15.5, fontWeight: FontWeight.w100),
          unselectedLabelColor: Color(0xFFb0b3b8),
          indicatorColor: SihhaGreen1,
          indicatorSize: TabBarIndicatorSize.label,
          splashFactory: NoSplash.splashFactory,
          enableFeedback: true,
          overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
        ),

        // bottom:
        // TabBar(
        //   controller: _tabController,
        //   labelStyle: SihhaFont.copyWith(
        //       fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1.1),
        //   tabs: const [
        //     Tab(text: 'Statistiques'),
        //     Tab(text: 'Créer un compte'),
        //     Tab(text: 'Modifier un compte'),
        //     Tab(text: 'Demandes Carte Sihha'),
        //   ],
        //   labelColor: Colors.black,
        //   unselectedLabelStyle:
        //       SihhaFont.copyWith(fontSize: 15.5, fontWeight: FontWeight.w100),
        //   unselectedLabelColor: Color(0xFFb0b3b8),
        //   indicatorColor: SihhaGreen1,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   splashFactory: NoSplash.splashFactory,
        //   enableFeedback: true,
        //   overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
        // ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Statistique(),
          CreateUserDesktop(),
          Container(),
          Container(),
          // EditUser(),
          // ResquestSihhaCard(),
        ],
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [

// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Statistiques',
//       selectedIcon: CupertinoIcons.chart_bar_square_fill,
//       unselectedIcon: CupertinoIcons.chart_bar_square,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Créer un compte',
//       selectedIcon: CupertinoIcons.person_add_solid,
//       unselectedIcon: CupertinoIcons.person_add,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Modifier un compte',
//       selectedIcon: CupertinoIcons.pencil_circle_fill,
//       unselectedIcon: CupertinoIcons.pencil_circle,
//       onTap: () {},
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: MyDrawerTile(
//       label: 'Demandes Carte Sihha',
//       selectedIcon: CupertinoIcons.creditcard_fill,
//       unselectedIcon: CupertinoIcons.creditcard_fill,
//       onTap: () {},
//     ),
//   ),
// ),
//   ],
// ),
