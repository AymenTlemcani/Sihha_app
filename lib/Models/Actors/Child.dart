import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/DossierMedical.dart';

class Child {
  Patient? responsable;
  String? responsableId;
  String? responsableIDN;
  String? id;
  String? name;
  String? familyName;
  Timestamp? birthDate;
  String? gender;
  String? username;
  String? birthPlace;
  String? address;
  String? profilePicUrl;
  DossierMedical? dossierMedical;

  Child({
    this.responsableId,
    this.responsable,
    this.responsableIDN,
    this.id,
    this.name,
    this.familyName,
    this.birthDate,
    this.gender,
    this.username,
    this.birthPlace,
    this.address,
    this.profilePicUrl, // Added property
    this.dossierMedical,
  });

  factory Child.fromMap(
    Map<String, dynamic> map,
  ) {
    try {
      return Child(
        // responsable: Patient.fromMap(map['responsable']),
        responsableId: map['responsableId'],
        responsableIDN: map['responsableIDN'],
        id: map['id'],
        name: map['name'],
        familyName: map['familyName'],
        birthDate: map['birthDate'] as Timestamp?,
        gender: map['gender'],
        username: map['username'],
        birthPlace: map['birthPlace'],
        address: map['address'],
        profilePicUrl: map['profilePicUrl'], // Added line
        // dossierMedical: map['dossierMedical'] != null
        //     ? DossierMedical.fromMap(map['dossierMedical'])
        //     : null,
      );
    } catch (e) {
      print('Error creating Child from map: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        // 'responsable': responsable.toMap(),
        'id': id,
        'responsableIDN': responsableIDN,
        'responsableId': responsableId,
        'name': name,
        'familyName': familyName,
        'birthDate': birthDate,
        'gender': gender,
        'username': username,
        'birthPlace': birthPlace,
        'address': address,
        'profilePicUrl': profilePicUrl, // Added line
        'dossierMedical': dossierMedical?.toMap(),
      };
    } catch (e) {
      print('Error converting Child to map: $e');
      rethrow;
    }
  }
}
