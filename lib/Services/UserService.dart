import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Objects/HealthPlace.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getUserData(String userId) async {
    try {
      // Fetch base user data from the 'users' collection
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        try {
          return User.fromMap(userDoc.data(),
              userDoc.id); // Pass the map to the User.fromMap constructor
        } catch (e) {
          print('Error creating User instance: $e');
          return null; // Return null if there's an error creating the User instance
        }
      } else {
        print('User document does not exist');
        return null; // Return null if the user document doesn't exist
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return null; // Return null if there's an error
    }
  }

  Future<Medcin?> getMedcinData(String userId) async {
    try {
      // Fetch base user data
      User? baseUser = await getUserData(userId);

      if (baseUser != null && baseUser.isMedcin == true) {
        // Fetch additional medcin data from the 'medcins' collection
        DocumentSnapshot<Map<String, dynamic>> medcinDoc =
            await _firestore.collection('medcins').doc(userId).get();

        if (medcinDoc.exists) {
          // Combine base user data and medcin data into a Medcin instance
          return Medcin(
            password: baseUser.password,
            isAdmin: baseUser.isAdmin,
            isMedcin: baseUser.isMedcin,
            isPharmacien: baseUser.isPharmacien,
            adresse: baseUser.adresse,
            IDN: baseUser.IDN,
            familyName: baseUser.familyName,
            name: baseUser.name,
            gender: baseUser.gender,
            birthDate: baseUser.birthDate,
            birthPlace: baseUser.birthPlace,
            profilePicUrl: baseUser.profilePicUrl,
            bio: baseUser.bio,
            documentId: baseUser.documentId,
            telephone: baseUser.telephone,
            email: baseUser.email,
            userName: baseUser.userName,
            familyMembers: baseUser.familyMembers,
            // dossierMedical: baseUser.dossierMedical,
            // Additional properties from medcinDoc.data()!
            professionalPhoneNumber:
                medcinDoc.data()!['professionalPhoneNumber'],
            professionalEmail: medcinDoc.data()!['professionalEmail'],
            digitalSignature: medcinDoc.data()!['digitalSignature'],
            certificates:
                List<String>.from(medcinDoc.data()!['certificates'] ?? []),
            speciality: medcinDoc.data()!['speciality'],
            workPlace: HealthPlace.fromMap(medcinDoc.data()!['workPlace']),
            // patients: (medcinDoc.data()!['patients'] != null)
            //     ? List<Patient>.from(medcinDoc
            //         .data()!['patients']
            //         .map((patient) => Patient.fromMap(patient)))
            //     : null,
            availability: medcinDoc.data()!['availability'],
            education: medcinDoc.data()!['education'],
            experience: medcinDoc.data()!['experience'],
          );
        }
      }
    } catch (e) {
      print('Error retrieving medcin data: $e');
    }

    return null;
  }

  Future<String?> getProfilePicUrl(String userId) async {
    try {
      // Fetch user data from the 'users' collection
      QuerySnapshot<Map<String, dynamic>> userQuerySnapshot = await _firestore
          .collection('users')
          .where('IDN', isEqualTo: userId)
          .limit(1)
          .get();

      // Check if any documents were returned
      if (userQuerySnapshot.docs.isNotEmpty) {
        // Access the data from the first document in the list
        Map<String, dynamic> userData = userQuerySnapshot.docs.first.data();

        // Return the profilePicUrl field from the user data
        return userData['profilePicUrl'] as String?;
      }
    } catch (e) {
      print('Error retrieving profile picture URL: $e');
    }

    return null;
  }

  Future<Map<String, String>> getProfilePicUrls(Set<String> medcinIDNs) async {
    final Map<String, String> profilePicUrls = {};

    // Fetch profile picture URLs for each medcin IDN
    for (final medcinIDN in medcinIDNs) {
      final profilePicUrl = await getProfilePicUrl(medcinIDN);
      if (profilePicUrl != null) {
        profilePicUrls[medcinIDN] = profilePicUrl;
      }
    }

    return profilePicUrls;
  }
}
