import 'package:clean_up_game/screens/home.dart';
import 'package:clean_up_game/services/config.dart';
import 'package:clean_up_game/shared/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(() {
      setState(() {});
    });

    loadThemePref();
  }

  void loadThemePref() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getBool('theme') ?? false;
    themeNotifier.setTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanUp Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 155, 177, 65),
        useMaterial3: true,
        brightness: themeNotifier.currentTheme(),
      ),
      home: const AuthWrapper(
        child: HomeScreen(),
      ),
    );
  }
}
