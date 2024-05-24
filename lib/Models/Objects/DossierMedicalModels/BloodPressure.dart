import 'package:cloud_firestore/cloud_firestore.dart';

class BloodPressure {
  double? systolic;
  double? diastolic;
  Timestamp? date;
  String? id;
  String? status; // Normal, High, Low
  String? description;

  /// Constructor for the BloodPressure class.
  BloodPressure({
    this.systolic,
    this.diastolic,
    this.date,
    this.id,
    this.status,
    this.description,
  });

  // Method to update the systolic pressure
  void updateSystolic(double newSystolic) {
    this.systolic = newSystolic;
  }

  // Method to update the diastolic pressure
  void updateDiastolic(double newDiastolic) {
    this.diastolic = newDiastolic;
  }

  // Method to update the date
  void updateDate(Timestamp newDate) {
    this.date = newDate;
  }

  // Method to update the status
  void updateStatus(String newStatus) {
    this.status = newStatus;
  }

  // Method to update the description
  void updateDescription(String newDescription) {
    this.description = newDescription;
  }

  // Factory method to create a BloodPressure object from a Map
  factory BloodPressure.fromMap(Map<String, dynamic> map) {
    try {
      return BloodPressure(
        systolic: map['systolic'],
        diastolic: map['diastolic'],
        date: map['date'],
        id: map['id'],
        status: map['status'],
        description: map['description'],
      );
    } catch (e) {
      print('Error creating BloodPressure from map: $e');
      // If an error occurs during map conversion, return a default BloodPressure object
      return BloodPressure();
    }
  }

  // Method to convert BloodPressure object to a Map
  Map<String, dynamic> toMap() {
    return {
      'systolic': systolic,
      'diastolic': diastolic,
      'date': date,
      'id': id,
      'status': status,
      'description': description,
    };
  }
}
