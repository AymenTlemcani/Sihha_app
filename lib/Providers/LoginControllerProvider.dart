import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/Models/Variables.dart';

class LoginControllerProvider extends ChangeNotifier {
  final StreamController<bool> loginStreamController;

  LoginControllerProvider({
    required this.loginStreamController,
  });
  String? IDN; // Keep the null safety operator on IDN

  String get userId => IDN ?? '';
  void updateUserInformation(
      {required String id,
      required String familyNameProvider,
      required String nameProvider,
      required String genderProvider,
      required int birthDayProvider,
      required int birthMonthProvider,
      required int birthYearProvider,
      required String birthPlaceProvider,
      required bool isAdminProvider,
      required bool isMedcinProvider,
      required bool isPharmacieProvider,
      String? profilePicUrlProvider,
      String? bioProvider}) {
    // Update global variables using the provider variables
    IDN = id;
    familyName = familyNameProvider;
    name = nameProvider;
    gender = genderProvider;
    birthDay = birthDayProvider;
    birthMonth = birthMonthProvider;
    birthYear = birthYearProvider;
    birthPlace = birthPlaceProvider;
    isAdmin = isAdminProvider;
    isMedcin = isMedcinProvider;
    isPharmacie = isPharmacieProvider;
    profilePicUrl = profilePicUrlProvider;
    bio = bioProvider;

    // Notify listeners that user information has been updated
    notifyListeners();
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
  Future<String?> login(
      String id, String password, BuildContext context) async {
    String inputPassword = password.trim();
    Map<String, dynamic>? documentData;

    try {
      var allDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: id.trim())
          // .where('password', isEqualTo: password.trim())
          .get();
      if (allDocs.docs.isEmpty) {
        return 'User not found. Please check your ID and password.';
      }
      documentId = allDocs.docs.first.id;
      documentData = allDocs.docs.first.data();
      if (inputPassword == documentData['password']) {
        // After successful login, update user information
        updateUserInformation(
          id: documentData['IDN'],
          familyNameProvider: documentData['familyName'],
          nameProvider: documentData['name'],
          genderProvider: documentData['gender'],
          birthDayProvider: documentData['birthDay'],
          birthMonthProvider: documentData['birthMonth'],
          birthYearProvider: documentData['birthYear'],
          birthPlaceProvider: documentData['birthPlace'],
          isAdminProvider: documentData['isAdmin'],
          isMedcinProvider: documentData['isMedcin'],
          isPharmacieProvider: documentData['isPharmacien'],
          profilePicUrlProvider: documentData['profilePicUrl'],
          bioProvider: documentData['bio'],
        );

        // Set login status
        Provider.of<LoginControllerProvider>(context, listen: false)
            .loginStreamController
            .add(true);
        // Notify listeners of the change in login status
        notifyListeners();
        print('Login successful. User: ${documentData['name']}');
        return null; // No error message if login is successful
      } else {
        // Incorrect password
        print('Incorrect password for user ID: $id');
        return 'Incorrect password. Please try again.';
      }
    } catch (e) {
      print('Error during login: $e');
      return 'An error occurred. Please try again later.';
    }
  }

  void logout() {
    // Reset user-related variables
    isLoggedIN = false;
    modeAdmin = false;
    modePharmacie = false;
    modeMedcin = false;
    documentId = null;
    IDN = null;
    familyName = null;
    name = null;
    gender = null;
    birthDay = null;
    birthMonth = null;
    birthYear = null;
    birthPlace = null;
    isAdmin = false;
    isMedcin = false;
    isPharmacie = false;
    profilePicUrl = null;
    bio = null;

    // Notify listeners to update UI
    loginStreamController.add(false);
    notifyListeners(); // Notify listeners after updating the state
    print(name);
  }

  @override
  void dispose() {
    // Close the loginStreamController when the provider is disposed of
    loginStreamController.close();
    super.dispose();
  }
}
