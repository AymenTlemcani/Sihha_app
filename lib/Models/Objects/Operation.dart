import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';

class Operation {
  String? id;
  String? name;
  Timestamp? date;
  String? description;
  String? outcome;
  String? outcomeDescription;
  String? status;
  Patient? patient;
  List<Medcin>? medcins;
  String? patientId; // New property
  List<String>? medcinIds; // New property

  Operation({
    this.id,
    this.name,
    this.date,
    this.description,
    this.outcome,
    this.outcomeDescription,
    this.status,
    this.patient,
    this.medcins,
    this.patientId,
    this.medcinIds,
  });

  void updateName(String newName) {
    this.name = newName;
  }

  void updateDate(Timestamp newDate) {
    this.date = newDate;
  }

  void updateDescription(String newDescription) {
    this.description = newDescription;
  }

  void updateOutcome(String newOutcome) {
    this.outcome = newOutcome;
  }

  void updateOutcomeDescription(String newOutcomeDescription) {
    this.outcomeDescription = newOutcomeDescription;
  }

  void updateStatus(String newStatus) {
    this.status = newStatus;
  }

  factory Operation.fromMap(Map<String, dynamic> map) {
    try {
      return Operation(
        id: map['id'],
        name: map['name'],
        date: map['date'],
        description: map['description'],
        outcome: map['outcome'],
        outcomeDescription: map['outcomeDescription'],
        status: map['status'],
        patientId: map['patientId'], // Updated to get patientId
        medcinIds: map['medcinIds'] != null
            ? List<String>.from(map['medcinIds'])
            : null, // Updated to get medcinIds
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        // medcins: map['medcins'] != null
        //     ? List<Medcin>.from(map['medcins'].map((x) => Medcin.fromMap(x)))
        //     : null,
      );
    } catch (e) {
      print('Error creating Operation from map: $e');
      return Operation();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'description': description,
      'outcome': outcome,
      'outcomeDescription': outcomeDescription,
      'status': status,
      'patientId': patientId, // Added patientId to map
      'medcinIds': medcinIds, // Added medcinIds to map
      'patient': patient?.toMap(),
      'medcins': medcins?.map((x) => x.toMap()).toList(),
    };
  }
}
