// Create a separate service or class to fetch and process data
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsService {
  static final StatisticsService _instance = StatisticsService._internal();
  factory StatisticsService() => _instance;
  StatisticsService._internal();

  Map<String, int>? _userData;

  Future<void> fetchAndProcessUserData() async {
    _userData = await fetchNumbers();
  }

  Future<Map<String, int>> fetchNumbers() async {
    int totalUsersCount = 0;
    int medcinCount = 0;
    int adminCount = 0;
    int pharmacienCount = 0;
    int normalCount = 0;
    int maleCount = 0;
    int femaleCount = 0;
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      querySnapshot.docs.forEach(
        (doc) {
          totalUsersCount++;

          // Check if the document exists and has data
          if (doc.exists) {
            var data = doc.data() as Map<String,
                dynamic>?; // Cast to Map<String, dynamic> or Map<String, Object>
            if (data != null) {
              if (data['isMedcin'] == true) {
                medcinCount++;
              }
              if (data['isAdmin'] == true) {
                adminCount++;
              }
              if (data['isPharmacien'] == true) {
                pharmacienCount++;
              }
              if (data['gender'] == 'male') {
                maleCount++;
              } else
                femaleCount++;
              if (data['isMedcin'] != true &&
                  data['isAdmin'] != true &&
                  data['isPharmacien'] != true) {
                normalCount++;
              }
            }
          }
        },
      );

      return {
        'totalUsersCount': totalUsersCount,
        'isAdmin': adminCount,
        'isMedcin': medcinCount,
        'isPharmacien': pharmacienCount,
        'normalCount': normalCount,
        'maleCount': maleCount,
        'femaleCount': femaleCount,
      };
    } catch (e) {
      print(e);
      return {
        'totalUsersCount': 0,
        'isAdmin': 0,
        'isMedcin': 0,
        'isPharmacien': 0,
        'normalCount': 0,
        'maleCount': 0,
        'femaleCount': 0,
      };
    }
  }

  Map<String, int>? get userData => _userData;
}
