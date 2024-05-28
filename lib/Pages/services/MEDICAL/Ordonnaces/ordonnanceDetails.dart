import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sahha_app/CommonWidgets/MyBackButton.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/services/MEDICAL/Ordonnaces/medicamentDetails.dart';
import 'package:sahha_app/Services/UserService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class OrdonnanceDetails extends StatelessWidget {
  final Ordonnance ordonnance;
  final Patient patient;
  final UserService userService = UserService();
  final Medcin? medcin;

  OrdonnanceDetails(
      {Key? key, required this.ordonnance, required this.patient, this.medcin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            print('${(ordonnance.notes!.length)}');
          },
        ),
      ),
      appBar: AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () async {
                final pdfFile = await generatePdf();
                openPdfFile(pdfFile);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.815),
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
                  Divider(thickness: 0.3),
                  Title(),
                  SizedBox(height: 5),
                  DateFillingExpiring(),
                  SizedBox(height: 5),
                  NameAndAge(),
                  Container(height: 30),
                  Container(
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
                          SizedBox(height: 70)
                        ],
                      ),
                    ),
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
              'Dr.${medcin!.familyName} ${medcin!.name}',
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

  Future<File> generatePdf() async {
    final pdf = pw.Document();

    // // Define fonts
    final ttf = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final font = pw.Font.ttf(ttf);
    final ttfBold = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    final fontBold = pw.Font.ttf(ttfBold);
    final ttfSignature =
        await rootBundle.load("assets/fonts/Caveat-SemiBold.ttf");
    final fontSignature = pw.Font.ttf(ttfSignature);
    /********************** */
    // final font = pw.Font.ttf(await GoogleFonts.getFont('Poppins-Regular'));
    // final fontBold = pw.Font.ttf(await GoogleFonts.getFont('Poppins-Bold'));
    /********************************* */

    // Load images asynchronously
    final ByteData imageData = await rootBundle.load("assets/back3.png");
    final Uint8List imageBytes = imageData.buffer.asUint8List();

    final ByteData svgData = await rootBundle.load("assets/svg-cropped.svg");
    final Uint8List svgBytes = svgData.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Top bar
                pw.Container(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(8),
                    image: pw.DecorationImage(
                      image: pw.MemoryImage(imageBytes),
                      fit: pw.BoxFit.fill,
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Dr.${medcin!.familyName} ${medcin!.name}',
                              style:
                                  pw.TextStyle(font: fontBold, fontSize: 16)),
                          pw.Text('${medcin!.speciality}',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 14,
                                  color: PdfColors.black)),
                          pw.Text('${medcin!.professionalPhoneNumber}',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 14,
                                  color: PdfColors.black)),
                        ],
                      ),
                      // pw.Container(
                      //   height: 50,
                      //   child: pw.Image(
                      //     pw.MemoryImage(svgBytes),
                      //   ),
                      // ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('${medcin!.workPlace!.name}',
                              style:
                                  pw.TextStyle(font: fontBold, fontSize: 16)),
                          pw.Text('${medcin!.workPlace!.address}',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 14,
                                  color: PdfColors.black)),
                          pw.Text('${medcin!.workPlace!.phone}',
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: 14,
                                  color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Divider(thickness: 0.3),
                // Title
                pw.Center(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4.0),
                    child: pw.Text('Ordonnance Médicale',
                        style: pw.TextStyle(font: fontBold, fontSize: 18)),
                  ),
                ),
                pw.SizedBox(height: 5),
                // Date filling and expiring
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Fait le : ',
                        style: pw.TextStyle(font: font, fontSize: 14)),
                    pw.Text(
                      '${ordonnance.dateOfFilling!.toDate().day} / ${(ordonnance.dateOfFilling!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfFilling!.toDate().month} / ${ordonnance.dateOfFilling!.toDate().year}    ',
                      style: pw.TextStyle(font: fontBold, fontSize: 14),
                    ),
                    pw.Text('Expire le : ',
                        style: pw.TextStyle(font: font, fontSize: 14)),
                    pw.Text(
                      '${ordonnance.dateOfExpiry!.toDate().day} / ${(ordonnance.dateOfExpiry!.toDate().month) < 10 ? '0' : ''}${ordonnance.dateOfExpiry!.toDate().month} / ${ordonnance.dateOfExpiry!.toDate().year} .',
                      style: pw.TextStyle(font: fontBold, fontSize: 14),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                // Name and Age
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Pour  : ',
                        style: pw.TextStyle(font: font, fontSize: 14)),
                    pw.Text('${patient.familyName} ${patient.name}  ',
                        style: pw.TextStyle(font: fontBold, fontSize: 14)),
                    pw.Text('Âgé : ',
                        style: pw.TextStyle(font: font, fontSize: 14)),
                    pw.Text(
                        '${(ordonnance.dateOfFilling!.toDate().year - (patient.birthDate!.toDate().year))}',
                        style: pw.TextStyle(font: fontBold, fontSize: 14)),
                    pw.Text(' ans',
                        style: pw.TextStyle(font: font, fontSize: 14)),
                  ],
                ),
                pw.SizedBox(height: 30),
                // Medications
                pw.Container(
                  child: ordonnance.medicaments != null
                      ? pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: ordonnance.medicaments!
                              .asMap()
                              .entries
                              .map((entry) {
                            final medicament = entry.value;
                            final index = entry.key;
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Medicament ${index + 1}',
                                    style: pw.TextStyle(
                                        font: fontBold, fontSize: 14)),
                                pw.Text('Nom: ${medicament.name}',
                                    style:
                                        pw.TextStyle(font: font, fontSize: 14)),
                                pw.Text('Dosage: ${medicament.dosage}',
                                    style:
                                        pw.TextStyle(font: font, fontSize: 14)),
                                pw.Text(
                                    'Fréquence: ${medicament.frequencyPerDay}',
                                    style:
                                        pw.TextStyle(font: font, fontSize: 14)),
                                pw.SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        )
                      : pw.Center(
                          child: pw.Text('No medications prescribed.',
                              style: pw.TextStyle(font: font, fontSize: 14)),
                        ),
                ),
                // Instructions
                if (ordonnance.instructions != null &&
                    ordonnance.instructions!.isNotEmpty)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 16),
                      pw.Text('Instructions:',
                          style: pw.TextStyle(font: fontBold, fontSize: 16)),
                      ...ordonnance.instructions!.asMap().entries.map((entry) {
                        final instruction = entry.value;
                        final index = entry.key;
                        return pw.Padding(
                          padding: pw.EdgeInsets.all(5.0),
                          child: pw.RichText(
                            text: pw.TextSpan(
                              text: '${index + 1}. ',
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 14,
                                  color: PdfColors.black),
                              children: [
                                pw.TextSpan(
                                  text: instruction ?? '',
                                  style: pw.TextStyle(
                                      font: font,
                                      fontSize: 14,
                                      color: PdfColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                // Notes
                if (ordonnance.notes != null && ordonnance.notes!.isNotEmpty)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 16),
                      pw.Text('Remarques:',
                          style: pw.TextStyle(font: fontBold, fontSize: 16)),
                      ...ordonnance.notes!.asMap().entries.map((entry) {
                        final note = entry.value;
                        final index = entry.key;
                        return pw.Padding(
                          padding: pw.EdgeInsets.all(5.0),
                          child: pw.RichText(
                            text: pw.TextSpan(
                              text: '${index + 1}. ',
                              style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 14,
                                  color: PdfColors.black),
                              children: [
                                pw.TextSpan(
                                  text: note ?? '',
                                  style: pw.TextStyle(
                                      font: font,
                                      fontSize: 14,
                                      color: PdfColors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      pw.SizedBox(height: 70),
                    ],
                  ),
                // Signature
                pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(vertical: 20, horizontal: 50.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Signature :      ',
                          style:
                              pw.TextStyle(font: font, color: PdfColors.black)),
                      pw.Text(
                        '${ordonnance.medcin![0].familyName} ${ordonnance.medcin![0].name}',
                        style: pw.TextStyle(
                            font: fontSignature,
                            fontSize: 16,
                            color: PdfColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/ordonnance.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> openPdfFile(File file) async {
    await OpenFile.open(file.path);
  }
}
