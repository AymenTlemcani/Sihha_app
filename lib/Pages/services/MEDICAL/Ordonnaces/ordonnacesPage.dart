import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnanceDetails.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/addOrdonnace.dart';

class OrdonnancePage extends StatefulWidget {
  const OrdonnancePage({Key? key, this.medcin, required this.patient})
      : super(key: key);
  final Medcin?
      medcin; // null if patient is viewing own ordonnances (not required)
  final Patient patient;

  @override
  State<OrdonnancePage> createState() => _OrdonnancePageState();
}

class _OrdonnancePageState extends State<OrdonnancePage> {
  // final OrdonnancesService _ordonnancesService = OrdonnancesService();
  // bool _isLoading = true;
  // List<Ordonnance> _patientOrdonnances = [];
  //
  @override
  void initState() {
    _fetchOrdonnances();
    super.initState();
  }

  Future<void> _refreshOrdonnances() async {
    try {
      await widget.patient.fetchOrdonnances();
      setState(() {});
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
  }

  void _fetchOrdonnances() async {
    try {
      await widget.patient.fetchOrdonnances();
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
  }

  //
  // Future<void> _fetchOrdonnances() async {
  //   // setState(() {
  //   //   _isLoading =
  //   //       true; // Set loading state to true before fetching ordonnances
  //   // });

  //   try {
  //     // Call the fetchAndProcessOrdonnances method to fetch and process ordonnances
  //     await _ordonnancesService
  //         .fetchAndProcessOrdonnances(widget.patient.documentId!);

  //     print('done fetching');

  //     // After fetching and processing, update local state with the fetched ordonnances
  //     // setState(() {
  //     // Assign fetched ordonnances to _patientOrdonnances
  //     _patientOrdonnances = _ordonnancesService.ordonnances ?? [];
  //     // });
  //   } catch (e) {
  //     print('Error fetching ordonnances: $e');
  //   } finally {
  //     // setState(() {
  //     //   _isLoading =
  //     //       false; // Set loading state to false after fetching ordonnances (whether successful or not)
  //     // });
  //   }
  // }

  // Future<void> _refreshOrdonnances() async {
  //   // setState(() {
  //   //   // _isLoading = true;
  //   // });
  //   await _fetchOrdonnances();
  // }

  //
  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginControllerProvider>(context);
    // User? user = loginProvider.user;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(widget.patient.ordonnances);
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<Function>(
                color: Colors.white,
                offset: Offset(-10, 40),
                icon: Icon(CupertinoIcons.ellipsis_vertical),
                iconColor: Colors.black87,
                elevation: 2,
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Function>>[
                  PopupMenuItem<Function>(
                    value: _refreshOrdonnances,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Icon(CupertinoIcons.refresh_bold,
                              color: Colors.black87),
                          SizedBox(width: 10),
                          Text(
                            'Actualiser',
                            style: SihhaFont.copyWith(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if ((globalUser!.isMedcin) && (widget.medcin != null))
                    PopupMenuItem<Function>(
                      value: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOrdonnancePage(
                                patient: widget.patient,
                                medcin: widget.medcin!),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Icon(CupertinoIcons.add, color: SihhaGreen2),
                            SizedBox(width: 10),
                            Text(
                              'Ajouter',
                              style: SihhaFont.copyWith(
                                  color: SihhaGreen2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                onSelected: (Function value) {
                  value();
                },
              ),
            ),
          ],
          leading: MyBackButton(
            onTapFunction: () {
              print("User Pressed on Back Button to go back");
              Navigator.pop(context);
            },
          ),
          title: Text('Ordonnances', style: SihhaPoppins3),
          surfaceTintColor: Colors.white,
          elevation: 0.5,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          shadowColor: Colors.black54,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        body:
            // _isLoading
            //     ? Center(child: CircularProgressIndicator())
            //     :
            RefreshIndicator.adaptive(
          color: SihhaGreen1,
          strokeWidth: 4,
          onRefresh: _refreshOrdonnances,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.patient.ordonnances == null ||
                        widget.patient.ordonnances!.isEmpty)
                      NoDataContainer()
                    else
                      SizedBox(height: 10),
                    //TODO Learn about ... operators
                    ...(widget.patient.ordonnances!)
                        .map((ordonnance) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  OrdonnanceTile(
                                    patient: widget.patient,
                                    ordonnance: ordonnance,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ))
                        .toList(),
                    SizedBox(height: 10),
                    //************************************************************************* */
                    // ********************  List View Vesion It has errors with shrink wrap if true = not scrollable if no excpetion error ************************************
                    // CustomScrollView(
                    //     slivers: [
                    //       SliverToBoxAdapter(
                    //         child: Column(
                    //           children: [
                    //             if (widget.patient.ordonnances == null ||
                    //                 widget.patient.ordonnances!.isEmpty)
                    //               Center(child: Text('Aucune ordonnance trouvée'))
                    //             else
                    //               ListView.builder(
                    //                 // shrinkWrap: true,
                    //                 itemCount: widget.patient.ordonnances!.length,
                    //                 itemBuilder: (context, index) {
                    //                   List<Ordonnance> displayedOrdonnances = [];
                    //                   // Sort ordonnances by date of filling in descending order
                    //                   widget.patient.ordonnances!.sort((a, b) =>
                    //                       b.dateOfFilling!.compareTo(a.dateOfFilling!));
                    //                   displayedOrdonnances = widget.patient.ordonnances!;
                    //                   final ordonnance = displayedOrdonnances[index];
                    //                   // widget.patient.ordonnances![index];
                    //                   // int totalOrdonnaces =
                    //                   //     widget.patient.ordonnances!.length;
                    //                   return Padding(
                    //                     padding:
                    //                         const EdgeInsets.symmetric(horizontal: 8.0),
                    //                     child: Column(
                    //                       children: [
                    //                         OrdonnanceTile(
                    //                             ordonnance: ordonnance,
                    //                             patient: widget.patient),
                    //                         SizedBox(
                    //                           height: 10,
                    //                         )
                    //                         // if (index <
                    //                         //     totalOrdonnaces -
                    //                         //         1) // Check if it's not the last item
                    //                         //   Divider(

                    //                         //     endIndent: 10,
                    //                         //     indent: 60,
                    //                         //     thickness: 0.4,
                    //                         //   )
                    //                         // else
                    //                         //   SizedBox(
                    //                         //       height:
                    //                         //           0), // Use SizedBox instead of Divider for the last item
                    //                       ],
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget OrdonnanceTile(
    {required Ordonnance ordonnance, required Patient patient}) {
  return FutureBuilder<List<String?>>(
    future: ordonnance.fetchDoctorProfilePicUrls([ordonnance.medcin![0].IDN!]),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(height: 70);
        // CircularProgressIndicator(color: Colors.white,);
      }
      if (snapshot.hasError) {
        return Text('Error fetching profile picture');
      }
      List<String?> doctorProfilePicUrls = snapshot.data ?? [];
      return InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdonnanceDetails(
                ordonnance: ordonnance,
                patient: patient,
                medcin: ordonnance.medcin![0],
              ),
            ),
          );
        },
        child: Container(
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
                      child: MyProfilePicture2(
                        URL: url,
                        frameRadius: 23,
                        pictureRadius: 21,
                        borderColor: ordonnance.status == 'active'
                            ? SihhaGreen2
                            : Colors.grey,
                        grayscale: ordonnance.status == 'active' ? false : true,
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
                      '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
                      style: SihhaPoppins3.copyWith(
                          fontSize: 18, letterSpacing: 1.2),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${ordonnance.medcin![0].speciality}',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 1.1,
                    ),
                  ),
                  // Spacer(),
                  // Text(
                  //   ordonnance.status!,
                  //   style: GoogleFonts.poppins(
                  //     color: Colors.grey,
                  //     fontWeight: FontWeight.w400,
                  //     fontSize: 14,
                  //     letterSpacing: 1.1,
                  //   ),
                  // ),
                  // SizedBox(height: 10)
                ],
              ),
              Spacer(),
              Text(
                '${ordonnance.dateOfFilling!.toDate().day}/${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${(ordonnance.dateOfFilling!.toDate().minute) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().minute}',
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
        ),
      );
    },
  );
}

// // Add OrdonnanceTile widget here
// Widget OrdonnanceTile(
//     {required Ordonnance ordonnance, required Patient patient}) {
//   final userService = UserService();
//   return FutureBuilder<String?>(
//     future: userService.getProfilePicUrl(ordonnance.medcinId!),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Container(
//           height: 70,
//           child: CircularProgressIndicator(
//             color: SihhaGreen1,
//             strokeWidth: 3,
//           ),
//         );
//       }
//       if (snapshot.hasError) {
//         return Text('Error fetching medcin data');
//       }
//       String? Url = snapshot.data;
//       // Medcin? medcin = snapshot.data;
//       return InkWell(
//         borderRadius: BorderRadius.circular(30),
//         splashColor: Colors.transparent,
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OrdonnanceDetails(
//                 ordonnance: ordonnance,
//                 patient: patient,
//                 medcin: ordonnance.medcin![0],
//               ),
//             ),
//           );
//         },
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(width: 0.4, color: Colors.black12),
//             color: (DateTime.now().isAfter(ordonnance.dateOfExpiry!.toDate()) ||
//                     ordonnance.status == 'expired')
//                 ? Colors.grey.shade500.withOpacity(0.18)
//                 : SihhaGreen1.withOpacity(0.18),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: MyProfilePicture2(
//                   URL: Url ?? null,
//                   frameRadius: 27,
//                   pictureRadius: 24,
//                   borderColor:
//                       ordonnance.status == 'active' ? SihhaGreen2 : Colors.grey,
//                   grayscale: ordonnance.status == 'active' ? false : true,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
//                       style: SihhaPoppins3.copyWith(
//                         fontSize: 18,
//                         letterSpacing: 1.2,
//                         color: ordonnance.status == 'active'
//                             ? Colors.black87
//                             : Colors.grey.shade500,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     ordonnance.medcin![0].speciality ?? 'N/A',
//                     style: GoogleFonts.poppins(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                       letterSpacing: 1.1,
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Text(
//                 '${ordonnance.dateOfFilling!.toDate().day}/${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${(ordonnance.dateOfFilling!.toDate().minute) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().minute}',
//                 style: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   letterSpacing: 1.3,
//                 ),
//               ),
//               SizedBox(width: 10),
//             ],
//           ),
//         ),
//       );
//     },
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
                style: SihhaPoppins3.copyWith(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
