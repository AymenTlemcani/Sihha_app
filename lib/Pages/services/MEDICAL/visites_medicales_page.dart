import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahha_app/Models/Variables.dart';

class VisitesMedicalesPage extends StatefulWidget {
  const VisitesMedicalesPage({super.key});

  @override
  State<VisitesMedicalesPage> createState() => _VisitesMedicalesPageState();
}

class _VisitesMedicalesPageState extends State<VisitesMedicalesPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> visits = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadVisits(); // Load visits when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor1,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadVisits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text('Aucune visite trouvée')); // No visits message
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final visit = snapshot.data![index];

              final visitId =
                  index + 1; // Assuming visits are sorted chronologically
              final doctorName = visit['doctorName'] as String;
              final speciality = visit['speciality'] as String;
              final reason = visit['reason'] as String;
              final date = visit['date'] != null
                  ? visit['date'].toDate() as DateTime
                  : null;

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Numéro de la visite: $visitId",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        date != null
                            ? "Date et Heure: ${DateFormat('dd/MM/yyyy HH:mm').format(date)}"
                            : "Date indisponible",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Docteur: $doctorName",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Spécialité: $speciality",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Raison: $reason",
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

  Future<List<Map<String, dynamic>>> _loadVisits() async {
    print('currentID is: $IDN');

    final query = firestore
        .collection('visites_medicales')
        .where('iduser', isEqualTo: IDN);
    final querySnapshot = await query.get();
    final filteredVisits = querySnapshot.docs.map((doc) => doc.data()).toList();

    return filteredVisits;
  }
}
