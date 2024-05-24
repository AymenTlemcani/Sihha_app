import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class User extends Patient {
  String? password;
  bool isAdmin;
  bool isMedcin;
  bool isPharmacien;
  String? adresse;

  User({
    this.password,
    required this.isAdmin,
    required this.isMedcin,
    required this.isPharmacien,
    this.adresse,
    String? IDN,
    String? familyName,
    String? name,
    String? gender,
    Timestamp? birthDate,
    String? birthPlace,
    String? profilePicUrl,
    String? bio,
    String? documentId,
    String? telephone,
    String? email,
    String? userName,
    List<dynamic>? familyMembers,
    dossierMedical,
  }) : super(
          IDN: IDN,
          familyName: familyName,
          name: name,
          gender: gender,
          birthDate: birthDate,
          birthPlace: birthPlace,
          profilePicUrl: profilePicUrl,
          bio: bio,
          documentId: documentId,
          telephone: telephone,
          email: email,
          userName: userName,
          familyMembers: familyMembers,
        );

  factory User.fromMap(Map<String, dynamic>? map, String mapId) {
    try {
      if (map == null) {
        throw Exception('Map cannot be null');
      }

      return User(
        password: map['password'],
        isAdmin: map['isAdmin'] ?? false,
        isMedcin: map['isMedcin'] ?? false,
        isPharmacien: map['isPharmacien'] ?? false,
        adresse: map['adresse'],
        IDN: map['IDN'],
        documentId: mapId,
        familyName: map['familyName'],
        name: map['name'],
        gender: map['gender'],
        birthDate: map['birthDate'],
        birthPlace: map['birthPlace'],
        profilePicUrl: map['profilePicUrl'],
        bio: map['bio'],
        telephone: map['telephone'],
        email: map['email'] ?? null,
        userName: map['userName'] ?? null,
        familyMembers: map['familyMembers'] ?? null,
        // dossierMedical: DossierMedical?.fromMap(map['dossierMedical']),
      );
    } catch (e) {
      // Error handling
      print('Error parsing User from map: $e');
      rethrow;
    }
  }
  @override
  Map<String, dynamic> toMap() {
    try {
      final patientMap = super.toMap();
      patientMap.addAll({
        'password': password,
        'isAdmin': isAdmin,
        'isMedcin': isMedcin,
        'isPharmacien': isPharmacien,
        'adresse': adresse,
      });
      return patientMap;
    } catch (e) {
      // Error handling
      print('Error converting User to map: $e');
      rethrow;
    }
  }
}
