import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sahha_app/Common/Variables.dart';
import 'package:sahha_app/Pages/AuthPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            // Colors.white,
            SihhaGreen1.withOpacity(0.4),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light

        //
        //  Color.fromARGB(255, 190, 83, 83)
        // SihhaGreen1.withOpacity(0.2)
        ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   // '/firstpage': (context) => FirstPage(),
      //   // '/homepage': (context) => HomePage(),
      //   // '/settingspage': (context) => SettingsPage(),
      //   '/profilepage': (context) => ProfilePage()
      // },
      theme: ThemeData(useMaterial3: true),
      home: AuthPage(),
    );
  }
}
