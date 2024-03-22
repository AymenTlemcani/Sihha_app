import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/Common/Variables.dart';

class LoginControllerProvider extends ChangeNotifier {
  final StreamController<bool> loginStreamController;

  LoginControllerProvider({
    required this.loginStreamController,
  });

  void updateUserInformation({
    required String id,
    required String familyNameProvider,
    required String nameProvider,
    required String sexeProvider,
    required int birthDayProvider,
    required int birthMonthProvider,
    required int birthYearProvider,
    required String birthPlaceProvider,
    required bool isAdminProvider,
    required bool isMedcinProvider,
    required bool isPharmacieProvider,
  }) {
    // Update global variables using the provider variables
    IDN = id;
    familyName = familyNameProvider;
    name = nameProvider;
    sexe = sexeProvider;
    birthDay = birthDayProvider;
    birthMonth = birthMonthProvider;
    birthYear = birthYearProvider;
    birthPlace = birthPlaceProvider;
    isAdmin = isAdminProvider;
    isMedcin = isMedcinProvider;
    isPharmacie = isPharmacieProvider;

    // Notify listeners that user information has been updated
    notifyListeners();
  }

  Future<void> login(String id, String password, BuildContext context) async {
    String inputPassword = password.trim();
    Map<String, dynamic>? documentData;

    try {
      var allDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: id.trim())
          .where('password', isEqualTo: password.trim())
          .get();
      documentData = allDocs.docs.first.data();
      if (inputPassword == documentData['password']) {
        // After successful login, update user information
        updateUserInformation(
          id: documentData['IDN'],
          familyNameProvider: documentData['familyName'],
          nameProvider: documentData['name'],
          sexeProvider: documentData['sexe'],
          birthDayProvider: documentData['birthDay'],
          birthMonthProvider: documentData['birthMonth'],
          birthYearProvider: documentData['birthYear'],
          birthPlaceProvider: documentData['birthPlace'],
          isAdminProvider: documentData['admin'],
          isMedcinProvider: documentData['medcin'],
          isPharmacieProvider: documentData['pharmacien'],
        );

        // Set login status
        Provider.of<LoginControllerProvider>(context, listen: false)
            .loginStreamController
            .add(true);
        // Notify listeners of the change in login status
        notifyListeners();
      } else {
        // Incorrect password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect password. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on Error catch (e) {
      print('Error during login: $e');
    }
    // Print debug information
    print('Is logged in : $isLoggedIN');
    print('Document data: $documentData');
  }

  void logout() {
    // Reset user-related variables
    isLoggedIN = false;
    modeAdmin = false;
    IDN = null;
    familyName = null;
    name = null;
    sexe = null;
    birthDay = null;
    birthMonth = null;
    birthYear = null;
    birthPlace = null;
    isAdmin = false;
    isMedcin = false;
    isPharmacie = false;

    // Notify listeners to update UI
    loginStreamController.add(false);
    notifyListeners(); // Notify listeners after updating the state
    print(name);
  }
}
