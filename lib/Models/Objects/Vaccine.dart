import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class Vaccine {
  String? id;
  String? name;
  String? manufacturer;
  Timestamp? dateOfAdministration;
  List<String>? sideEffects;
  Patient? patient;
  List<Medcin>? administrators;
  String? patientId; // New property
  List<String>? medcinIds; // New property

  Vaccine({
    this.id,
    this.name,
    this.manufacturer,
    this.dateOfAdministration,
    this.sideEffects,
    this.patient,
    this.administrators,
    this.patientId,
    this.medcinIds,
  });

  void updateId(String newId) {
    this.id = newId;
  }

  void updateName(String newName) {
    this.name = newName;
  }

  void updateManufacturer(String newManufacturer) {
    this.manufacturer = newManufacturer;
  }

  void updateDateOfAdministration(Timestamp newDateOfAdministration) {
    this.dateOfAdministration = newDateOfAdministration;
  }

  void updateSideEffects(List<String> newSideEffects) {
    this.sideEffects = newSideEffects;
  }

  void updatePatient(Patient newPatient) {
    this.patient = newPatient;
  }

  void updateAdministrators(List<Medcin> newAdministrators) {
    this.administrators = newAdministrators;
  }

  factory Vaccine.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map is null. Cannot create Vaccine object.');
    }
    return Vaccine(
      id: map['id'],
      name: map['name'],
      manufacturer: map['manufacturer'],
      dateOfAdministration: map['dateOfAdministration'],
      sideEffects: List<String>.from(map['sideEffects'] ?? []),
      // patient: map['patient'] != null ? Patient.fromMap(map['patient']) : null,
      administrators: map['administrators'] != null
          ? List<Medcin>.from(map['administrators'].map((x) {
              if (x is Map<String, dynamic>) {
                return Medcin.fromMap(x);
              } else {
                throw ArgumentError(
                    'Invalid administrator data. Expected Map<String, dynamic>.');
              }
            }))
          : null,
      patientId: map['patientId'], // Updated to get patientId
      medcinIds: map['medcinIds'] != null
          ? List<String>.from(map['medcinIds'])
          : null, // Updated to get medcinIds
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'dateOfAdministration': dateOfAdministration,
      'sideEffects': sideEffects,
      'patient': patient?.toMap(),
      'administrators': administrators?.map((x) => x.toMap()).toList(),
      'patientId': patientId, // Added patientId to map
      'medcinIds': medcinIds, // Added medcinIds to map
    };
  }
}
