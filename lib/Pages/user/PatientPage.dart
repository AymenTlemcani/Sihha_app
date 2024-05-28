import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/CommonWidgets/MyTile.dart';
import 'package:sahha_app/Models/Actors/Child.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/DossierMedicalPage.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnacesPage.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';
import 'package:sahha_app/Pages/user/ChildPage.dart';

class PatientPage extends StatefulWidget {
  final Patient? patient;

  const PatientPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _medicalTiles;
  // late LoginControllerProvider loginProvider;
  // late User currentUser; // Updated variable name
  // late Medcin currentMedcin;
  bool _shouldUseWrap() {
    return !(defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);
  }

  //
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loginProvider =
    //       Provider.of<LoginControllerProvider>(context, listen: false);
    //   currentUser =
    //       loginProvider.user!; // Accessing the user from loginProvider
    //   // Accessing the medcin from user
    // });
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _medicalTiles = [
      MyTile(
        icon: LineAwesomeIcons.folder_open,
        title: 'Dossier Medical',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped Dossier Medical');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DossierMedicalPage(
                medcin: globalMedcin,
                patient: widget.patient!,
              ),
            ),
          );
        },
      ),
      MyTile(
        icon: LineAwesomeIcons.file_signature,
        title: 'Ordonnances',
        iconColor: SihhaGreen2,
        itemColor1: SihhaGreen1.withOpacity(0.18),
        smallCircleColor1: Colors.white,
        onTapFunction: (BuildContext context) {
          print('user tapped Ordonnaces');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdonnancePage(
                  medcin: globalMedcin, patient: widget.patient!),
            ),
          );
        },
        // (BuildContext context) {
        //   // _showBottomSheet(context);
        // },
      ),
      // MyTile(
      //   icon: LineAwesomeIcons.stethoscope,
      //   title: 'Visites medicales',
      //   iconColor: SihhaGreen2,
      //   itemColor1: SihhaGreen1.withOpacity(0.18),
      //   smallCircleColor1: Colors.white,
      //   onTapFunction: (BuildContext context) {
      //     print('user tapped Visites medicales');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => VisitesMedicalesPage(),
      //       ),
      //     );
      //   },
      // ),

      // MyTile(
      //   icon: LineAwesomeIcons.syringe,
      //   title: 'Vaccins',
      //   iconColor: SihhaGreen2,
      //   itemColor1: SihhaGreen1.withOpacity(0.18),
      //   smallCircleColor1: Colors.white,
      //   onTapFunction: (BuildContext context) {
      //     print('user tapped Vaccins');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => VaccinsPage(),
      //       ),
      //     );
      //   },
      // ),
      // MyTile(
      //   icon: LineAwesomeIcons.microscope,
      //   title: 'Laboratoire',
      //   iconColor: SihhaGreen2,
      //   itemColor1: SihhaGreen1.withOpacity(0.18),
      //   smallCircleColor1: Colors.white,
      //   onTapFunction: (BuildContext context) {},
      // ),
      // MyTile(
      //   icon: LineAwesomeIcons.hospital,
      //   title: 'Operations',
      //   iconColor: SihhaGreen2,
      //   itemColor1: SihhaGreen1.withOpacity(0.18),
      //   smallCircleColor1: Colors.white,
      //   onTapFunction: (BuildContext context) {
      //     print('user tapped Operations');
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => OperationsPage(),
      //       ),
      //     );
      //   },
      // ),

      // Add other MyTile widgets as needed
    ];
    widget.patient!.fetchOrdonnances();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        setState(() {
          isScanned = false;
          isSuccessfullyScanned = false;
        });
      },
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: false,
          child: FloatingActionButton(
            onPressed: () {
              // print(patients?.length);
              // print(patients?[0].familyName);
              print(globalMedcin);
              print(widget.patient!.ordonnances);
              // print(widget.patient!.);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: widget.patient == null
            ? Center(child: Text('No patient data'))
            : RefreshIndicator(
                color: SihhaGreen1,
                onRefresh: () async {
                  // await fetchOrdonnances();
                  setState(() {});
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AppBarPatientPage(),
                          _NameAndFamilyName(),
                          //TODO add user name to database
                          Row(
                            children: [
                              _GreySmallText('@Username'),
                              _GreySmallText(
                                  '|      ${widget.patient!.IDN ?? ''}'),

                              // _GreySmallText(widget.patient!.telephone ?? ''),
                            ],
                          ),
                          _TabBar(),
                          Container(
                            color:
                                //
                                Colors.white,
                            //
                            // SihhaGreen1.withOpacity(1),
                            //
                            height:
                                //
                                0.55 * MediaQuery.sizeOf(context).height,
                            //
                            child: TabBarView(
                              // dragStartBehavior: DragStartBehavior.start,

                              controller: _tabController,
                              children: [
                                _buildDetailsTab(),
                                _buildMedicalTab(),
                                _buildFamilleTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  TabBar _TabBar() {
    return TabBar(
      controller: _tabController,

      labelStyle: SihhaFont.copyWith(
          fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1.1),
      tabs: [
        Tab(text: 'Détails'),
        Tab(text: 'Médical'),
        Tab(text: 'Famille'),
      ],
      labelColor: Colors.black,
      unselectedLabelStyle:
          SihhaFont.copyWith(fontSize: 15.5, fontWeight: FontWeight.w100),
      unselectedLabelColor: Color(0xFFb0b3b8),
      // Colors.grey,
      indicatorColor: SihhaGreen1,
      indicatorSize: TabBarIndicatorSize.label,
      splashFactory: NoSplash.splashFactory,
      enableFeedback: true,
      overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
    );
  }

  Padding _GreySmallText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: SihhaFont.copyWith(fontSize: 14, color: Color(0xFFb0b3b8)),
      ),
    );
  }

  Padding _NameAndFamilyName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        '${widget.patient?.familyName ?? ''} ${widget.patient?.name ?? ''}',
        style: SihhaPoppins3.copyWith(fontSize: 22),
      ),
    );
  }

  Container _AppBarPatientPage() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/back3.png"),
            fit: BoxFit.fill,
          )),
      child: Column(
          //
          crossAxisAlignment: CrossAxisAlignment.start,
          //
          children: [
            //back button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 35),
                  child: MyBackButton(
                    onTapFunction: () {
                      print(
                          "User Pressed on Back Button to go back to the QR scan Page");
                      Navigator.pop(
                        context,
                      );
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, top: 25),
                //   child: Text(
                //       '${widget.patient!.familyName} ${widget.patient!.name}',
                //       style: SihhaPoppins3.copyWith(fontSize: 17)),
                // ),
                Spacer()
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: MyProfilePicture(
                URL: widget.patient?.profilePicUrl,
                radius: 70,
                ImageHeight: 132,
                ImageWidth: 132,
                borderColor: SihhaGreen2,
              ),
            ),
            //
            SizedBox(height: 10),
          ]),
    );
  }

  Widget _buildDetailsTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Expanded(
        //   child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  // border: Border.all(color: SihhaGreen1.withOpacity(0.5)),
                  color: SihhaGreen1.withOpacity(0.18),
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: _buildPatientInfo()),
        ),
        // ),
        Container(
          height: 5,
          // color: Colors.black,
        )
      ],
    );
  }

/*
Numero carte
nom prenom
date de naissance age
lieu de naissance
i9ama
Gender


RH height wieght
situation familial
number of family members

Date de dernière mise à jour du dossier médical
nombre of ordonnances
number of vaccins
number of operations


// TODO we can add more details + n9smohom des groupes sghar
 */
  Widget _buildPatientInfo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsLine(
            'Nom : ${widget.patient!.familyName} \nPrenom : ${widget.patient!.name}',
            Colors.black,
            LineAwesomeIcons.identification_card,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${widget.patient!.birthDate!.toDate().day} . ${widget.patient!.birthDate!.toDate().month} . ${widget.patient!.birthDate!.toDate().year}    |     ${(DateTime.now().year - (widget.patient!.birthDate!.toDate().year))} ans',
            Colors.black,
            LineAwesomeIcons.birthday_cake,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${widget.patient!.birthPlace ?? 'N/A'}',
            Colors.black,
            LineAwesomeIcons.map_marker,
          ),
          SizedBox(height: 16),
          DetailsLine(
            widget.patient!.gender != null && widget.patient!.gender == 'male'
                ? '${widget.patient!.gender ?? 'N/A'}'
                : '${widget.patient!.gender ?? 'N/A'}',
            Colors.black,
            widget.patient!.gender != null && widget.patient!.gender == 'male'
                ? LineAwesomeIcons.male
                : LineAwesomeIcons.female,
          ),
          SizedBox(height: 16),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: DetailsLine(
                  widget.patient!.weights != null &&
                          widget.patient!.weights!.isNotEmpty
                      ? '${widget.patient!.weights!.last.weight!.round()} Kg'
                      : 'null Kg',
                  Colors.black,
                  LineAwesomeIcons.hanging_weight,
                ),
              ),
              Container(
                width: 120,
                child: DetailsLine(
                  widget.patient!.heights != null &&
                          widget.patient!.heights!.isNotEmpty
                      ? '${widget.patient!.heights!.last.height!.round()} cm'
                      : 'null cm',
                  Colors.black,
                  LineAwesomeIcons.ruler,
                ),
              ),
              Container(
                width: 84,
                child: DetailsLine(
                  widget.patient!.bloodGroup ?? 'null',
                  Colors.black,
                  LineAwesomeIcons.tint,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Widget _buildMedicalTab() {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(12.0),
  //           child: Container(
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //                 // border: Border.all(color: SihhaGreen1.withOpacity(0.5)),
  //                 // color: SihhaGreen1.withOpacity(0.18),
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: _shouldUseWrap() ? WebWrap() : PhoneGrid(),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         height: 5,
  //         color: Colors.black,
  //       )
  //     ],
  //   );
  // }
  Widget _buildMedicalTab() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: _shouldUseWrap() ? WebWrap() : PhoneGrid(),
    );
  }

  Widget _buildFamilleTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.patient!.familyMembers == null ||
            widget.patient!.familyMembers!.isEmpty)
          NoDataContainer()
        else
          Column(
            children: [
              SizedBox(height: 10),
              ...widget.patient!.familyMembers!
                  .map((membre) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: MembreTile(
                          patient: widget.patient!,
                          membre: membre,
                        ),
                      ))
                  .toList(),
              SizedBox(height: 10),
            ],
          ),
      ],
    );
  }

  Widget MembreTile({required Child membre, required Patient patient}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.transparent,
      onTap: () async {
        //Fetch data
        await membre.fetchOrdonnances();
        // Extract doctorProfilePicUrls
        List<String> doctorIDNS = [];

        if (membre.ordonnances != null) {
          for (Ordonnance ordonnance in membre.ordonnances!) {
            if (ordonnance.medcin![0].IDN != null) {
              doctorIDNS.add(ordonnance.medcin![0].IDN!);
            }
          }
        }
        Ordonnance ord = Ordonnance();
        doctorProfilePicUrls = await ord.fetchDoctorProfilePicUrls(doctorIDNS);
        // doctorProfilePicUrls
        await membre.fetchDiseases();
        await membre.fetchAllergies();
        await membre.fetchDisabilities();
        await membre.fetchHeights();
        await membre.fetchWeights();
        await membre.fetchBloodTypes();
        await membre.fetchHabits();
        await membre.fetchFamilyMembers();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChildPage(child: membre),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 0.4, color: Colors.black12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: MyProfilePicture2(
                URL: membre.profilePicUrl,
                frameRadius: 23,
                pictureRadius: 21,
                borderColor: SihhaGreen2,
                grayscale: false,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${membre.familyName} ${membre.name}',
                  style:
                      SihhaPoppins3.copyWith(fontSize: 18, letterSpacing: 1.2),
                ),
                SizedBox(height: 5),
                Text(
                  'Date de naissance: ${membre.birthDate!.toDate().day}/${membre.birthDate!.toDate().month}/${membre.birthDate!.toDate().year}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

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
                  'Aucun membre de la famille trouvé.',
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

  Future<void> _refreshPatientData() async {
    // Simulate a delay to mimic data fetching
    await Future.delayed(Duration(seconds: 2));

    // Perform any necessary operations to refresh the patient data
    // For example, you can re-fetch the data from Firestore or update the UI

    // After refreshing the data, you can update the UI if needed
    setState(() {});
  }

  Container DetailsLine(String text, Color textColor, IconData icon) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: Icon(
                icon,
                size: 30,
                color: SihhaGreen2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: SihhaFont.copyWith(fontSize: 17, color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget WebWrap() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          // alignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: _medicalTiles,
          // tiles.map((tile) => tile.build(context)).toList(),
        ),
      ),
    );
  }

  OrientationBuilder PhoneGrid() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Transform.translate(
                offset: Offset(0, -20),
                child: GridView.count(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  childAspectRatio:
                      orientation == Orientation.portrait ? 13 / 9 : 13 / 9,

                  // if you want to use crossAxisCount: 3 in portrait mode use 5/6 aspect ratio
                  // childAspectRatio: 5 / 6,
                  children: _medicalTiles,
                ),
              )
            : GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                childAspectRatio:
                    orientation == Orientation.portrait ? 13 / 9 : 13 / 9,

                // if you want to use crossAxisCount: 3 in portrait mode use 5/6 aspect ratio
                // childAspectRatio: 5 / 6,
                children: _medicalTiles,
              );
      },
    );
  }
}
    
     // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     isDismissible: true,
  //     useSafeArea: true,
  //     // enableDrag: true,
  //     // Colors.black.withOpacity(0.3),
  //     context: context,
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         expand: true, // Allow the sheet to expand to fullscreen
  //         initialChildSize: 0.6,
  //         minChildSize: 0.2,
  //         maxChildSize: 0.94,
  //         builder: (context, scrollController) {
  //           return ClipRRect(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25),
  //               topRight: Radius.circular(25),
  //             ),
  //             child: Container(
  //               color: Colors.white,
  //               child: SingleChildScrollView(
  //                 controller: scrollController,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             top: 8,
  //                           ),
  //                           child: Container(
  //                             width: 70,
  //                             height: 3,
  //                             color: SihhaGreen2,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 16,
  //                         vertical: 8,
  //                       ),
  //                       child: TextField(
  //                         maxLines: 4,
  //                         decoration: InputDecoration(
  //                           hintText: 'Add a comment',
  //                           border: InputBorder.none,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //-----------------------------------------------------------
  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     isDismissible: true,
  //     useSafeArea: true,
  //     isScrollControlled: true, // Set isScrollControlled to true
  //     context: context,
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.6, // Initial height of the bottom sheet
  //         maxChildSize: 1, // Maximum height of the bottom sheet
  //         minChildSize: 0.6, // Minimum height of the bottom sheet
  //         expand: false, // Disable the expansion to fullscreen
  //         builder: (context, scrollController) {
  //           return ClipRRect(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25),
  //               topRight: Radius.circular(25),
  //             ),
  //             child: Container(
  //               color: Colors.white,
  //               child: SingleChildScrollView(
  //                 controller: scrollController,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                             top: 8,
  //                           ),
  //                           child: Container(
  //                             width: 70,
  //                             height: 3,
  //                             color: SihhaGreen2,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 16, bottom: 4),
  //                           child: Text(
  //                             "Ordonannces",
  //                             textAlign: TextAlign.center,
  //                             style: GoogleFonts.poppins(
  //                               fontWeight: FontWeight.w500,
  //                               color: Colors.black,
  //                               fontSize: 17,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                     Divider(),
  //                     Container(color: Colors.teal, height: 100
  //                         // MediaQuery.of(context).size.height *    0.3
  //                         ), // Add a SizedBox to fill the remaining space
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //TODO we can add bottom sheet later on
  // void _showBottomSheet(BuildContext context) {
  //   bool isExpanded = false;
  //   ScrollController ordonnancesScrollController = ScrollController();

  //   showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     isDismissible: true,
  //     useSafeArea: true,
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: isExpanded ? 1 : 0.6,
  //         maxChildSize: 1,
  //         minChildSize: 0.6,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return ClipRRect(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(25),
  //               topRight: Radius.circular(25),
  //             ),
  //             child: Container(
  //               color: Colors.white,
  //               child: NotificationListener<ScrollNotification>(
  //                 onNotification: (notification) {
  //                   if (notification is ScrollEndNotification) {
  //                     final metrics = notification.metrics;
  //                     if (metrics.pixels >= metrics.maxScrollExtent - 50) {
  //                       isExpanded = true;
  //                     } else if (metrics.pixels <= 50) {
  //                       isExpanded = false;
  //                     }
  //                     setState(() {});
  //                   }
  //                   return false;
  //                 },
  //                 child: SingleChildScrollView(
  //                   controller: scrollController,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.only(
  //                               top: 8,
  //                             ),
  //                             child: Container(
  //                               width: 70,
  //                               height: 3,
  //                               color: SihhaGreen2,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Padding(
  //                             padding:
  //                                 const EdgeInsets.only(top: 16, bottom: 4),
  //                             child: Text(
  //                               "Ordonnances",
  //                               textAlign: TextAlign.center,
  //                               style: GoogleFonts.poppins(
  //                                 fontWeight: FontWeight.w500,
  //                                 color: Colors.black,
  //                                 fontSize: 17,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Divider(),
  //                       SizedBox(
  //                         height: MediaQuery.sizeOf(context).height * 0.9,
  //                         child: NotificationListener<ScrollNotification>(
  //                           onNotification: (notification) {
  //                             if (notification is ScrollEndNotification) {
  //                               final metrics = notification.metrics;
  //                               if (metrics.pixels >=
  //                                   metrics.maxScrollExtent - 50) {
  //                                 isExpanded = true;
  //                               } else if (metrics.pixels <= 50) {
  //                                 isExpanded = false;
  //                               }
  //                               setState(() {});
  //                             }
  //                             return false;
  //                           },
  //                           child: ListView.builder(
  //                             controller: ordonnancesScrollController,
  //                             itemCount:
  //                                 10, // Replace with the actual number of ordonnances
  //                             itemBuilder: (context, index) {
  //                               return Container(
  //                                 color: Colors.teal,
  //                                 height: 100,
  //                                 child: Center(
  //                                   child: Text('Ordonnance ${index + 1}'),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                       // Divider(),
  //                       // Container(color: Colors.teal, height: 100),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }