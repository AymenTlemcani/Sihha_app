import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Patient.dart';
import 'package:sahha_app/Models/Objects/Analyse.dart';
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

class DossierMedical {
  String? id;
  String? patientId;
  List<String>? doctorIds;
  Timestamp? dateCreated;
  List<Timestamp>? dateLastUpdated;
  Patient? patient;
  String? bloodGroup;
  Vision? visionStatus;
  List<Height>? heights;
  List<Weight>? weights;
  List<Ordonnance>? ordonnances;
  List<Medicament>? medications;
  List<Disease>? diseases;
  List<Allergie>? allergies;
  List<Disability>? disabilities;
  List<Vaccine>? vaccines;
  List<Habit>? habits;
  List<Pregnancy>? pregnancies;
  List<BloodPressure>? bloodPressure;
  List<HeartRate>? heartRate;
  List<Temperature>? bodyTemperature;
  List<Operation>? operations;
  List<BloodSugar>? bloodSugarLevels;
  List<MedicalVisit>? medicalVisits;
  List<Radio>? radios;
  List<Analyse>? analyses;

  DossierMedical({
    this.patientId,
    this.doctorIds,
    this.patient,
    this.id,
    this.dateCreated,
    this.dateLastUpdated,
    this.bloodGroup,
    this.heights,
    this.weights,
    this.ordonnances,
    this.medications,
    this.diseases,
    this.allergies,
    this.disabilities,
    this.visionStatus,
    this.vaccines,
    this.habits,
    this.pregnancies,
    this.bloodPressure,
    this.heartRate,
    this.bodyTemperature,
    this.operations,
    this.bloodSugarLevels,
    this.medicalVisits,
    this.radios,
    this.analyses,
  });

  factory DossierMedical.fromMap(Map<String, dynamic> map) {
    try {
      return DossierMedical(
        patientId: map['patientId'],
        doctorIds: List<String>.from(map['doctorIds']),
        // patient: Patient.fromMap(map['patient']),
        id: map['id'],
        dateCreated: map['dateCreated'] as Timestamp?,
        dateLastUpdated: (map['dateLastUpdated'] as List<dynamic>?)
            ?.map((timestamp) => timestamp as Timestamp)
            .toList(),
        bloodGroup: map['bloodGroup'],
        heights: map['heights'] != null
            ? List<Height>.from(map['heights'].map((x) => Height.fromMap(x)))
            : null,
        weights: map['weights'] != null
            ? List<Weight>.from(map['weights'].map((x) => Weight.fromMap(x)))
            : null,
        ordonnances: map['ordonnances'] != null
            ? List<Ordonnance>.from(
                map['ordonnances'].map((x) => Ordonnance.fromMap(x)))
            : null,
        medications: map['medications'] != null
            ? List<Medicament>.from(
                map['medications'].map((x) => Medicament.fromMap(x)))
            : null,
        diseases: map['diseases'] != null
            ? List<Disease>.from(map['diseases'].map((x) => Disease.fromMap(x)))
            : null,
        allergies: map['allergies'] != null
            ? List<Allergie>.from(
                map['allergies'].map((x) => Allergie.fromMap(x)))
            : null,
        disabilities: map['disabilities'] != null
            ? List<Disability>.from(
                map['disabilities'].map((x) => Disability.fromMap(x)))
            : null,
        visionStatus: map['visionStatus'] != null
            ? Vision.fromMap(map['visionStatus'])
            : null,
        vaccines: map['vaccines'] != null
            ? List<Vaccine>.from(map['vaccines'].map((x) => Vaccine.fromMap(x)))
            : null,
        habits: map['habits'] != null
            ? List<Habit>.from(map['habits'].map((x) => Habit.fromMap(x)))
            : null,
        pregnancies: map['pregnancies'] != null
            ? List<Pregnancy>.from(
                map['pregnancies'].map((x) => Pregnancy.fromMap(x)))
            : null,
        bloodPressure: map['bloodPressure'] != null
            ? List<BloodPressure>.from(
                map['bloodPressure'].map((x) => BloodPressure.fromMap(x)))
            : null,
        heartRate: map['heartRate'] != null
            ? List<HeartRate>.from(
                map['heartRate'].map((x) => HeartRate.fromMap(x)))
            : null,
        bodyTemperature: map['bodyTemperature'] != null
            ? List<Temperature>.from(
                map['bodyTemperature'].map((x) => Temperature.fromMap(x)))
            : null,
        operations: map['operations'] != null
            ? List<Operation>.from(
                map['operations'].map((x) => Operation.fromMap(x)))
            : null,
        bloodSugarLevels: map['bloodSugarLevels'] != null
            ? List<BloodSugar>.from(
                map['bloodSugarLevels'].map((x) => BloodSugar.fromMap(x)))
            : null,
        medicalVisits: map['medicalVisits'] != null
            ? List<MedicalVisit>.from(
                map['medicalVisits'].map((x) => MedicalVisit.fromMap(x)))
            : null,
        radios: map['radios'] != null
            ? List<Radio>.from(map['radios'].map((x) => Radio.fromMap(x)))
            : null,
        analyses: map['analyses'] != null
            ? List<Analyse>.from(map['analyses'].map((x) => Analyse.fromMap(x)))
            : null,
      );
    } catch (e) {
      print('Error creating DossierMedical from map: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'patientId': patientId,
        'doctorIds': doctorIds?.toList(),
        'patient': patient?.toMap(),
        'id': id,
        'dateCreated': dateCreated,
        'dateLastUpdated': dateLastUpdated,
        'bloodGroup': bloodGroup,
        'heights': heights?.map((height) => height.toMap()).toList(),
        'weights': weights?.map((weight) => weight.toMap()).toList(),
        'ordonnances':
            ordonnances?.map((ordonnance) => ordonnance.toMap()).toList(),
        'medications':
            medications?.map((medicament) => medicament.toMap()).toList(),
        'diseases': diseases?.map((disease) => disease.toMap()).toList(),
        'allergies': allergies?.map((allergie) => allergie.toMap()).toList(),
        'disabilities':
            disabilities?.map((disability) => disability.toMap()).toList(),
        'visionStatus': visionStatus?.toMap(),
        'vaccines': vaccines?.map((vaccine) => vaccine.toMap()).toList(),
        'habits': habits?.map((habit) => habit.toMap()).toList(),
        'pregnancies':
            pregnancies?.map((pregnancy) => pregnancy.toMap()).toList(),
        'bloodPressure': bloodPressure?.map((bp) => bp.toMap()).toList(),
        'heartRate': heartRate?.map((hr) => hr.toMap()).toList(),
        'bodyTemperature':
            bodyTemperature?.map((temp) => temp.toMap()).toList(),
        'operations':
            operations?.map((operation) => operation.toMap()).toList(),
        'bloodSugarLevels': bloodSugarLevels?.map((bs) => bs.toMap()).toList(),
        'medicalVisits': medicalVisits?.map((visit) => visit.toMap()).toList(),
        'radios': radios?.map((radio) => radio.toMap()).toList(),
        'analyses': analyses?.map((analyse) => analyse.toMap()).toList(),
      };
    } catch (e) {
      print('Error converting DossierMedical to map: $e');
      rethrow;
    }
  }
}
