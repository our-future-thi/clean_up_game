import 'package:clean_up_game/screens/home.dart';
import 'package:clean_up_game/screens/login.dart';
import 'package:clean_up_game/shared/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
import '../services/config.dart';
import '../shared/appbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> logout() async {
    await AuthService.logoutUser();

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const AuthWrapper(child: HomeScreen());
      }),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var headerSize = 16.0;

    var user = AuthService.user;

    return Scaffold(
      appBar: getAppBar(context, 'Einstellungen', false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Personalisierung',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.color_lens_rounded),
                ),
                Expanded(
                  child: Text('Dark Mode',
                      style: TextStyle(
                        fontSize: headerSize,
                      )),
                ),
                Switch(
                  value: themeNotifier.isDark,
                  onChanged: (value) async {
                    setState(() {
                      themeNotifier.setTheme(value);
                    });

                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('theme', themeNotifier.isDark);
                  },
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Allgemein',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: user == null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.person_rounded),
                  ),
                  Expanded(
                    child: Text('Mitgliederbereich',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AuthWrapper(child: LoginScreen());
                        }));
                      },
                      icon: const Icon(Icons.login_rounded),
                      label: const Text("Anmelden"),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: user != null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.games_rounded),
                  ),
                  Expanded(
                    child: Text('Spieleinstellungen',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const EditScoresProvider();
                        // }));
                      },
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text("Punkte eintragen"),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            Visibility(
              visible: user != null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.person_rounded),
                  ),
                  Expanded(
                    child: Text('Mitgliederbereich',
                        style: TextStyle(
                          fontSize: headerSize,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          logout();
                        });
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text("Abmelden"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
