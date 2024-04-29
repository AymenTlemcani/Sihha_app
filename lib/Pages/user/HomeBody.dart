import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Models/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/DossierMedical.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/Pages/admin/CreateUser.dart';
import 'package:sahha_app/Pages/user/Profile.dart';

class HomeBody extends StatefulWidget {
  HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Widget> tiles = [
    // List of MyTile widgets here
    Visibility(
      //FIXME add mode Admin Toggle and remove isAdmin
      visible: isAdmin || modeAdmin,
      child: MyTile(
        icon: LineAwesomeIcons.user_plus,
        title: 'Créer un\n compte',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped create an account');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUser(),
            ),
          );
        },
      ),
    ),
    Visibility(
      visible: isAdmin || modeAdmin || isMedcin,
      child: MyTile(
        icon: LineAwesomeIcons.qrcode,
        title: 'Scanner un Code QR',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped Qr Scanner');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeScannerPage(),
            ),
          );
        },
      ),
    ),
    MyTile(
      icon: LineAwesomeIcons.heartbeat,
      title: 'Dossier Medical',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {
        print('user tapped Dossier Medical');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DossierMedical(),
          ),
        );
      },
    ),
    Visibility(
      visible: isAdmin || modeAdmin,
      child: MyTile(
        icon: LineAwesomeIcons.user_edit,
        title: 'Modifier un compte',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {},
      ),
    ),

    MyTile(
      icon: LineAwesomeIcons.laptop_code,
      title: 'item1',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.laptop_medical,
      title: 'item2',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.address_card,
      title: 'item3',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.folder_open,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.alternate_medical_file,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.file_signature,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.user_check,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.syringe,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),
    MyTile(
      icon: LineAwesomeIcons.pills,
      title: 'item4',
      iconColor: SihhaGreen2,
      itemColor1: SihhaGreen1.withOpacity(0.18),
      smallCircleColor1: Colors.white,
      onTapFunction: (BuildContext context) {},
    ),

    // Add other MyTile widgets as needed
  ];

  List<Ordonnance> ordonnances = [];
  @override
  void initState() {
    super.initState();
    fetchOrdonnances();
    setState(() {});
  }

  Future<void> fetchOrdonnances() async {
    final ordonnancesRef = FirebaseFirestore.instance.collection('ordonnances');
    QuerySnapshot querySnapshot =
        await ordonnancesRef.where('patientIDN', isEqualTo: IDN).get();
    setState(() {
      ordonnances = querySnapshot.docs
          .map((doc) => Ordonnance.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: SihhaGreen1,
        onRefresh: () async {
          await fetchOrdonnances();
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarHomePage(),
                  SizedBox(height: 20),
                  Titre('Accés rapide'),
                  _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
                  SizedBox(height: 10),
                  Titre('Les ordonnances'),
                  ordonnances.isEmpty
                      ? NoDataContainer()
                      : OrdonnancesListView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: CustomScrollView(
  //       slivers: [
  //         SliverToBoxAdapter(
  //           child: RefreshIndicator(
  //             color: Colors.red,
  //             onRefresh: () async {
  //               await fetchOrdonnances();
  //               setState(() {});
  //             },
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 AppBarHomePage(),
  //                 SizedBox(height: 20),
  //                 Titre('Accés rapide'),
  //                 _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
  //                 SizedBox(height: 10),
  //                 Titre('Les ordonnances'),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SliverList(
  //           delegate: SliverChildListDelegate([
  //             OrdonnancesListView(),
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     // floatingActionButton: AddOrdonnance(),
  //     body: RefreshIndicator(
  //       onRefresh: () async {
  //         await fetchOrdonnances();

  //         setState(() {});
  //       },
  //       child: SingleChildScrollView(
  //         reverse: false,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             AppBarHomePage(),
  //             SizedBox(height: 20),
  //             Titre('Accés rapide'),
  //             // Use either ListView or Wrap 3la 7sab lplatform
  //             _shouldUseWrap() ? WrapAccesRapide() : ListViewAccesRapide(),
  //             SizedBox(height: 10),
  //             Titre('Les ordonnances'),
  //             OrdonnancesListView(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget NoDataContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: SihhaGreen1.withOpacity(0.05),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Center(
                child: Text(
                  'Aucune ordonnance trouvée.',
                  style:
                      SihhaPoppins3.copyWith(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding OrdonnancesListView() {
    // Sort ordonnances by date of creation in descending order
    ordonnances.sort((a, b) => b.dateOfCreation.compareTo(a.dateOfCreation));

    // Take the last 5 ordonnances
    List<Ordonnance> displayedOrdonnances = ordonnances.take(5).toList();

    int totalOrdonnaces = displayedOrdonnances.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: SihhaGreen1.withOpacity(0.18),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: displayedOrdonnances.asMap().entries.map((entry) {
                int index = entry.key;
                Ordonnance ordonnance = entry.value;
                return Column(
                  children: [
                    OrdonnanceTile(ordonnance: ordonnance),
                    if (index <
                        totalOrdonnaces - 1) // Check if it's not the last item
                      Divider(
                        endIndent: 10,
                        indent: 60,
                        thickness: 0.4,
                      )
                    else
                      SizedBox(
                          height:
                              10), // Use SizedBox instead of Divider for the last item
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget OrdonnanceTile({required Ordonnance ordonnance}) {
    return FutureBuilder<List<String?>>(
      future: ordonnance.fetchDoctorProfilePicUrls([ordonnance.doctorIDN]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height: 70);
          // CircularProgressIndicator(color: Colors.white,);
        }
        if (snapshot.hasError) {
          return Text('Error fetching profile picture');
        }
        List<String?> doctorProfilePicUrls = snapshot.data ?? [];
        return Container(
          height: 70,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: doctorProfilePicUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: MyProfilePicture(URL: url, radius: 20),
                    );
                  }).toList(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      ordonnance.doctorName,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                  Text(
                    ordonnance.speciality,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                '${ordonnance.dateOfCreation.toDate().day}/${ordonnance.dateOfCreation.toDate().month}/${ordonnance.dateOfCreation.toDate().year}\n     ${ordonnance.dateOfCreation.toDate().hour}:${ordonnance.dateOfCreation.toDate().minute}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 1.3,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }

  // FloatingActionButton AddOrdonnance() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       if (prescriptions.length < 8) {
  //         DateTime now = DateTime.now();
  //         setState(() {
  //           prescriptions.add({
  //             'doctorName': '(Nom de Medcin) ${prescriptions.length + 1}',
  //             'specialty': 'Specialty',
  //             'dateOfCreation': now,
  //             'prescriptionId': 'ID_${now.microsecondsSinceEpoch}',
  //           });
  //         });
  //       }
  //     },
  //     tooltip: 'Add Prescription',
  //     child: Icon(Icons.add),
  //   );
  // }

  bool _shouldUseWrap() {
    return !(defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  // Wrap for Web platform
  Widget WrapAccesRapide() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          // alignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: tiles,
          // tiles.map((tile) => tile.build(context)).toList(),
        ),
      ),
    );
  }

  // ListView for non-Web platforms
  Widget ListViewAccesRapide() {
    return Container(
      height: 180,
      color: Colors.white,
      child: ListView(
          padding: EdgeInsets.all(12),
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: tiles),
    );
  }

  Padding Titre(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
      child: Text(text, style: SihhaPoppins3),
    );
  }

  Container AppBarHomePage() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [
          //   BoxShadow(
          //       color: const Color(0xff1D1617).withOpacity(0.1),
          //       blurRadius: 10,
          //       spreadRadius: 0.0)
          // ],
          // border: Border(bottom: BorderSide(color: Colors.black12)),
          // gradient: LinearGradient(
          //     colors: appBarGradientColors,
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/back3.png"),
            fit: BoxFit.fill,
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        firstRowProfileButtonAndLogo(),

        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 5, 5),
          child: Text('Bienvenu,',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 25)),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(40, 5, 5, 30),
          child: Row(
            children: [
              modeMedcin || modePharmacie
                  ? Text('Dr. ', style: SihhaPoppins2)
                  : Text(gender == 'male' ? 'M. ' : 'Mme. ',
                      style: SihhaPoppins2),
              Text(
                  name == null
                      ? 'userName'.toUpperCase()
                      : '${familyName} ${name!.split(' ')[0]}',
                  style: SihhaPoppins2),
            ],
          ),
        ),

        // Row(
        //   children: [
        //     Padding(
        //         padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //         child: welcomeMessage()),
        //   ],
        // ),
      ]),
    );
  }

  Row firstRowProfileButtonAndLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },

            //TODO ki nbdlo photo de profile w nwliw l homePage la photo marahach ttl3 khas 7eta dir logout
            //we can use stream builder or future buider to get the user image from firebase storage or in init state
            child: MyProfilePicture(
                URL: profilePicUrl,
                radius: 24,
                ImageHeight: 43,
                ImageWidth: 43,
                borderColor: Colors.white),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Transform.translate(
          offset: Offset(-35, 40),
          child: SvgPicture.asset(
            "assets/svg-cropped.svg",
            height: 70,
          ),
        ),
      ],
    );
  }
}
