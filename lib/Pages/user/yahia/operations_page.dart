import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';

class OperationsPage extends StatefulWidget {
  const OperationsPage({super.key});

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<Map<String, dynamic>> operations =
      []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadOprations(); // Load prescriptions when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor1,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadOprations(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                    'Aucune operations trouvée')); // No prescriptions message
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final operations = snapshot.data![index];

              final doctorName = operations['doctorName'] as String;
              final speciality = operations['speciality'] as String;
              final date = operations['date'] != null
                  ? operations['date'].toDate() as DateTime
                  : null;
              final description = operations['description']
                  as String; // Medication instructions
              final lieu = operations['lieu'] as String;
              final typeOperation = operations['typeOperation'] as String;

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor name and speciality
                      Text(
                        "Dr. $doctorName - $speciality",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      // Date (if available)
                      date != null
                          ? Text(
                              "Date: ${DateFormat('dd/MM/yyyy').format(date)}",
                              style: TextStyle(fontSize: 16),
                            )
                          : SizedBox(),
                      SizedBox(height: 10),
                      Text(
                        "Lieu : $lieu",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Type d'operation : $typeOperation",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      // Medication instructions
                      Text(
                        "Description :\n $description",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadOprations() async {
    // 1. Get the current user ID from the LoginControllerProvider
    final loginControllerProvider =
        Provider.of<LoginControllerProvider>(context, listen: false);
    final currentUserID = loginControllerProvider.userId;

    print('currentID is: $currentUserID');

    final query = firestore
        .collection('operations')
        .where('iduser', isEqualTo: currentUserID);
    final querySnapshot = await query.get();
    final filteredOperations =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    // 4. Return the filtered list of prescriptions
    return filteredOperations;
  }
}
