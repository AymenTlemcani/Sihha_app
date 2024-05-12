import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/MEDICAL/addOrdonnace.dart';

class OrdonnancePage extends StatefulWidget {
  const OrdonnancePage({Key? key, this.medcin, required this.patient})
      : super(key: key);
  final User?
      medcin; // null if patient is viewing own ordonnances (not required)
  final Patient patient;

  @override
  State<OrdonnancePage> createState() => _OrdonnancePageState();
}

class _OrdonnancePageState extends State<OrdonnancePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchOrdonnances(); // Load ordonnances when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Visibility(
            visible:
                (user!.isMedcin || user!.isAdmin) && (widget.medcin != null),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // Navigate to the "Add Ordonnance" page when the plus button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddOrdonnancePage(
                          patient: widget.patient, medcin: widget.medcin!),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // width: 120,

                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          // color: CupertinoColors.systemBlue,
                          color: SihhaGreen2,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Ajouter',
                          style: SihhaFont.copyWith(
                              // color: CupertinoColors.systemBlue,
                              color: SihhaGreen2,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 5)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        leading: MyBackButton(
          onTapFunction: () {
            print("User Pressed on Back Button to go back");
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Ordonnances',
          style: SihhaPoppins3,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshOrdonnances,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        if (widget.patient.ordonnances == null ||
                            widget.patient.ordonnances!.isEmpty)
                          Center(child: Text('Aucune ordonnance trouvée'))
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.patient.ordonnances!.length,
                            itemBuilder: (context, index) {
                              final ordonnance =
                                  widget.patient.ordonnances![index];
                              // int totalOrdonnaces =
                              //     widget.patient.ordonnances!.length;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    OrdonnanceTile(ordonnance: ordonnance),
                                    SizedBox(
                                      height: 10,
                                    )
                                    // if (index <
                                    //     totalOrdonnaces -
                                    //         1) // Check if it's not the last item
                                    //   Divider(

                                    //     endIndent: 10,
                                    //     indent: 60,
                                    //     thickness: 0.4,
                                    //   )
                                    // else
                                    //   SizedBox(
                                    //       height:
                                    //           0), // Use SizedBox instead of Divider for the last item
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future<void> _refreshOrdonnances() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.patient.fetchOrdonnances();
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _fetchOrdonnances() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.patient.fetchOrdonnances();
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }
}

// Add OrdonnanceTile widget here
Widget OrdonnanceTile({required Ordonnance ordonnance}) {
  return FutureBuilder<List<String?>>(
    future: ordonnance.fetchDoctorProfilePicUrls([ordonnance.doctorIDN!]),
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
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 0.4, color: Colors.black12),
          color: (DateTime.now().isAfter(ordonnance.dateOfExpiry!.toDate()) ||
                  ordonnance.status == 'expired')
              ? Colors.grey.shade500.withOpacity(0.18)
              : SihhaGreen1.withOpacity(0.18),

          // ordonnance.status == 'expired'
          //     ? Colors.red.withOpacity(0.18)
          //     // : Colors.red.shade700.withOpacity(0.18)
          //     // : Colors.grey.shade500.withOpacity(0.18)
          //     : Color(0xFFFFD700).withOpacity(0.18)
          // // : SihhaGreen1.withOpacity(0.18),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: doctorProfilePicUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: MyProfilePicture(
                      URL: url,
                      radius: 25,
                    ),
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
                    ordonnance.doctorName!,
                    style: SihhaPoppins3.copyWith(
                        fontSize: 16, letterSpacing: 1.2),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  ordonnance.doctorSpeciality!,
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
              '${ordonnance.dateOfFilling!.toDate().day}/${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${ordonnance.dateOfFilling!.toDate().minute}',
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
