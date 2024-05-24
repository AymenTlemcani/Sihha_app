import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';

class Analyse {
  String? id;
  String? name;
  String? result;
  String? date;
  String? description;
  String? patientId; // Added patientId
  List<String>? medcinsIds;
  Patient? patient;
  List<Medcin>? medcins;

  Analyse({
    this.id,
    this.name,
    this.result,
    this.date,
    this.description,
    this.patient,
    this.medcins,
    this.patientId,
    this.medcinsIds,
  });

  factory Analyse.fromMap(Map<String, dynamic> map) {
    try {
      return Analyse(
        id: map['id'],
        name: map['name'],
        result: map['result'],
        date: map['date'],
        description: map['description'],
        patientId: map['patientId'], // Assigning patientId
        medcinsIds:
            List<String>.from(map['medcinsIds'] ?? []), // Assigning medcinsIds
        // patient:
        //     map['patient'] != null ? Patient.fromMap(map['patient']) : null,
        // medcins: map['medcins'] != null
        //     ? List<Medcin>.from(
        //         map['medcins'].map((medcinMap) => Medcin.fromMap(medcinMap)))
        //     : null,
      );
    } catch (e) {
      print('Error parsing Analyse from map: $e');
      throw Exception('Error parsing Analyse from map');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'result': result,
      'date': date,
      'description': description,
      'patientId': patientId, // Adding patientId
      'medcinsIds': medcinsIds, // Adding medcinsIds
      'patient': patient?.toMap(),
      'medcins': medcins?.map((medcin) => medcin.toMap()).toList(),
    };
  }
}
