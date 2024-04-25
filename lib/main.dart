import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:sahha_app/Models/Variables.dart';
import 'package:sahha_app/Pages/user/AuthPage.dart';
import 'package:sahha_app/Providers/LoginControllerProvider.dart';
import 'package:sahha_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

//   runApp(
//     MultiProvider(
//       providers: [
//         Provider<StreamController<bool>>(
//           create: (_) => StreamController<
//               bool>.broadcast(), // Use broadcast for wider audience
//           dispose: (_, controller) =>
//               controller.close(), // Dispose the controller when done
//         ),
//         // Add more providers if needed
//       ],
//       child: MyApp(),
//     ),
//   );
// }

//3rd try
//   runApp(
//     MultiProvider(
//       providers: [
//         Provider<LoginControllerProvider>(
//           create: (_) => LoginControllerProvider(
//             loginStreamController: StreamController<
//                 bool>.broadcast(), // Initialize loginStreamController
//           ),
//         ),
//         // Add other providers here
//       ],
//       child: MyApp(),
//     ),
//   );
//12th try !!!!!!!!!!!
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginControllerProvider>(
          create: (_) => LoginControllerProvider(
            loginStreamController: StreamController<bool>.broadcast(),
          ),
        ),
        // Add other providers here
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: SihhaGreen1.withOpacity(0.4),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: AuthPage(),
    );
  }
}
