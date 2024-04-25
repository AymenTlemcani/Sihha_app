import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahha_app/Models/Variables.dart';

class OrdonnancePage extends StatefulWidget {
  const OrdonnancePage({super.key});

  @override
  State<OrdonnancePage> createState() => _OrdonnancePageState();
}

class _OrdonnancePageState extends State<OrdonnancePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<Map<String, dynamic>> prescriptions =
      []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadPrescriptions(); // Load prescriptions when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor1,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadPrescriptions(),
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
                    'Aucune ordonnance trouvée')); // No prescriptions message
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final prescription = snapshot.data![index];

              final doctorName = prescription['doctorName'] as String;
              final speciality = prescription['speciality'] as String;
              final date = prescription['date'] != null
                  ? prescription['date'].toDate() as DateTime
                  : null;
              final text =
                  prescription['text'] as String; // Medication instructions
              final instructions = prescription['instructions'] as String;

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
                      // Medication instructions
                      Text(
                        "Médicaments prescrits :\n $text",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      // Medication instructions
                      Text(
                        "Instructions complémentaires :\n $instructions",
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

  Future<List<Map<String, dynamic>>> _loadPrescriptions() async {
    print('currentID is: $IDN');
//TODO CHange iduser to IDN
    final query =
        firestore.collection('ordonnances').where('iduser', isEqualTo: IDN);
    final querySnapshot = await query.get();
    final filteredPrescriptions =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    // 4. Return the filtered list of prescriptions
    return filteredPrescriptions;
  }
}
