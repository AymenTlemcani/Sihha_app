import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  double? weight;
  Timestamp? date;

  /// Constructor for the Weight class.
  Weight({
    this.weight,
    this.date,
  });

  // Method to update the weight value
  void updateWeight(double newWeight) {
    this.weight = newWeight;
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'date': date,
    };
  }

  static Weight fromMap(Map<String, dynamic> map) {
    try {
      return Weight(
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
