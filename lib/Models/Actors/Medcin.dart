import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Objects/HealthPlace.dart';

class Medcin extends User {
  String? professionalPhoneNumber;
  String? professionalEmail;
  String? digitalSignature;
  List<String>? certificates;
  String? speciality;
  HealthPlace? workPlace;
  List<Patient>? patients;
  String? availability;
  String? education;
  int? experience;

  Medcin({
    String? password,
    required bool isAdmin,
    required bool isMedcin,
    required bool isPharmacien,
    String? adresse,
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
    this.professionalPhoneNumber,
    this.professionalEmail,
    this.digitalSignature,
    this.certificates,
    this.speciality,
    this.workPlace,
    this.patients,
    this.availability,
    this.education,
    this.experience,
  }) : super(
          password: password,
          isAdmin: isAdmin,
          isMedcin: isMedcin,
          isPharmacien: isPharmacien,
          adresse: adresse,
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
          // dossierMedical: dossierMedical,
        );

  factory Medcin.fromMap(Map<String, dynamic> map) {
    try {
      return Medcin(
        password: map['password'],
        isAdmin: map['isAdmin'] ?? false,
        isMedcin: map['isMedcin'] ?? true,
        isPharmacien: map['isPharmacien'] ?? false,
        adresse: map['adresse'],
        IDN: map['IDN'],
        familyName: map['familyName'],
        name: map['name'],
        gender: map['gender'],
        birthDate: map['birthDate'],
        birthPlace: map['birthPlace'],
        profilePicUrl: map['profilePicUrl'],
        bio: map['bio'],
        documentId: map['documentId'],
        telephone: map['telephone'],
        email: map['email'],
        userName: map['userName'],
        familyMembers: map['familyMembers'],
        // dossierMedical: DossierMedical?.fromMap(map['dossierMedical']),
        professionalPhoneNumber: map['professionalPhoneNumber'],
        professionalEmail: map['professionalEmail'],
        digitalSignature: map['digitalSignature'],
        certificates: List<String>.from(map['certificates'] ?? []),
        speciality: map['speciality'],
        workPlace: HealthPlace.fromMap(map['workPlace']),
        // patients: (map['patients'] != null)
        //     ? List<Patient>.from(
        //         map['patients'].map((patient) => Patient.fromMap(patient)))
        //     : null,
        availability: map['availability'] ?? null,
        education: map['education'] ?? null,
        experience: map['experience'] ?? null,
      );
    } catch (e) {
      print('Error parsing Medcin from map: $e');
      throw Exception('Error parsing Medcin from map');
    }
  }

  @override
  Map<String, dynamic> toMap() {
    try {
      final userMap = super.toMap();
      return {
        ...userMap,
        'professionalPhoneNumber': professionalPhoneNumber,
        'professionalEmail': professionalEmail,
        'digitalSignature': digitalSignature,
        'certificates': certificates,
        'speciality': speciality,
        'workPlace': workPlace?.toMap(),
        'patients': patients?.map((patient) => patient.toMap()).toList(),
        'availability': availability,
        'education': education,
        'experience': experience,
      };
    } catch (e) {
      print('Error converting Medcin to map: $e');
      throw Exception('Error converting Medcin to map');
    }
  }
}
