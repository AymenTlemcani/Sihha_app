import 'package:cloud_firestore/cloud_firestore.dart';

class HeartRate {
  int? rate;
  Timestamp? date;
  String? id;
  String? status; // Normal, High, Low
  String? description;

  /// Constructor for the HeartRate class.
  HeartRate({
    this.rate,
    this.date,
    this.id,
    this.status,
    this.description,
  });

  // Method to update the heart rate
  void updateRate(int newRate) {
    this.rate = newRate;
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

  // Factory method to create a HeartRate object from a Map
  factory HeartRate.fromMap(Map<String, dynamic> map) {
    try {
      return HeartRate(
        rate: map['rate'],
        date: map['date'],
        id: map['id'],
        status: map['status'],
        description: map['description'],
      );
    } catch (e) {
      print('Error creating HeartRate from map: $e');
      // If an error occurs during map conversion, return a default HeartRate object
      return HeartRate();
    }
  }

  // Method to convert HeartRate object to a Map
  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'date': date,
      'id': id,
      'status': status,
      'description': description,
    };
  }
}
