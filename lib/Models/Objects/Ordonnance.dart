import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';

class Ordonnance {
  String? id;
  Patient? patient;
  List<Medcin>? medcin;
  String? patientId;
  String? medcinId;
  Timestamp? dateOfFilling;
  Timestamp? dateOfExpiry;
  String? status;
  List<Medicament>? medicaments;
  List<String?>? instructions;
  List<String?>? notes;

  Ordonnance({
    this.id,
    this.patient,
    this.medcin,
    this.patientId,
    this.medcinId,
    this.dateOfFilling,
    this.dateOfExpiry,
    this.status,
    this.medicaments,
    this.instructions,
    this.notes,
  });

  factory Ordonnance.fromMap(Map<String, dynamic> map) {
    try {
      return Ordonnance(
        id: map['id'],
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        medcin: map['medcin'] != null
            ? List<Medcin>.from(map['medcin'].map((x) => Medcin.fromMap(x)))
            : [],
        patientId: map['patientId'],
        medcinId: map['medcinId'],
        dateOfFilling: map['dateOfFilling'],
        dateOfExpiry: map['dateOfExpiry'],
        status: map['status'],
        medicaments: map['medicaments'] != null
            ? List<Medicament>.from(
                map['medicaments'].map((x) => Medicament.fromMap(x)))
            : [],
        instructions: map['instructions'] != null
            ? List<String?>.from(map['instructions'])
            : [],
        notes: map['notes'] != null ? List<String?>.from(map['notes']) : [],
      );
    } catch (e) {
      print('Error creating Ordonnance from map: $e');
      return Ordonnance();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient?.toMap(),
      'medcin': medcin?.map((x) => x.toMap()).toList(),
      'patientId': patientId,
      'medcinId': medcinId,
      'dateOfFilling': dateOfFilling,
      'dateOfExpiry': dateOfExpiry,
      'status': status,
      'medicaments': medicaments?.map((x) => x.toMap()).toList(),
      'instructions': instructions,
      'notes': notes,
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
        print('done fetc pro pic');
      } catch (e) {
        print('Error fetching doctor profile pic: $e');
      }
    }
    return urls;
  }
}
