import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';

class Patient {
  String? IDN;
  String? familyName;
  String? name;
  String? gender;
  int? birthDay;
  int? birthMonth;
  int? birthYear;
  String? birthPlace;
  String? profilePicUrl;
  String? bio;
  String? documentId;
  String? telephone;
  String? bloodType;
  double? weight;
  double? height;
  List<Ordonnance>? ordonnances;
  List<String>? family;
  List<String>? radios;
  List<String>? analyses;

  Patient({
    this.IDN,
    this.familyName,
    this.name,
    this.gender,
    this.birthDay,
    this.birthMonth,
    this.birthYear,
    this.birthPlace,
    this.profilePicUrl,
    this.bio,
    this.documentId,
    this.telephone,
    this.bloodType,
    this.height,
    this.weight,
    this.ordonnances,
    this.family,
    this.radios,
    this.analyses,
  });

  void updateIDN(String newIDN) {
    IDN = newIDN;
  }

  void updateFamilyName(String newFamilyName) {
    familyName = newFamilyName;
  }

  void updateName(String newName) {
    name = newName;
  }

  void updateGender(String newGender) {
    gender = newGender;
  }

  void updateBirthday(int newBirthDay, int newBirthMonth, int newBirthYear) {
    birthDay = newBirthDay;
    birthMonth = newBirthMonth;
    birthYear = newBirthYear;
  }

  void updateBirthPlace(String newBirthPlace) {
    birthPlace = newBirthPlace;
  }

  void updateProfilePicUrl(String newProfilePicUrl) {
    profilePicUrl = newProfilePicUrl;
  }

  void updateBio(String newBio) {
    bio = newBio;
  }

  void updateDocumentId(String? newDocumentId) {
    documentId = newDocumentId;
  }

  void updateTelephone(String newTelephone) {
    telephone = newTelephone;
  }

  void updateBloodType(String newBloodType) {
    bloodType = newBloodType;
  }

  void updateWeight(double newWeight) {
    weight = newWeight;
  }

  void updateHeight(double newHeight) {
    height = newHeight;
  }

  void updateOrdonnances(List<Ordonnance> newOrdonnances) {
    ordonnances = newOrdonnances;
  }

  void updateFamily(List<String> newFamily) {
    family = newFamily;
  }

  void updateRadios(List<String> newRadios) {
    radios = newRadios;
  }

  void updateAnalyses(List<String> newAnalyses) {
    analyses = newAnalyses;
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
        return Patient(
          IDN: data?['IDN'],
          familyName: data?['familyName'],
          name: data?['name'],
          gender: data?['gender'],
          birthDay: data?['birthDay'],
          birthMonth: data?['birthMonth'],
          birthYear: data?['birthYear'],
          birthPlace: data?['birthPlace'],
          profilePicUrl: data?['profilePicUrl'],
          bio: data?['bio'],
          documentId: patientSnapshot.id,
          telephone: data?['telephone'],
          bloodType: data?['bloodType'],
          weight: data?['weight'],
          height: data?['height'],
          // Add logic to fetch other related data like ordonnances, family, radios, analyses
        );
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
          await ordonnancesRef.where('patientIDN', isEqualTo: IDN).get();

      // Get the current date
      DateTime currentDate = DateTime.now();

      // List to store updated ordonnances
      List<Ordonnance> fetchedOrdonnances = [];

      querySnapshot.docs.forEach((doc) {
        Ordonnance ordonnance = Ordonnance.fromFirestore(doc);

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
      });

      // Update the local state with fetched ordonnances
      updateOrdonnances(fetchedOrdonnances);
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
  }

  // Future<void> fetchOrdonnances() async {
  //   try {
  //     final ordonnancesRef =
  //         FirebaseFirestore.instance.collection('ordonnances');
  //     QuerySnapshot querySnapshot =
  //         await ordonnancesRef.where('patientIDN', isEqualTo: IDN).get();
  //     print('zzzzzzzzzzzzzzzzzzzz');
  //     print(querySnapshot.docs
  //         .map((doc) => Ordonnance.fromFirestore(doc))
  //         .toList());
  //     List<Ordonnance> fetchedOrdonnances = querySnapshot.docs
  //         .map((doc) => Ordonnance.fromFirestore(doc))
  //         .toList();
  //     // updatePatientInformation(
  //     //     ordonnances: querySnapshot.docs
  //     //         .map((doc) => Ordonnance.fromFirestore(doc))
  //     //         .toList());
  //     updateOrdonnances(fetchedOrdonnances);
  //   } catch (e) {
  //     print('Error fetchiiiiing ordonnances: $e');
  //   }
  // }
}
