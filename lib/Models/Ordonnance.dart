import 'package:cloud_firestore/cloud_firestore.dart';

class Ordonnance {
  final String patientIDN;
  final String doctorIDN;
  final String doctorName;
  final String patientName;
  final String prescriptionId;
  final String speciality;
  final Timestamp dateOfCreation;

  Ordonnance({
    required this.patientIDN,
    required this.doctorIDN,
    required this.doctorName,
    required this.patientName,
    required this.prescriptionId,
    required this.speciality,
    required this.dateOfCreation,
  });

  factory Ordonnance.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Ordonnance(
      patientIDN: data['patientIDN'] as String,
      doctorIDN: data['doctorIDN'] as String,
      doctorName: data['doctorName'] as String,
      patientName: data['patientName'] as String,
      prescriptionId: doc.id,
      speciality: data['speciality'] as String,
      dateOfCreation: data['dateOfCreation'] as Timestamp,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'patientIDN': patientIDN,
      'doctorIDN': doctorIDN,
      'doctorName': doctorName,
      'patientName': patientName,
      'speciality': speciality,
      'dateOfCreation': dateOfCreation,
    };
  }

  Future<List<String?>> fetchDoctorProfilePicUrls(
      List<String> doctorIDNs) async {
    Future.delayed(Duration(seconds: 10));
    List<String?> urls = [];
    for (String doctorIDN in doctorIDNs) {
      try {
        QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('IDN', isEqualTo: doctorIDN)
            .limit(1)
            .get();

        if (doctorSnapshot.docs.isNotEmpty) {
          urls.add(doctorSnapshot.docs.first['profilePicUrl'] as String?);
        }
      } catch (e) {
        print('Error fetching doctor profile pic: $e');
      }
    }
    return urls;
  }
}
