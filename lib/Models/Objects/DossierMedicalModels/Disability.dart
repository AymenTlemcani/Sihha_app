import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';

class Disability {
  String? id;
  String? patientId;
  String? name;
  String? description;
  Timestamp? dateOfStart;
  Timestamp? dateOfEnd;
  String? type;
  String? status;
  String? level;
  List<User>? medcins;
  Patient? patient;

  /// Constructor for the Disability class.
  Disability({
    this.id,
    this.patientId,
    this.patient,
    this.name,
    this.description,
    this.medcins,
    this.dateOfStart,
    this.dateOfEnd,
    this.type,
    this.status,
    this.level,
  });

  // Method to update the id
  void updateId(String newId) {
    this.id = newId;
  }

  // Method to update the patient
  void updatePatient(Patient newPatient) {
    this.patient = newPatient;
  }

  // Method to update the name of the disability
  void updateName(String newName) {
    this.name = newName;
  }

  // Method to update the description of the disability
  void updateDescription(String newDescription) {
    this.description = newDescription;
  }

  // Method to update the medics list
  void updateMedics(List<User> newMedcins) {
    this.medcins = newMedcins;
  }

  // Method to update the date of start
  void updateDateOfStart(Timestamp newDateOfStart) {
    this.dateOfStart = newDateOfStart;
  }

  // Method to update the date of end
  void updateDateOfEnd(Timestamp newDateOfEnd) {
    this.dateOfEnd = newDateOfEnd;
  }

  // Method to update the type of the disability
  void updateType(String newType) {
    this.type = newType;
  }

  // Method to update the status of the disability
  void updateStatus(String newStatus) {
    this.status = newStatus;
  }

  factory Disability.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Disability();
    return Disability(
      id: map['id'],
      patientId: map['patientId'],
      // patient: map['patient'] != null ? Patient.fromMap(map['patient']) : null,
      name: map['name'],
      description: map['description'],
      // medcins: map['medcins'] != null
      //     ? List<User>.from(map['medcins'].map((x) => User.fromMap(x)))
      //     : null,
      dateOfStart:
          map['dateOfStart'] != null ? (map['dateOfStart'] as Timestamp) : null,
      dateOfEnd:
          map['dateOfEnd'] != null ? (map['dateOfEnd'] as Timestamp) : null,
      type: map['type'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'patient': patient?.toMap(),
      'name': name,
      'description': description,
      'medcins': medcins?.map((x) => x.toMap()).toList(),
      'dateOfStart': dateOfStart,
      'dateOfEnd': dateOfEnd,
      'type': type,
      'status': status,
    };
  }
}
