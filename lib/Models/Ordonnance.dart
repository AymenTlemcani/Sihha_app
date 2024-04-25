import 'package:cloud_firestore/cloud_firestore.dart';

class Prescription {
  final String doctorName;
  final String specialty;
  final DateTime dateOfCreation;
  final String prescriptionId;

  Prescription({
    required this.doctorName,
    required this.specialty,
    required this.dateOfCreation,
    required this.prescriptionId,
  });

  factory Prescription.fromFirestore(Map<String, dynamic> data) {
    return Prescription(
      doctorName: data['doctorName'] ?? '',
      specialty: data['specialty'] ?? '',
      dateOfCreation: (data['dateOfCreation'] as Timestamp).toDate(),
      prescriptionId: data['prescriptionId'] ?? '',
    );
  }
}
