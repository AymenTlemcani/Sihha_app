import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/Models/Patient.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/Qr/ScanQR.dart';

class PatientPage extends StatefulWidget {
  final Patient? patient;

  const PatientPage({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        });
      },
      child: Scaffold(
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
                          _Username(),
                          _TabBar(),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      child: TabBarView(
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
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return PopScope(
  //     onPopInvoked: (didPop) async {
  //       setState(() {
  //         isScanned = false;
  //       });
  //     },
  //     child: Scaffold(
  //       backgroundColor: Colors.white,
  //       body: widget.patient == null
  //           ? Center(child: Text('No patient data'))
  //           : RefreshIndicator(
  //               color: SihhaGreen1,
  //               onRefresh: () async {
  //                 // await fetchOrdonnances();
  //                 setState(() {});
  //               },
  //               child: CustomScrollView(
  //                 slivers: [
  //                   SliverToBoxAdapter(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         _AppBarPatientPage(),
  //                         _NameAndFamilyName(),
  //                         _Username(),
  //                         // SizedBox(height: 10),

  //                         _TabBar(),
  //                         // SizedBox(height: 10),
  //                         Container(
  //                           color:
  //                               //
  //                               Colors.red,
  //                           //
  //                           // SihhaGreen1.withOpacity(0.03),
  //                           //
  //                           // height: 400, // Adjust height as needed
  //                           child: TabBarView(
  //                             controller: _tabController,
  //                             children: [
  //                               _buildDetailsTab(),
  //                               _buildMedicalTab(),
  //                               _buildFamilleTab(),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //     ),
  //   );
  // }

  TabBar _TabBar() {
    return TabBar(
      controller: _tabController,
      labelStyle: SihhaFont.copyWith(
          fontSize: 15.5, fontWeight: FontWeight.w500, letterSpacing: 1.1),
      tabs: [
        Tab(text: 'Détails'),
        Tab(text: 'Médical'),
        Tab(text: 'Famille'),
      ],
      labelColor: Colors.black,
      unselectedLabelColor: Color(0xFFb0b3b8),
      // Colors.grey,
      indicatorColor: SihhaGreen1,
      indicatorSize: TabBarIndicatorSize.label,
      splashFactory: NoSplash.splashFactory,
      enableFeedback: true,
      overlayColor: MaterialStateProperty.all(SihhaGreen2.withOpacity(0.2)),
    );
  }

  Padding _Username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        '@Username',
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
                  padding: const EdgeInsets.only(left: 10, top: 25),
                  child: MyBackButton(
                    onTapFunction: () {
                      print(
                          "User Pressed on Back Button to go back to the QR scan Page");
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeScannerPage(),
                        ),
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
            //
            SizedBox(
              height: 10,
            ),
            //
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
            SizedBox(height: 15),
          ]),
    );
  }

  // Widget _buildDetailsTab() {
  //   return Column(
  //     children: [
  //       // Place your details content here
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                       color: SihhaGreen1.withOpacity(1),
  //                       child: _buildPatientInfo()),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  Widget _buildDetailsTab() {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 800,
                color: SihhaGreen1.withOpacity(1),
                child: _buildPatientInfo(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalTab() {
    return Column(
      children: [
        // Place your medical content here
        // You can customize this according to your requirement
        Text('Medical Information'),
      ],
    );
  }

  Widget _buildFamilleTab() {
    return Column(
      children: [
        // Place your famille content here
        // You can customize this according to your requirement
        Text('Famille Information'),
      ],
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

  Widget _buildPatientInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '${widget.patient!.name} ${widget.patient!.familyName}',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Gender',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.gender ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Birth Date',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '${widget.patient!.birthDay}/${widget.patient!.birthMonth}/${widget.patient!.birthYear}',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Birth Place',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.birthPlace ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Phone Number',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.telephone ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          'Bio',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          widget.patient!.bio ?? 'N/A',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }
}
