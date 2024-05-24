import 'package:cloud_firestore/cloud_firestore.dart';

class Temperature {
  double? value;
  Timestamp? date;
  String? id;
  String? status; // Normal, Fever, Hypothermia
  String? description;

  /// Constructor for the Temperature class.
  Temperature({
    this.value,
    this.date,
    this.id,
    this.status,
    this.description,
  });

  // Method to update the temperature value
  void updateValue(double newValue) {
    this.value = newValue;
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

  // Factory method to create a Temperature object from a Map
  factory Temperature.fromMap(Map<String, dynamic> map) {
    try {
      return Temperature(
        value: map['value'],
        date: map['date'],
        id: map['id'],
        status: map['status'],
        description: map['description'],
      );
    } catch (e) {
      print('Error creating Temperature from map: $e');
      // If an error occurs during map conversion, return a default Temperature object
      return Temperature();
    }
  }

  // Method to convert Temperature object to a Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'date': date,
      'id': id,
      'status': status,
      'description': description,
    };
  }
}
