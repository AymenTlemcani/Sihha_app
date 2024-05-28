import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyProfilePicture2.dart';
import 'package:sahha_app/Models/Actors/Child.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/ChildPage.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage();

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  Future<void> _refreshMembres() async {
    try {
      await globalUser!
          .fetchFamilyMembers(); // Ensure fetchFamilyMembers is implemented in Patient class
      setState(() {});
    } catch (e) {
      print('Error fetching family members: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          doctorProfilePicUrls =
              await ord.fetchDoctorProfilePicUrls(doctorIDNS);
          // doctorProfilePicUrls
          await membre.fetchDiseases();
          await membre.fetchAllergies();
          await membre.fetchDisabilities();
          await membre.fetchHeights();
          await membre.fetchWeights();
          await membre.fetchBloodTypes();
          await membre.fetchHabits();
          // await membre.fetchFamilyMembers();
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
                    style: SihhaPoppins3.copyWith(
                        fontSize: 18, letterSpacing: 1.2),
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

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Famille',
            style: SihhaPoppins2,
          ),
        ),
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () async {
                await _refreshMembres();
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  CupertinoIcons.refresh_bold,
                  color: SihhaGreen2,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator.adaptive(
        color: SihhaGreen1,
        strokeWidth: 4,
        onRefresh: _refreshMembres,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (globalUser!.familyMembers == null ||
                      globalUser!.familyMembers!.isEmpty)
                    NoDataContainer()
                  else
                    SizedBox(height: 10),
                  ...(globalUser!.familyMembers!)
                      .map((membre) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                MembreTile(
                                  patient: globalUser!,
                                  membre: membre,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ))
                      .toList(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                style: SihhaPoppins3.copyWith(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
