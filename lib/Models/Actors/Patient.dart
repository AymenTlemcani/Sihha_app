import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Child.dart';
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

class Patient {
  String? IDN;
  String? familyName;
  String? name;
  String? gender;
  Timestamp? birthDate;
  String? birthPlace;
  String? profilePicUrl;
  String? bio;
  String? documentId;
  String? telephone;
  String? email;
  String? userName;
  List<dynamic>? familyMembers;
  //
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

  Patient({
    this.IDN,
    this.familyName,
    this.name,
    this.gender,
    this.birthDate,
    this.birthPlace,
    this.profilePicUrl,
    this.bio,
    this.documentId,
    this.telephone,
    this.email,
    this.userName,
    this.familyMembers,
    this.bloodGroup,
    this.visionStatus,
    this.heights,
    this.weights,
    this.ordonnances,
    this.medications,
    this.diseases,
    this.allergies,
    this.disabilities,
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

  factory Patient.fromMap(Map<String, dynamic> map, String mapId) {
    try {
      return Patient(
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
        bloodGroup: map['bloodGroup'],
        visionStatus: Vision.fromMap(map['visionStatus']),
        heights: _convertList<Height>(
            map['heights'], (item) => Height.fromMap(item)),
        weights: _convertList<Weight>(
            map['weights'], (item) => Weight.fromMap(item)),
        ordonnances: _convertList<Ordonnance>(
            map['ordonnances'], (item) => Ordonnance.fromMap(item)),
        medications: _convertList<Medicament>(
            map['medications'], (item) => Medicament.fromMap(item)),
        diseases: _convertList<Disease>(
            map['diseases'], (item) => Disease.fromMap(item)),
        allergies: _convertList<Allergie>(
            map['allergies'], (item) => Allergie.fromMap(item)),
        disabilities: _convertList<Disability>(
            map['disabilities'], (item) => Disability.fromMap(item)),
        vaccines: _convertList<Vaccine>(
            map['vaccines'], (item) => Vaccine.fromMap(item)),
        habits:
            _convertList<Habit>(map['habits'], (item) => Habit.fromMap(item)),
        pregnancies: _convertList<Pregnancy>(
            map['pregnancies'], (item) => Pregnancy.fromMap(item)),
        bloodPressure: _convertList<BloodPressure>(
            map['bloodPressure'], (item) => BloodPressure.fromMap(item)),
        heartRate: _convertList<HeartRate>(
            map['heartRate'], (item) => HeartRate.fromMap(item)),
        bodyTemperature: _convertList<Temperature>(
            map['bodyTemperature'], (item) => Temperature.fromMap(item)),
        operations: _convertList<Operation>(
            map['operations'], (item) => Operation.fromMap(item)),
        bloodSugarLevels: _convertList<BloodSugar>(
            map['bloodSugarLevels'], (item) => BloodSugar.fromMap(item)),
        medicalVisits: _convertList<MedicalVisit>(
            map['medicalVisits'], (item) => MedicalVisit.fromMap(item)),
        radios:
            _convertList<Radio>(map['radios'], (item) => Radio.fromMap(item)),
        analyses: _convertList<Analyse>(
            map['analyses'], (item) => Analyse.fromMap(item)),
      );
    } catch (e) {
      // Error handling
      print('Error parsing Patient from map: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'IDN': IDN,
        'familyName': familyName,
        'name': name,
        'gender': gender,
        'birthDate': birthDate,
        'birthPlace': birthPlace,
        'profilePicUrl': profilePicUrl,
        'bio': bio,
        'documentId': documentId,
        'telephone': telephone,
        'email': email,
        'userName': userName,
        'familyMembers': familyMembers,
        'bloodGroup': bloodGroup,
        'visionStatus': visionStatus?.toMap(),
        'heights': heights?.map((height) => height.toMap()).toList(),
        'weights': weights?.map((weight) => weight.toMap()).toList(),
        'ordonnances':
            ordonnances?.map((ordonnance) => ordonnance.toMap()).toList(),
        'medications':
            medications?.map((medication) => medication.toMap()).toList(),
        'diseases': diseases?.map((disease) => disease.toMap()).toList(),
        'allergies': allergies?.map((allergie) => allergie.toMap()).toList(),
        'disabilities':
            disabilities?.map((disability) => disability.toMap()).toList(),
        'vaccines': vaccines?.map((vaccine) => vaccine.toMap()).toList(),
        'habits': habits?.map((habit) => habit.toMap()).toList(),
        'pregnancies':
            pregnancies?.map((pregnancy) => pregnancy.toMap()).toList(),
        'bloodPressure': bloodPressure?.map((bp) => bp.toMap()).toList(),
        'heartRate': heartRate?.map((hr) => hr.toMap()).toList(),
        'bodyTemperature':
            bodyTemperature?.map((temperature) => temperature.toMap()).toList(),
        'operations':
            operations?.map((operation) => operation.toMap()).toList(),
        'bloodSugarLevels':
            bloodSugarLevels?.map((bsl) => bsl.toMap()).toList(),
        'medicalVisits': medicalVisits?.map((visit) => visit.toMap()).toList(),
        'radios': radios?.map((radio) => radio.toMap()).toList(),
        'analyses': analyses?.map((analyse) => analyse.toMap()).toList(),
      };
    } catch (e) {
      // Error handling
      print('Error converting Patient to map: $e');
      rethrow;
    }
  }

  static List<T> _convertList<T>(
      List? list, T Function(Map<String, dynamic>) fromMap) {
    return list
            ?.map((item) => fromMap(item as Map<String, dynamic>))
            .toList() ??
        [];
  }

  static Future<Patient?> fetchPatientData(String userId) async {
    try {
      DocumentSnapshot patientSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (patientSnapshot.exists) {
        Map<String, dynamic>? data =
            patientSnapshot.data() as Map<String, dynamic>?;
        return Patient.fromMap(data ?? {}, patientSnapshot.id);
      } else {
        print('Patient not found');
        return null;
      }
    } catch (e) {
      print('Error fetching patient data: $e');
      return null;
    }
  }

  Future<void> fetchOrdonnances() async {
    try {
      final ordonnancesRef =
          FirebaseFirestore.instance.collection('ordonnances');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      // Get the current date
      DateTime currentDate = DateTime.now();

      // List to store updated ordonnances
      List<Ordonnance> fetchedOrdonnances = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Ordonnance ordonnance = Ordonnance.fromMap(data);

          // Check if the ordonnance is expired
          if (ordonnance.dateOfExpiry!.toDate().isBefore(currentDate)) {
            // Update the status to 'expired'
            ordonnance.status = 'expired';
          } else {
            // Update the status to the opposite of 'expired'
            ordonnance.status =
                'active'; // or whatever the opposite status should be
          }

          // Update Firestore document
          ordonnancesRef.doc(doc.id).update({'status': ordonnance.status});

          // Add the updated ordonnance to the list
          fetchedOrdonnances.add(ordonnance);
        } catch (e) {
          print('Error processing ordonnance: $e');
        }
      });

      // Sort ordonnances by date of filling in descending order
      fetchedOrdonnances
          .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

      print('done fetching orddonaces');
      this.ordonnances = fetchedOrdonnances;
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
  }

  Future<void> fetchFamilyMembers() async {
    try {
      final familyMembersRef = FirebaseFirestore.instance.collection('mineurs');
      QuerySnapshot querySnapshot = await familyMembersRef
          .where('responsableId', isEqualTo: documentId)
          .get();

      // List to store fetched family members
      List<Child> fetchedFamilyMembers = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Child child = Child.fromMap(data);

          // Add the child to the list
          fetchedFamilyMembers.add(child);
        } catch (e) {
          print('Error processing family member: $e');
        }
      });

      // Sort family members by birth date in ascending order (oldest to youngest)
      fetchedFamilyMembers.sort((a, b) => a.birthDate!.compareTo(b.birthDate!));

      print('done fetching family members');
      this.familyMembers = fetchedFamilyMembers;
    } catch (e) {
      print('Error fetching family members: $e');
    }
  }

  Future<void> fetchDiseases() async {
    try {
      final ordonnancesRef = FirebaseFirestore.instance.collection('maladies');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      // // Get the current date
      // DateTime currentDate = DateTime.now();

      // List to store updated ordonnances
      List<Disease> fetchedDiseases = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Disease disease = Disease.fromMap(data);

          // // Check if the ordonnance is expired
          // if (disease.dateOfExpiry!.toDate().isBefore(currentDate)) {
          //   // Update the status to 'expired'
          //   ordonnance.status = 'expired';
          // } else {
          //   // Update the status to the opposite of 'expired'
          //   ordonnance.status =
          //       'active'; // or whatever the opposite status should be
          // }

          // // Update Firestore document
          // ordonnancesRef.doc(doc.id).update({'status': ordonnance.status});

          // Add the updated ordonnance to the list
          fetchedDiseases.add(disease);
        } catch (e) {
          print('Error processing Diseases: $e');
        }
      });

      // Sort ordonnances by date of filling in descending order
      fetchedDiseases.sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

      this.diseases = fetchedDiseases;
    } catch (e) {
      print('Error fetching Diseases: $e');
    }
  }

  Future<void> fetchAllergies() async {
    try {
      final ordonnancesRef = FirebaseFirestore.instance.collection('allergies');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      // // Get the current date
      // DateTime currentDate = DateTime.now();

      // List to store updated ordonnances
      List<Allergie> fetchedAllergies = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Allergie allergie = Allergie.fromMap(data);

          // // Check if the ordonnance is expired
          // if (disease.dateOfExpiry!.toDate().isBefore(currentDate)) {
          //   // Update the status to 'expired'
          //   ordonnance.status = 'expired';
          // } else {
          //   // Update the status to the opposite of 'expired'
          //   ordonnance.status =
          //       'active'; // or whatever the opposite status should be
          // }

          // // Update Firestore document
          // ordonnancesRef.doc(doc.id).update({'status': ordonnance.status});

          // Add the updated ordonnance to the list
          fetchedAllergies.add(allergie);
        } catch (e) {
          print('Error processing Allergies: $e');
        }
      });

      // Sort ordonnances by date of filling in descending order
      fetchedAllergies.sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

      this.allergies = fetchedAllergies;
    } catch (e) {
      print('Error fetching Allergies: $e');
    }
  }

  Future<void> fetchDisabilities() async {
    try {
      final ordonnancesRef =
          FirebaseFirestore.instance.collection('disabilities');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      List<Disability> fetched = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Disability disability = Disability.fromMap(data);

          fetched.add(disability);
        } catch (e) {
          print('Error processing Disabilities: $e');
        }
      });

      // Sort ordonnances by date of filling in descending order
      fetched.sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

      this.disabilities = fetched;
    } catch (e) {
      print('Error fetching Disabilities: $e');
    }
  }

  Future<void> fetchHabits() async {
    try {
      final ordonnancesRef = FirebaseFirestore.instance.collection('habits');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      List<Habit> fetched = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Habit habit = Habit.fromMap(data);

          fetched.add(habit);
        } catch (e) {
          print('Error processing Habits: $e');
        }
      });

      // // Sort ordonnances by date of filling in descending order
      // fetched.sort((a, b) => b.dateOfStart!.compareTo(a.dateOfStart!));

      // print('done fetching orddonaces');
      this.habits = fetched;
    } catch (e) {
      print('Error fetching Habits: $e');
    }
  }

  Future<void> fetchHeights() async {
    try {
      final ordonnancesRef = FirebaseFirestore.instance.collection('heights');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      List<Height> fetched = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Height height = Height.fromMap(data);

          fetched.add(height);
        } catch (e) {
          print('Error processing heights: $e');
        }
      });
      this.heights = fetched;
    } catch (e) {
      print('Error fetching height: $e');
    }
  }

  Future<void> fetchWeights() async {
    try {
      final ordonnancesRef = FirebaseFirestore.instance.collection('weights');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      List<Weight> fetched = [];

      querySnapshot.docs.forEach((doc) {
        try {
          // Access the actual data using data()
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          Weight weight = Weight.fromMap(data);

          fetched.add(weight);
        } catch (e) {
          print('Error processing weights: $e');
        }
      });
      this.weights = fetched;
    } catch (e) {
      print('Error fetching weights: $e');
    }
  }

  Future<void> fetchBloodTypes() async {
    try {
      final ordonnancesRef =
          FirebaseFirestore.instance.collection('bloodTypes');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientId', isEqualTo: documentId).get();

      this.bloodGroup = querySnapshot.docs.first['bloodType'];
    } catch (e) {
      print('Error fetching blood: $e');
    }
  }

  Future<List<String?>> fetchDoctorProfilePicUrls(
      List<String> doctorIDNs) async {
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
