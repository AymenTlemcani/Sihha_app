import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addFieldToAllDocuments() async {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('users');

  // Fetch all documents from the collection

  final QuerySnapshot querySnapshot =
      await collectionRef.where('isMedcin', isEqualTo: true).get();

  // Iterate over each document
  for (DocumentSnapshot doc in querySnapshot.docs) {
    // Get the document ID
    final String docId = doc.id;

    // Update the document with the new field
    await collectionRef.doc(docId).update({
      'speciality': 'généraliste',
      'clinicName': 'el-Azhar',
      'digitalSignature': null
    });
  }

  print('Field added to all documents successfully');
}
