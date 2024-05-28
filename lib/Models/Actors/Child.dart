import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Analyse.dart';
import 'package:sahha_app/Models/Objects/DossierMedical.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Allergie.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/BloodPressure.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/BloodSugar.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disability.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Disease.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Habit.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/HeartRate.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Height.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Pregnancy.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Temperature.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Vision.dart';
import 'package:sahha_app/Models/Objects/DossierMedicalModels/Weight.dart';
import 'package:sahha_app/Models/Objects/MedicalVisit.dart';
import 'package:sahha_app/Models/Objects/Medicament.dart';
import 'package:sahha_app/Models/Objects/Operation.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Objects/Radio.dart';
import 'package:sahha_app/Models/Objects/Vaccine.dart';

class Child extends Patient {
  String? responsableId;
  String? responsableIDN;
  Patient? responsable;
  DossierMedical? dossierMedical;

  Child({
    this.responsableId,
    this.responsableIDN,
    this.responsable,
    this.dossierMedical,
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
    String? bloodGroup,
    Vision? visionStatus,
    List<Height>? heights,
    List<Weight>? weights,
    List<Ordonnance>? ordonnances,
    List<Medicament>? medications,
    List<Disease>? diseases,
    List<Allergie>? allergies,
    List<Disability>? disabilities,
    List<Vaccine>? vaccines,
    List<Habit>? habits,
    List<Pregnancy>? pregnancies,
    List<BloodPressure>? bloodPressure,
    List<HeartRate>? heartRate,
    List<Temperature>? bodyTemperature,
    List<Operation>? operations,
    List<BloodSugar>? bloodSugarLevels,
    List<MedicalVisit>? medicalVisits,
    List<Radio>? radios,
    List<Analyse>? analyses,
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
          bloodGroup: bloodGroup,
          visionStatus: visionStatus,
          heights: heights,
          weights: weights,
          ordonnances: ordonnances,
          medications: medications,
          diseases: diseases,
          allergies: allergies,
          disabilities: disabilities,
          vaccines: vaccines,
          habits: habits,
          pregnancies: pregnancies,
          bloodPressure: bloodPressure,
          heartRate: heartRate,
          bodyTemperature: bodyTemperature,
          operations: operations,
          bloodSugarLevels: bloodSugarLevels,
          medicalVisits: medicalVisits,
          radios: radios,
          analyses: analyses,
        );

  factory Child.fromMap(Map<String, dynamic> map) {
    try {
      return Child(
        responsableId: map['responsableId'],
        responsableIDN: map['responsableIDN'],
        responsable: map['responsable'] != null
            ? Patient.fromMap(map['responsable'], '')
            : null,
        dossierMedical: map['dossierMedical'] != null
            ? DossierMedical.fromMap(map['dossierMedical'])
            : null,
        IDN: map['IDN'],
        familyName: map['familyName'],
        name: map['name'],
        gender: map['gender'],
        birthDate: map['birthDate'] as Timestamp?,
        birthPlace: map['birthPlace'],
        profilePicUrl: map['profilePicUrl'],
        bio: map['bio'],
        documentId: map['documentId'],
        telephone: map['telephone'],
        email: map['email'],
        userName: map['userName'],
        familyMembers: map['familyMembers'],
        bloodGroup: map['bloodGroup'],
        visionStatus: map['visionStatus'] != null
            ? Vision.fromMap(map['visionStatus'])
            : null,
        // heights: map['heights'] != null
        // //     ? Patient._convertList<Height>(
        // //         map['heights'], (item) => Height.fromMap(item))
        // //     : null,
        // // weights: map['weights'] != null
        // //     ? Patient._convertList<Weight>(
        // //         map['weights'], (item) => Weight.fromMap(item))
        // //     : null,
        // // ordonnances: map['ordonnances'] != null
        // //     ? Patient._convertList<Ordonnance>(
        // //         map['ordonnances'], (item) => Ordonnance.fromMap(item))
        // //     : null,
        // // medications: map['medications'] != null
        // //     ? Patient._convertList<Medicament>(
        // //         map['medications'], (item) => Medicament.fromMap(item))
        // //     : null,
        // // diseases: map['diseases'] != null
        // //     ? Patient._convertList<Disease>(
        // //         map['diseases'], (item) => Disease.fromMap(item))
        // //     : null,
        // // allergies: map['allergies'] != null
        // //     ? Patient._convertList<Allergie>(
        // //         map['allergies'], (item) => Allergie.fromMap(item))
        // //     : null,
        // // disabilities: map['disabilities'] != null
        // //     ? Patient._convertList<Disability>(
        // //         map['disabilities'], (item) => Disability.fromMap(item))
        // //     : null,
        // // vaccines: map['vaccines'] != null
        // //     ? Patient._convertList<Vaccine>(
        // //         map['vaccines'], (item) => Vaccine.fromMap(item))
        // //     : null,
        // // habits: map['habits'] != null
        // //     ? Patient._convertList<Habit>(
        // //         map['habits'], (item) => Habit.fromMap(item))
        // //     : null,
        // // pregnancies: map['pregnancies'] != null
        // //     ? Patient._convertList<Pregnancy>(
        // //         map['pregnancies'], (item) => Pregnancy.fromMap(item))
        // //     : null,
        // // bloodPressure: map['bloodPressure'] != null
        // //     ? Patient._convertList<BloodPressure>(
        // //         map['bloodPressure'], (item) => BloodPressure.fromMap(item))
        // //     : null,
        // // heartRate: map['heartRate'] != null
        // //     ? Patient._convertList<HeartRate>(
        // //         map['heartRate'], (item) => HeartRate.fromMap(item))
        // //     : null,
        // // bodyTemperature: map['bodyTemperature'] != null
        // //     ? Patient._convertList<Temperature>(
        // //         map['bodyTemperature'], (item) => Temperature.fromMap(item))
        // //     : null,
        // // operations: map['operations'] != null
        // //     ? Patient._convertList<Operation>(
        // //         map['operations'], (item) => Operation.fromMap(item))
        // //     : null,
        // // bloodSugarLevels: map['bloodSugarLevels'] != null
        // //     ? Patient._convertList<BloodSugar>(
        // //         map['bloodSugarLevels'], (item) => BloodSugar.fromMap(item))
        // //     : null,
        // // medicalVisits: map['medicalVisits'] != null
        // //     ? Patient._convertList<MedicalVisit>(
        // //         map['medicalVisits'], (item) => MedicalVisit.fromMap(item))
        // //     : null,
        // // radios: map['radios'] != null
        // //     ? Patient._convertList<Radio>(
        // //         map['radios'], (item) => Radio.fromMap(item))
        // //     : null,
        // // analyses: map['analyses'] != null
        // //     ? Patient._convertList<Analyse>(
        // //         map['analyses'], (item) => Analyse.fromMap(item))
        // //     : null,
      );
    } catch (e) {
      print('Error creating Child from map: $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toMap() {
    try {
      return {
        ...super.toMap(),
        'responsableId': responsableId,
        'responsableIDN': responsableIDN,
        'responsable': responsable?.toMap(),
        'dossierMedical': dossierMedical?.toMap(),
      };
    } catch (e) {
      print('Error converting Child to map: $e');
      rethrow;
    }
  }
}
