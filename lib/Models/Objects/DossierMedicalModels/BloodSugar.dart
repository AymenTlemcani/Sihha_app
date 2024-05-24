import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class BloodSugar {
  String? id;
  Patient? patient;
  double? value;
  Timestamp? dateTime;

  /// Constructor for the BloodSugar class.
  BloodSugar({
    this.id,
    this.patient,
    this.value,
    this.dateTime,
  });

  // Method to update the blood sugar value
  void updateValue(double newValue) {
    this.value = newValue;
  }

  // Method to update the date and time of the blood sugar reading
  void updateDateTime(Timestamp newDateTime) {
    this.dateTime = newDateTime;
  }

  // Factory method to create a BloodSugar object from a Map
  factory BloodSugar.fromMap(Map<String, dynamic> map) {
    try {
      return BloodSugar(
        id: map['id'],
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        value: map['value'],
        dateTime: map['dateTime'],
      );
    } catch (e) {
      print('Error creating BloodSugar from map: $e');
      // If an error occurs during map conversion, return a default BloodSugar object
      return BloodSugar();
    }
  }

  // Method to convert BloodSugar object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient?.toMap(),
      'value': value,
      'dateTime': dateTime,
    };
  }
}
