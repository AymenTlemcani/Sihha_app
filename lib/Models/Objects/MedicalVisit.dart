import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class MedicalVisit {
  String? id;
  Patient? patient;
  List<Medcin>? medcins;
  Timestamp? date;
  String? description;
  String? type;
  String? status;
  String? patientId; // New property
  List<String>? medcinIds; // New property

  MedicalVisit({
    this.id,
    this.patient,
    this.medcins,
    this.date,
    this.description,
    this.type,
    this.status,
    this.patientId,
    this.medcinIds,
  });

  void updateId(String newId) {
    this.id = newId;
  }

  void updatePatient(Patient newPatient) {
    this.patient = newPatient;
  }

  void updateMedics(List<Medcin> newMedcins) {
    this.medcins = newMedcins;
  }

  void updateDate(Timestamp newDate) {
    this.date = newDate;
  }

  void updateDescription(String newDescription) {
    this.description = newDescription;
  }

  void updateType(String newType) {
    this.type = newType;
  }

  void updateStatus(String newStatus) {
    this.status = newStatus;
  }

  factory MedicalVisit.fromMap(Map<String, dynamic> map) {
    try {
      return MedicalVisit(
        id: map['id'],
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        // medcins: map['medcins'] != null
        //     ? List<Medcin>.from(map['medcins'].map((x) => Medcin.fromMap(x)))
        //     : null,
        date: map['date'],
        description: map['description'],
        type: map['type'],
        status: map['status'],
        patientId: map['patientId'], // Updated to get patientId
        medcinIds: map['medcinIds'] != null
            ? List<String>.from(map['medcinIds'])
            : null, // Updated to get medcinIds
      );
    } catch (e) {
      print('Error creating MedicalVisit from map: $e');
      // If an error occurs during map conversion, return a default MedicalVisit object
      return MedicalVisit();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient?.toMap(),
      'medcins': medcins?.map((x) => x.toMap()).toList(),
      'date': date,
      'description': description,
      'type': type,
      'status': status,
      'patientId': patientId, // Added patientId to map
      'medcinIds': medcinIds, // Added medcinIds to map
    };
  }
}
