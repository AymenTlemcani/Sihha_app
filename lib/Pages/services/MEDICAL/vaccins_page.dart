import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahha_app/Models/Variables.dart';

class VaccinsPage extends StatefulWidget {
  const VaccinsPage({super.key});

  @override
  State<VaccinsPage> createState() => _VaccinsPageState();
}

class _VaccinsPageState extends State<VaccinsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> vaccins = [];
  // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    _loadVaccins(); // Load prescriptions when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SihhaGreyBackgroundColor1,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadVaccins(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun vaccin trouvé'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final vaccins = snapshot.data![index];
              final date = vaccins['date'] != null
                  ? vaccins['date'].toDate() as DateTime
                  : null;
              final lieu = vaccins['lieu'] as String;
              final typeVaccin = vaccins['type'] as String;

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date (if available)
                      date != null
                          ? Text(
                              "Date d'administration : ${DateFormat('dd/MM/yyyy').format(date)}",
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
                        "Vaccin : $typeVaccin",
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

  Future<List<Map<String, dynamic>>> _loadVaccins() async {
    print('currentID is: $IDN');

    final query =
        firestore.collection('vaccins').where('iduser', isEqualTo: IDN);
    final querySnapshot = await query.get();
    final filteredVaccins =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    // 4. Return the filtered list of prescriptions
    return filteredVaccins;
  }
}
