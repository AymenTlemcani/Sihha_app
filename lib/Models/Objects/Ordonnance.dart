import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';

class Ordonnance {
  final String? id;
  final String? patientIDN;
  final String? patientName;
  final String? doctorIDN;
  final String? doctorName;
  final String? doctorProfessionalPhoneNumber;
  final String? doctorDigitalSignature;

  final String? clinicName;
  final String? clinicLocation;
  final String? clinicPhoneNumber;
  final String? doctorSpeciality;
  final Timestamp? dateOfFilling;
  final Timestamp? dateOfExpiry;
  String? status;
  final List<Medicament>? medicaments; // Adjusted type here
  final List<String?>? instructions;
  final List<String?>? notes;

  Ordonnance({
    this.id,
    required this.patientIDN,
    required this.patientName,
    required this.doctorIDN,
    required this.doctorName,
    required this.clinicName,
    required this.doctorSpeciality,
    required this.dateOfFilling,
    required this.dateOfExpiry,
    this.status,
    required this.medicaments,
    this.instructions,
    this.notes,
    this.doctorProfessionalPhoneNumber,
    this.doctorDigitalSignature,
    this.clinicLocation,
    this.clinicPhoneNumber,
  });

  // factory Ordonnance.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

  //   if (data == null) {
  //     throw ArgumentError('Document data is null.');
  //   }

  //   return Ordonnance(
  //     id: doc.id,
  //     patientIDN: data['patientIDN'],
  //     doctorIDN: data['doctorIDN'],
  //     doctorName: data['doctorName'],
  //     patientName: data['patientName'],
  //     clinicName: data['clinicName'],
  //     doctorSpeciality: data['doctorSpeciality'],
  //     dateOfFilling: data['dateOfFilling'] as Timestamp?,
  //     dateOfExpiry: data['dateOfExpiry'] as Timestamp?,
  //     status: data['status'],
  //     medicaments: (data['medicaments'] as List<Medicament>?)
  //         ?.map((med) => Medicament.fromMap(med))
  //         .toList(), // Convert each map to Medicament
  //     instructions: data['instructions'] as List<String?>?,
  //     notes: data['notes'] as List<String?>?,
  //   );
  // }
  factory Ordonnance.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw ArgumentError('Document data is null.');
    }

    try {
      return Ordonnance(
        id: doc.id,
        patientIDN: data['patientIDN'],
        doctorIDN: data['doctorIDN'],
        doctorName: data['doctorName'],
        patientName: data['patientName'],
        clinicName: data['clinicName'],
        doctorSpeciality: data['doctorSpeciality'],
        dateOfFilling: data['dateOfFilling'] as Timestamp?,
        dateOfExpiry: data['dateOfExpiry'] as Timestamp?,
        status: data['status'],
        // Ensure that the cast is to List<String?>? for instructions and notes
        medicaments: (data['medicaments'] as List<dynamic>?)
            ?.map((med) => Medicament.fromMap(med as Map<String, dynamic>))
            .toList(),
        instructions: (data['instructions'] as List<dynamic>?)
            ?.map((instr) => instr as String?)
            .toList(),
        notes: (data['notes'] as List<dynamic>?)
            ?.map((note) => note as String?)
            .toList(),
        clinicLocation: data['clinicLocation'],
        clinicPhoneNumber: data['clinicPhoneNumber'],
        doctorDigitalSignature: data['doctorDigitalSignature'],
        doctorProfessionalPhoneNumber: data['doctorProfessionalPhoneNumber'],
      );
    } catch (e) {
      throw Exception('Error creating Ordonnance from Firestore data: $e');
    }
  }

  Map<String, dynamic> toFirestore() {
    return {
      'patientIDN': patientIDN,
      'doctorIDN': doctorIDN,
      'doctorName': doctorName,
      'patientName': patientName,
      'clinicName': clinicName,
      'doctorSpeciality': doctorSpeciality,
      'dateOfFilling': dateOfFilling,
      'dateOfExpiry': dateOfExpiry,
      'status': status,
      'medicaments': medicaments
          ?.map((med) => med.toMap())
          .toList(), // Convert each Medicament to map
      'instructions': instructions,
      'notes': notes,
      'doctorProfessionalPhoneNumber': doctorProfessionalPhoneNumber,
      'clinicPhoneNumber': clinicPhoneNumber,
      'clinicLocation': clinicLocation,
      'doctorDigitalSignature': doctorDigitalSignature
    };
  }

  Future<List<String?>> fetchDoctorProfilePicUrls(
      List<String> doctorIDNs) async {
    List<String?> urls = [];
    for (String doctorIDN in doctorIDNs) {
      try {
        QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('IDN', isEqualTo: doctorIDN)
            .limit(1)
            .get();

        if (doctorSnapshot.docs.isNotEmpty) {
          urls.add(doctorSnapshot.docs.first['profilePicUrl'] as String?);
        }
      } catch (e) {
        print('Error fetching doctor profile pic: $e');
      }
    }
    return urls;
  }
}
