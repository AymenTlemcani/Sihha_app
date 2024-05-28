import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Actors/Medcin.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Services/UserService.dart';

class LoginControllerProvider extends ChangeNotifier {
  final StreamController<bool> loginStreamController;
  final UserService _userService = UserService();
  User? _user;
  Medcin? _medcin;
  LoginControllerProvider({
    required this.loginStreamController,
  });
// Getter methods
  User? get user => _user;
  Medcin? get medcin => _medcin;
  Future<String?> login(
      String id, String password, BuildContext context) async {
    String inputPassword = password.trim();

    try {
      var allDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: id.trim())
          .get();

      var userDoc = allDocs.docs.first;

      if (!userDoc.exists) {
        return 'User not found. Please check your ID and password.';
      }
      documentId = userDoc.id;
      print(documentId);
      // Verify password
      if (inputPassword != userDoc.data()['password']) {
        return 'Incorrect password. Please try again.';
      }

      // Use the UserService to get the user data
      User? loggedInUser = await _userService.getUserData(documentId!);

      if (loggedInUser == null) {
        return 'Error fetchinggg user data.';
      }
// Set the logged-in user
      _user = loggedInUser;
      // Set the global variables
      globalUser = _user;
      globalMedcin = _medcin;
      // Check if the logged-in user is a Medcin
      if (loggedInUser.isMedcin == true) {
        _medcin = await _userService.getMedcinData(documentId!);
        _user = _medcin;
        globalMedcin = _medcin;
      }

      //Fetch data
      await globalUser!.fetchOrdonnances();
      // Extract doctorProfilePicUrls
      List<String> doctorIDNS = [];

      if (globalUser!.ordonnances != null) {
        for (Ordonnance ordonnance in globalUser!.ordonnances!) {
          if (ordonnance.medcin![0].IDN != null) {
            doctorIDNS.add(ordonnance.medcin![0].IDN!);
          }
        }
      }
      Ordonnance ord = Ordonnance();
      doctorProfilePicUrls = await ord.fetchDoctorProfilePicUrls(doctorIDNS);
      // doctorProfilePicUrls
      await globalUser!.fetchDiseases();
      await globalUser!.fetchAllergies();
      await globalUser!.fetchDisabilities();
      await globalUser!.fetchHeights();
      await globalUser!.fetchWeights();
      await globalUser!.fetchBloodTypes();
      await globalUser!.fetchHabits();
      await globalUser!.fetchFamilyMembers();

      // Notify listeners of the change in login status
      loginStreamController.add(true);
      notifyListeners();

      print('Login successful. User: ${loggedInUser.name}');
      return null; // No error message if login is successful
    } catch (e) {
      print('Error during login: $e');

      return e.toString() == 'Bad state: No element'
          ? 'User not found. Please check your ID and password.'
          : 'An error occurred. Please try again later.';
    }
  }

  // ... (other methods)

  void logout() {
    // Reset the logged-in user
    _user = null;
    _medcin = null;
    patients?.clear;
    print('Current number of patients : ${patients?.length}');
    // Reset the global variables
    globalUser = null;
    globalMedcin = null;
    modeAdmin = false;
    modeMedcin = false;
    modePharmacie = false;
    // ModeProvider().offAdmin();
    // ModeProvider().offMedcin();
    // ModeProvider().offPharmacien();
    // Notify listeners to update UI
    loginStreamController.add(false);
    notifyListeners();
  }

  @override
  void dispose() {
    // Close the loginStreamController when the provider is disposed of
    loginStreamController.close();
    super.dispose();
  }
}


















// Future<void> login(String id, String password, BuildContext context) async {
  //   String inputPassword = password.trim();
  //   Map<String, dynamic>? documentData;

  //   try {
  //     var allDocs = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('IDN', isEqualTo: id.trim())
  //         .where('password', isEqualTo: password.trim())
  //         .get();
  //     documentData = allDocs.docs.first.data();
  //     if (inputPassword == documentData['password']) {
  //       // After successful login, update user information
  //       updateUserInformation(
  //         id: documentData['IDN'],
  //         familyNameProvider: documentData['familyName'],
  //         nameProvider: documentData['name'],
  //         genderProvider: documentData['gender'],
  //         birthDayProvider: documentData['birthDay'],
  //         birthMonthProvider: documentData['birthMonth'],
  //         birthYearProvider: documentData['birthYear'],
  //         birthPlaceProvider: documentData['birthPlace'],
  //         isAdminProvider: documentData['isAdmin'],
  //         isMedcinProvider: documentData['isMedcin'],
  //         isPharmacieProvider: documentData['isPharmacien'],
  //       );

  //       // Set login status
  //       Provider.of<LoginControllerProvider>(context, listen: false)
  //           .loginStreamController
  //           .add(true);
  //       // Notify listeners of the change in login status
  //       notifyListeners();
  //     } else {
  //       // Incorrect password
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Incorrect password. Please try again.'),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //   } on Error catch (e) {
  //     print('Error during login: $e');
  //   }
  //   // Print debug information
  //   print('Is logged in : $isLoggedIN');
  //   print('Document data: $documentData');
  // }