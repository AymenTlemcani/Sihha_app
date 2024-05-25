import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';

class Disease {
  String? id;
  String? patientId;
  String? name;
  Timestamp? dateOfStart;
  Timestamp? dateOfEnd;
  String? description;
  List<String>? symptoms;
  List<String>? treatments;
  String? type;
  String? status;
  String? level;
  Patient? patient;
  List<User>? medcins;

  Disease({
    this.id,
    this.patient,
    this.patientId,
    this.medcins,
    this.name,
    this.description,
    this.symptoms,
    this.dateOfStart,
    this.dateOfEnd,
    this.treatments,
    this.type,
    this.status,
    this.level,
  });

  factory Disease.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map is null. Cannot create Disease object.');
    }
    return Disease(
      id: map['id'],
      // patient: map['patient'] != null ? Patient.fromMap(map['patient']) : null,
      // medcins: map['medcins'] != null
      //     ? List<User>.from(map['medcins'].map((x) {
      //         if (x is Map<String, dynamic>) {
      //           return User.fromMap(x);
      //         } else {
      //           throw ArgumentError(
      //               'Invalid medic data. Expected Map<String, dynamic>.');
      //         }
      //       }))
      //     : null,
      name: map['name'],
      patientId: map['patientId'],
      dateOfStart: map['dateOfStart'],
      dateOfEnd: map['dateOfEnd'],
      description: map['description'],
      symptoms: List<String>.from(map['symptoms'] ?? []),
      treatments: List<String>.from(map['treatments'] ?? []),
      type: map['type'],
      status: map['status'],
      level: map['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient?.toMap(),
      'patientId': patientId,
      'medcins': medcins?.map((x) => x.toMap()).toList(),
      'name': name,
      'dateOfStart': dateOfStart,
      'dateOfEnd': dateOfEnd,
      'description': description,
      'symptoms': symptoms,
      'treatments': treatments,
      'type': type,
      'status': status,
      'level': level,
    };
  }
}
