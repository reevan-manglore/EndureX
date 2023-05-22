import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page/home_page.dart';
import 'pages/auth_screen/oauth_authentication_screen.dart';
import 'pages/cycling_screen/cycling_screen.dart';
import 'pages/running_screen/running_screen.dart';

import './services/background_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask(
    "first-task",
    "first-task-taskname",
    // frequency: Duration(seconds: 3),
    initialDelay: Duration(seconds: 10),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EndureX',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Color(0xFF01FFD0),
        fontFamily: GoogleFonts.teko().fontFamily,
        scaffoldBackgroundColor: const Color(0xFF0A0320),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF1F1025),
          unselectedItemColor: Color(0x9B01FFD0),
          unselectedIconTheme: IconThemeData(color: Color(0x9B01FFD0)),
          selectedItemColor: Color(0xFF8CFF00),
          selectedIconTheme: IconThemeData(
            color: Color(0xFF8CFF00),
          ),
        ),
      ),
      // theme: myTheme,
      home: const HomePage(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        OauthAutheneticationScreen.routeName: (context) =>
            const OauthAutheneticationScreen(),
        CyclingScreen.routeName: (context) => const CyclingScreen(),
        RunningScreen.routeName: (context) => const RunningScreen(),
      },
    );
  }
}
