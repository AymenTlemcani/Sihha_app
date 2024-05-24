import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class Radio {
  String? id;
  List<String>? imageUrls;
  String? description;
  Timestamp? date;
  Patient? patient;
  List<Medcin>? medcins;
  String? patientId; // New property
  List<String>? medcinIds; // New property

  Radio({
    this.id,
    this.imageUrls,
    this.description,
    this.date,
    this.patient,
    this.medcins,
    this.patientId,
    this.medcinIds,
  });

  factory Radio.fromMap(Map<String, dynamic> map) {
    try {
      return Radio(
        id: map['id'],
        imageUrls: List<String>.from(map['imageUrls']),
        description: map['description'],
        date: map['date'],
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        // medcins: map['medcins'] != null
        //     ? List<Medcin>.from(map['medcins'].map((x) => Medcin.fromMap(x)))
        //     : null,
        patientId: map['patientId'], // Updated to get patientId
        medcinIds: map['medcinIds'] != null
            ? List<String>.from(map['medcinIds'])
            : null, // Updated to get medcinIds
      );
    } catch (e) {
      print('Error creating Radio from map: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'imageUrls': imageUrls,
        'description': description,
        'date': date,
        'patient': patient?.toMap(),
        'medcins': medcins?.map((medcin) => medcin.toMap()).toList(),
        'patientId': patientId, // Added patientId to map
        'medcinIds': medcinIds, // Added medcinIds to map
      };
    } catch (e) {
      print('Error converting Radio to map: $e');
      rethrow;
    }
  }
}
