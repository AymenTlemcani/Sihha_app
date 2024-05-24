import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class Allergie {
  Patient? patient;
  String? id;
  List<Medcin>? medcin;
  String? name;
  Timestamp? dateOfStart;
  Timestamp? dateOfEnd;
  String? description;
  List<String>? symptoms;
  List<String>? treatments;
  String? type;
  String? status;
  List<String>? reactions;
  String? patientId; // New property
  List<String>? medcinIds; // New property

  Allergie({
    this.patient,
    this.id,
    this.medcin,
    this.name,
    this.dateOfStart,
    this.dateOfEnd,
    this.description,
    this.symptoms,
    this.treatments,
    this.type,
    this.status,
    this.reactions,
    this.patientId,
    this.medcinIds,
  });

  factory Allergie.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map is null. Cannot create Allergie object.');
    }
    return Allergie(
      // patient: map['patient'] != null ? Patient.fromMap(map['patient']) : null,
      id: map['id'],
      medcin: map['medcin'] != null
          ? List<Medcin>.from(map['medcin'].map((x) {
              if (x is Map<String, dynamic>) {
                return Medcin.fromMap(x);
              } else {
                throw ArgumentError(
                    'Invalid medic data. Expected Map<String, dynamic>.');
              }
            }))
          : null,
      name: map['name'],
      dateOfStart: map['dateOfStart'],
      dateOfEnd: map['dateOfEnd'],
      description: map['description'],
      symptoms: List<String>.from(map['symptoms'] ?? []),
      treatments: List<String>.from(map['treatments'] ?? []),
      type: map['type'],
      status: map['status'],
      reactions: List<String>.from(map['reactions'] ?? []),
      patientId: map['patientId'], // New property
      medcinIds: List<String>.from(map['medcinIds'] ?? []), // New property
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patient': patient?.toMap(),
      'id': id,
      'medcin': medcin?.map((x) => x.toMap()).toList(),
      'name': name,
      'dateOfStart': dateOfStart,
      'dateOfEnd': dateOfEnd,
      'description': description,
      'symptoms': symptoms,
      'treatments': treatments,
      'type': type,
      'status': status,
      'reactions': reactions,
      'patientId': patientId, // New property
      'medcinIds': medcinIds, // New property
    };
  }
}
