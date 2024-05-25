import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  String? patientId;
  double? weight;
  Timestamp? date;

  /// Constructor for the Weight class.
  Weight({
    this.patientId,
    this.weight,
    this.date,
  });

  // Method to update the weight value
  void updateWeight(double newWeight) {
    this.weight = newWeight;
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'weight': weight,
      'date': date,
    };
  }

  static Weight fromMap(Map<String, dynamic> map) {
    try {
      return Weight(
        patientId: map['patientId'],
        weight: map['weight']?.toDouble(),
        date: map['date'] as Timestamp?,
      );
    } catch (e) {
      // Handle error
      print('Error parsing Weight from map: $e');
      return Weight();
    }
  }
}
