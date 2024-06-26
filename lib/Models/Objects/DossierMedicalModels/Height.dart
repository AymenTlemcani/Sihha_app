import 'package:cloud_firestore/cloud_firestore.dart';

class Height {
  String? patientId;
  double? height;
  Timestamp? date;

  Height({
    this.height,
    this.date,
    this.patientId,
  });

  // Method to update the height value
  void updateHeight(double newHeight) {
    this.height = newHeight;
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'height': height,
      'date': date,
    };
  }

  static Height fromMap(Map<String, dynamic> map) {
    try {
      return Height(
        patientId: map['patientId'],
        height: map['height']?.toDouble(),
        date: map['date'] as Timestamp?,
      );
    } catch (e) {
      // Handle error
      print('Error parsing Height from map: $e');
      return Height();
    }
  }
}
