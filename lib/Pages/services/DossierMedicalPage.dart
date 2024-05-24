import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/CommonWidgets/MyDetailCard.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disease.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/ordonnanceDetails.dart';

class DossierMedicalPage extends StatefulWidget {
  const DossierMedicalPage({super.key});

  @override
  State<DossierMedicalPage> createState() => _DossierMedicalPageState();
}

class _DossierMedicalPageState extends State<DossierMedicalPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Simulate a loading state for demonstration
    _isLoading = true;
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: MyBackButton(
          onTapFunction: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dossier Medical',
          style: SihhaPoppins3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  CupertinoIcons.share,
                  color: SihhaGreen2,
                  size: 27,
                ),
              ),
            ),
          )
        ],
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: SihhaGreen1,
              strokeWidth: 4,
            ))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: Row(
                          children: [
                            Expanded(
                              child: MyDetailCard(
                                  title: 'Taille',
                                  leadingIcon: LineAwesomeIcons.ruler,
                                  lastUpdated: '18 Apr',
                                  data: '188',
                                  unity: 'cm'),
                            ),
                            Expanded(
                              child: MyDetailCard(
                                title: 'Rh',
                                leadingIcon: LineAwesomeIcons.tint,
                                lastUpdated: '',
                                data: 'O+',
                                unity: '',
                              ),
                            ),
                            Expanded(
                              child: MyDetailCard(
                                  title: 'Poids',
                                  leadingIcon: LineAwesomeIcons.hanging_weight,
                                  lastUpdated: '20 jun',
                                  data: '65',
                                  unity: 'kg'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        // height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Les Maladies',
                                style: SihhaFont.copyWith(
                                  fontSize: 28,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Spacer(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    print(
                                        'user tapped Voir tout on Les Maladies');
                                  },
                                  child: Text(
                                    'Voir tout',
                                    style: SihhaFont.copyWith(
                                      fontSize: 15,
                                      color: SihhaGreen2,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.2,
                                      decorationColor: SihhaGreen2,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: MyDetailCard(
                                    title: 'Taille',
                                    leadingIcon: LineAwesomeIcons.ruler,
                                    lastUpdated: '18 Apr',
                                    data: '188',
                                    unity: 'cm'),
                              ),
                            ),
                            Expanded(
                              child: MyDetailCard(
                                  title: 'Poids',
                                  leadingIcon: LineAwesomeIcons.hanging_weight,
                                  lastUpdated: '20 jun',
                                  data: '65',
                                  unity: 'kg'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                  'Aucune DATA trouvée.',
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

  Widget MaladiesListView() {
    if (globalUser == null ||
        globalUser!.diseases == null ||
        globalUser!.diseases!.isEmpty) {
      return NoDataContainer();
    }

    // Sort ordonnances by date of creation in descending order
    globalUser!.diseases!
        .sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

    // Take the last 5 ordonnances
    List<Disease?> displayedDiseases = globalUser!.diseases!.take(5).toList();

    int totalDiseases = displayedDiseases.length;
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
              children: displayedDiseases.asMap().entries.map((entry) {
                int index = entry.key;
                Disease disease = entry.value!;
                return Column(
                  children: [
                    // diseaseTile(disease: disease),
                    if (index <
                        totalDiseases - 1) // Check if it's not the last item
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

// Widget diseaseTile({required Disease disease}) {
//     return FutureBuilder<List<String?>>(
//       future:
//           ordonnance.fetchDoctorProfilePicUrls([ordonnance.medcin![0].IDN!]),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Container(height: 70);
//         }
//         if (snapshot.hasError) {
//           return Text('Error fetching profile picture');
//         }
//         List<String?> doctorProfilePicUrls = snapshot.data ?? [];
//         return InkWell(
//           borderRadius: BorderRadius.circular(30),
//           splashColor: Colors.transparent,
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OrdonnanceDetails(
//                   ordonnance: ordonnance,
//                   patient: globalUser!,
//                   medcin: ordonnance.medcin![0],
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             height: 70,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     children: doctorProfilePicUrls.map((url) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: MyProfilePicture2(
//                           URL: url,
//                           frameRadius: 23,
//                           pictureRadius: 21,
//                           borderColor: ordonnance.status == 'active'
//                               ? SihhaGreen2
//                               : Colors.grey,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0),
//                       child: Text(
//                         '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
//                         style: SihhaPoppins3.copyWith(
//                           fontSize: 16,
//                           letterSpacing: 1.2,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       '${ordonnance.medcin![0].speciality}',
//                       overflow: TextOverflow.ellipsis,
//                       style: GoogleFonts.poppins(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         letterSpacing: 1.3,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 Text(
//                   '${ordonnance.dateOfFilling!.toDate().day}/${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${(ordonnance.dateOfFilling!.toDate().minute) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().minute}',
//                   style: GoogleFonts.poppins(
//                     color: Colors.grey,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     letterSpacing: 1.3,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(width: 10),
//               ],
//             ),
//           ),
//         );
//       },
//     );
  // }
  Widget OrdonnancesListView() {
    if (globalUser == null ||
        globalUser!.ordonnances == null ||
        globalUser!.ordonnances!.isEmpty) {
      return NoDataContainer();
    }

    // Sort ordonnances by date of creation in descending order
    globalUser!.ordonnances!
        .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

    // Take the last 5 ordonnances
    List<Ordonnance?> displayedOrdonnances =
        globalUser!.ordonnances!.take(5).toList();

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
                Ordonnance ordonnance = entry.value!;
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
      future:
          ordonnance.fetchDoctorProfilePicUrls([ordonnance.medcin![0].IDN!]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height: 70);
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
                  patient: globalUser!,
                  medcin: ordonnance.medcin![0],
                ),
              ),
            );
          },
          child: Container(
            height: 70,
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
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${ordonnance.medcin![0].speciality}',
                      overflow: TextOverflow.ellipsis,
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
                  '${ordonnance.dateOfFilling!.toDate().day}/${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month}/${ordonnance.dateOfFilling!.toDate().year}\n     ${ordonnance.dateOfFilling!.toDate().hour}:${(ordonnance.dateOfFilling!.toDate().minute) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().minute}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 1.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
