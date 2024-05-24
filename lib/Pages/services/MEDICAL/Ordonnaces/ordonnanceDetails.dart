import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/medicamentDetails.dart';
import 'package:sahha_app/Services/UserService.dart';

class OrdonnanceDetails extends StatelessWidget {
  final Ordonnance ordonnance;
  final Patient patient;
  final UserService userService = UserService(); // Declare userService here
  final Medcin? medcin; // Declare Medcin instance variable

  OrdonnanceDetails(
      {Key? key, required this.ordonnance, required this.patient, this.medcin})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            // print('date : ${(ordonnance.dateOfFilling!.toDate())}');
            print('${(ordonnance.notes!.length)}');
          },
        ),
      ),
      appBar: AppBar(
        //TODO Add Extract as PDF button to print it
        leading: MyBackButton(
          onTapFunction: () {
            print("User Pressed on Back Button to go back");
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Odonnance  ${ordonnance.dateOfFilling!.toDate().day} /${ordonnance.dateOfFilling!.toDate().month}',
          style: SihhaPoppins3,
        ),
        surfaceTintColor: Colors.white,
        elevation: 0.5,

        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height *
                    0.815), // Set the minimum height to 80% of the screen height

            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 10,
                  )
                ],
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrdonnanceTopBar(),
                  Divider(
                    thickness: 0.3,
                  ),
                  Title(),
                  SizedBox(height: 5),
                  DateFillingExpiring(),
                  SizedBox(height: 5),
                  NameAndAge(),
                  Container(
                    // color: Colors.amber.withOpacity(0.2),
                    height: 30,
                  ),
                  Container(
                    // color: Colors.teal.withOpacity(0.2),
                    child: ordonnance.medicaments != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: ordonnance.medicaments!
                                  .asMap()
                                  .entries
                                  .map((entry) => MedicamentDetails(
                                        medicament: entry.value,
                                        index: entry.key,
                                      ))
                                  .toList(),
                            ),
                          )
                        : Center(
                            child: Text(
                              'No medications prescribed.',
                              style: SihhaFont,
                            ),
                          ),
                  ),
                  if (ordonnance.instructions != null &&
                      ordonnance.instructions!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Instructions:',
                            style: SihhaFont.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          ...ordonnance.instructions!
                              .asMap()
                              .entries
                              .map((entry) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: '${entry.key + 1}. ',
                                        style: SihhaFont.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                            fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: entry.value ?? '',
                                            style: SihhaFont.copyWith(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  if (ordonnance.notes != null && ordonnance.notes!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Remarques:',
                            style: SihhaFont.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          ...ordonnance.notes!
                              .asMap()
                              .entries
                              .map((entry) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: '${entry.key + 1}. ',
                                        style: SihhaFont.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                            fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: entry.value ?? '',
                                            style: SihhaFont.copyWith(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),

                          //TODO we can add a qr code for the prescreption and we can check if its valid or not

                          SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Signature :      ',
                            style: SihhaFont.copyWith(color: Colors.black54)),
                        Text(
                          '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
                          style: GoogleFonts.caveat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row Title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Ordonnance Médicale', style: SihhaPoppins3),
        )
      ],
    );
  }

  Row DateFillingExpiring() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Fait le : ',
          style: SihhaFont.copyWith(),
        ),
        Text(
          '${ordonnance.dateOfFilling!.toDate().day} / ${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month} / ${ordonnance.dateOfFilling!.toDate().year}    ',
          style: SihhaFont.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Expire le : ',
          style: SihhaFont.copyWith(),
        ),
        Text(
          '${ordonnance.dateOfExpiry!.toDate().day} / ${(ordonnance.dateOfExpiry!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfExpiry!.toDate().month} / ${ordonnance.dateOfExpiry!.toDate().year} .',
          style: SihhaFont.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Row NameAndAge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pour  : ',
          style: SihhaFont.copyWith(),
        ),
        Text(
          '${patient.familyName} ${patient.name}  ',
          style: SihhaFont.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Âgé : ',
          style: SihhaFont.copyWith(),
        ),
        Text(
          '${(ordonnance.dateOfFilling!.toDate().year - (patient.birthDate!.toDate().year))}',
          style: SihhaFont.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          ' ans',
          style: SihhaFont.copyWith(),
        ),
      ],
    );
  }

  Widget OrdonnanceTopBar() {
    return IntrinsicHeight(
      child: Container(
        // height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/back3.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DoctorDetails(),
              Logo(),
              ClinicDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ClinicDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
            child: Text(
              // '${ordonnance.clinicName!.split(' ')[0]}',
              '${medcin!.workPlace!.name}',
              style: SihhaPoppins3.copyWith(fontSize: 16, letterSpacing: 1.2),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              '${medcin!.workPlace!.address}',
              style: SihhaFont.copyWith(
                  fontSize: 14, letterSpacing: 1, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              '${medcin!.workPlace!.phone}',
              style: SihhaFont.copyWith(
                  fontSize: 14, letterSpacing: 1, color: Colors.black54),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget DoctorDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              // 'Dr.${ordonnance.doctorName!.split(' ')[0]} ${ordonnance.doctorName!.split(' ')[1].substring(0, 1).toUpperCase()}',
              'Dr.${medcin!.familyName} ${medcin!.name}',
              // 'Dr. Tlemcani Aymen Salaheddine',
              style: SihhaPoppins3.copyWith(fontSize: 16, letterSpacing: 1.2),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              '${medcin!.speciality}',
              style: SihhaFont.copyWith(
                  fontSize: 14, letterSpacing: 1, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Text(
              '${medcin!.professionalPhoneNumber}',
              style: SihhaFont.copyWith(
                  fontSize: 14, letterSpacing: 1, color: Colors.black54),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget Logo() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          SvgPicture.asset(
            "assets/svg-cropped.svg",
            height: 50,
          ),
          Spacer()
        ],
      ),
    );
  }
}
