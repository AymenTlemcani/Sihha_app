import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahha_app/Models/Objects/Ordonnance.dart';

class OrdonnancesService {
  static final OrdonnancesService _instance = OrdonnancesService._internal();
  factory OrdonnancesService() => _instance;
  OrdonnancesService._internal();

  List<Ordonnance>? _ordonnances;

  Future<void> fetchAndProcessOrdonnances(String userId) async {
    try {
      final ordonnancesRef =
          FirebaseFirestore.instance.collection('ordonnances');
      QuerySnapshot querySnapshot =
          await ordonnancesRef.where('patientIDN', isEqualTo: userId).get();

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
          ordonnance.status = 'active';
        }

        // Update Firestore document
        ordonnancesRef.doc(doc.id).update({'status': ordonnance.status});

        // Add the updated ordonnance to the list
        fetchedOrdonnances.add(ordonnance);
      });

      // Sort ordonnances by date of creation in descending order
      fetchedOrdonnances
          .sort((a, b) => b.dateOfFilling!.compareTo(a.dateOfFilling!));

      // Update the local state with fetched ordonnances
      _ordonnances = fetchedOrdonnances;
    } catch (e) {
      print('Error fetching ordonnances: $e');
    }
  }

  List<Ordonnance>? get ordonnances => _ordonnances;
}
