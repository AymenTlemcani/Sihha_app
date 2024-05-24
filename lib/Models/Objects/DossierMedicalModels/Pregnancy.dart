import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';

class Pregnancy {
  Patient? patient;
  List<User>? medcins;
  Timestamp? date;
  String? id;
  String? type;
  String? status; // current or past
  String? description;
  String? outcome;
  String? outcomeDescription;
  String?
      gestationalAge; // The current stage of the pregnancy, measured in weeks or months from the first day of the last menstrual period (LMP).
  List<String>?
      complications; // Any issues or concerns that have arisen during the current pregnancy, such as gestational diabetes, preeclampsia, or preterm labor.

  /// Constructor for the Pregnancy class.
  Pregnancy({
    this.patient,
    this.medcins,
    this.date,
    this.id,
    this.type,
    this.status,
    this.description,
    this.outcome,
    this.outcomeDescription,
    this.gestationalAge,
    this.complications,
  });

  // Method to convert Pregnancy object to a Map
  Map<String, dynamic> toMap() {
    return {
      'patient': patient?.toMap(),
      'medcins': medcins?.map((user) => user.toMap()).toList(),
      'date': date,
      'id': id,
      'type': type,
      'status': status,
      'description': description,
      'outcome': outcome,
      'outcomeDescription': outcomeDescription,
      'gestationalAge': gestationalAge,
      'complications': complications,
    };
  }

  // Factory method to create a Pregnancy object from a Map
  factory Pregnancy.fromMap(Map<String, dynamic> map) {
    try {
      return Pregnancy(
        // patient:
        // map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        // medcins: map['medcins'] != null
        // ? List<User>.from(map['medcins'].map((user) => User.fromMap(user)))
        // : null,
        date: map['date'],
        id: map['id'],
        type: map['type'],
        status: map['status'],
        description: map['description'],
        outcome: map['outcome'],
        outcomeDescription: map['outcomeDescription'],
        gestationalAge: map['gestationalAge'],
        complications: List<String>.from(map['complications'] ?? []),
      );
    } catch (e) {
      print('Error creating Pregnancy from map: $e');
      // If an error occurs during map conversion, return a default Pregnancy object
      return Pregnancy();
    }
  }
}
