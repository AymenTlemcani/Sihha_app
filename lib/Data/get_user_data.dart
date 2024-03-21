import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class getUserData extends StatelessWidget {
  final String DocumentID;
  final String fieldName;
  const getUserData(
      {super.key, required this.DocumentID, required this.fieldName});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(DocumentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> DATA =
              snapshot.data!.data() as Map<String, dynamic>;
          return DATA[fieldName];
          // Text("${DATA[fieldName]}");
        }
        return CupertinoActivityIndicator();
      },
    );
  }
}
