import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
    // cameraController.dispose();
    // print('camera controller disposed from patient page');
    // isControllerStarted = false;
    // isScanned = false;
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(color: SihhaGreen1.withOpacity(0.5)),
                    // color: SihhaGreen1.withOpacity(0.18),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: _buildPatientInfo()),
          ),
        ),
        Container(
          height: 5,
          color: Colors.black,
        )
      ],
    );
  }

  Widget _buildMedicalTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Place your medical content here
        // You can customize this according to your requirement
        Text('Medical Information'),
      ],
    );
  }

  Widget _buildFamilleTab() {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsLine(
            'Nom : ${widget.patient!.familyName} \nPrenom : ${widget.patient!.name}',
            LineAwesomeIcons.identification_card,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${widget.patient!.birthDay ?? 'N/A'} . ${widget.patient!.birthMonth ?? 'N/A'} . ${widget.patient!.birthYear ?? 'N/A'}     |     ${(DateTime.now().year - (widget.patient!.birthYear ?? 0))} ans',
            LineAwesomeIcons.birthday_cake,
          ),
          SizedBox(height: 16),
          DetailsLine(
            '${widget.patient!.birthPlace ?? 'N/A'}',
            LineAwesomeIcons.map_marker,
          ),
          SizedBox(height: 16),
          DetailsLine(
            widget.patient!.gender != null && widget.patient!.gender == 'male'
                ? '${widget.patient!.gender ?? 'N/A'}'
                : '${widget.patient!.gender ?? 'N/A'}',
            widget.patient!.gender != null && widget.patient!.gender == 'male'
                ? LineAwesomeIcons.male
                : LineAwesomeIcons.female,
          ),
          SizedBox(height: 16),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.amber,
                width: 120,
                child: DetailsLine(
                  '${widget.patient!.weight ?? 'null' + '  Kg'}',
                  LineAwesomeIcons.hanging_weight,
                ),
              ),
              Container(
                // color: Colors.amber,
                width: 120,
                child: DetailsLine(
                  '${widget.patient!.height ?? 'null' + '  cm'}',
                  LineAwesomeIcons.ruler,
                ),
              ),
              Container(
                // color: Colors.amber,
                width: 120,
                child: DetailsLine(
                  // '${widget.patient!.bloodType ?? 'O+'}',

                  'O+',
                  LineAwesomeIcons.tint,
                ),
              ),
            ],
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
          // Text(
          //   'Bio',
          //   style: GoogleFonts.poppins(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //   ),
          // ),
          // Text(
          //   widget.patient!.bio ?? 'N/A',
          //   style: GoogleFonts.poppins(fontSize: 16),
          // ),
        ],
      ),
    );
  }

  Container DetailsLine(String text, IconData icon) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: 27,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: SihhaFont.copyWith(fontSize: 17),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
