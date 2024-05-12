import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Actors/User.dart';
import 'package:sahha_app/Models/Variables.dart'; // Import User model

class LoginControllerProvider extends ChangeNotifier {
  final StreamController<bool> loginStreamController;

  LoginControllerProvider({
    required this.loginStreamController,
  });

  Future<String?> login(
      String id, String password, BuildContext context) async {
    String inputPassword = password.trim();

    try {
      var allDocs = await FirebaseFirestore.instance
          .collection('users')
          .where('IDN', isEqualTo: id.trim())
          // .where('password', isEqualTo: password.trim())
          .get();

      var userDoc = allDocs.docs.first;

      if (!userDoc.exists) {
        return 'User not found. Please check your ID and password.';
      }
      documentId = userDoc.id;

      // Construct a User object from Firestore data
      User loggedInUser = User.fromJson(userDoc.data());

      // Verify password
      if (inputPassword != loggedInUser.password) {
        return 'Incorrect password. Please try again.';
      }

      // Set the logged-in user
      user = loggedInUser;
      user?.updateDocumentId(documentId);

      // Notify listeners of the change in login status
      loginStreamController.add(true);
      // Provider.of<LoginControllerProvider>(context, listen: false)
      //     .loginStreamController
      //     .add(true);
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

  void logout() {
    // Reset the logged-in user
    user = null;
    patients?.clear;
    print('Current number of patients : ${patients?.length}');

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