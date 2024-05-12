import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';

class User extends Patient {
  String password;
  bool isAdmin;
  bool isMedcin;
  bool isPharmacie;
  String? speciality;
  String? clinicName;
  String? digitalSignature;

  User({
    required String IDN,
    required this.password,
    required String familyName,
    required String name,
    required String gender,
    required int birthDay,
    required int birthMonth,
    required int birthYear,
    required String birthPlace,
    required String? profilePicUrl,
    required String? bio,
    required String? telephone,
    required String? bloodType,
    required double? weight,
    required double? height,
    required this.isAdmin,
    required this.isMedcin,
    required this.isPharmacie,
    this.speciality,
    this.clinicName,
    this.digitalSignature,
  }) : super(
          IDN: IDN,
          familyName: familyName,
          name: name,
          gender: gender,
          birthDay: birthDay,
          birthMonth: birthMonth,
          birthYear: birthYear,
          birthPlace: birthPlace,
          profilePicUrl: profilePicUrl,
          bio: bio,
          telephone: telephone,
          bloodType: bloodType,
          weight: weight,
          height: height,
        );

  void updateIDN(String newIDN) {
    super.updateIDN(newIDN);
  }

  void updatePassword(String newPassword) {
    password = newPassword;
  }

  void updateFamilyName(String newFamilyName) {
    super.updateFamilyName(newFamilyName);
  }

  void updateName(String newName) {
    super.updateName(newName);
  }

  void updateGender(String newGender) {
    super.updateGender(newGender);
  }

  void updateBirthday(int newBirthDay, int newBirthMonth, int newBirthYear) {
    super.updateBirthday(newBirthDay, newBirthMonth, newBirthYear);
  }

  void updateBirthPlace(String newBirthPlace) {
    super.updateBirthPlace(newBirthPlace);
  }

  void updateProfilePicUrl(String newProfilePicUrl) {
    super.updateProfilePicUrl(newProfilePicUrl);
  }

  void updateBio(String newBio) {
    super.updateBio(newBio);
  }

  void updateDocumentId(String? newDocumentId) {
    super.updateDocumentId(newDocumentId);
  }

  void updateTelephone(String newTelephone) {
    super.updateTelephone(newTelephone);
  }

  void updateBloodType(String newBloodType) {
    super.updateBloodType(newBloodType);
  }

  void updateWeight(double newWeight) {
    super.updateWeight(newWeight);
  }

  void updateHeight(double newHeight) {
    super.updateHeight(newHeight);
  }

  void updateOrdonnances(List<Ordonnance> newOrdonnances) {
    super.updateOrdonnances(newOrdonnances);
  }

  void updateFamily(List<String> newFamily) {
    super.updateFamily(newFamily);
  }

  void updateRadios(List<String> newRadios) {
    super.updateRadios(newRadios);
  }

  void updateAnalyses(List<String> newAnalyses) {
    super.updateAnalyses(newAnalyses);
  }

  void updateIsAdmin(bool newIsAdmin) {
    isAdmin = newIsAdmin;
  }

  void updateIsMedcin(bool newIsMedcin) {
    isMedcin = newIsMedcin;
  }

  void updateIsPharmacie(bool newIsPharmacie) {
    isPharmacie = newIsPharmacie;
  }

  void updateSpeciality(String newSpeciality) {
    speciality = newSpeciality;
  }

  void updateClinicName(String newClinicName) {
    clinicName = newClinicName;
  }

  void updateDigitalSignature(String? newDigitalSignature) {
    digitalSignature = newDigitalSignature;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        IDN: json['IDN'],
        password: json['password'],
        familyName: json['familyName'],
        name: json['name'],
        gender: json['gender'],
        birthDay: json['birthDay'],
        birthMonth: json['birthMonth'],
        birthYear: json['birthYear'],
        birthPlace: json['birthPlace'],
        profilePicUrl: json['profilePicUrl'],
        bio: json['bio'],
        telephone: json['telephone'],
        bloodType: json['bloodType'],
        weight: json['weight'],
        height: json['height'],
        isAdmin: json['isAdmin'] ?? false,
        isMedcin: json['isMedcin'] ?? false,
        isPharmacie: json['isPharmacie'] ?? false,
        speciality: json['speciality'],
        clinicName: json['clinicName'],
        digitalSignature: json['digitalSignature']);
  }
}
