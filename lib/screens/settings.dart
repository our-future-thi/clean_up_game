import 'package:clean_up_game/screens/home.dart';
import 'package:clean_up_game/shared/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    await AuthService().logoutUser();

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const AuthWrapper(child: HomeScreen());
      }),
      (route) => false,
    );
  }

  void login() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const AuthWrapper(child: HomeScreen());
      }),
      (route) => false,
    );
  }

  final Uri _uri = Uri.parse("https://www.ourfuturethi.de/");

  @override
  Widget build(BuildContext context) {
    var headerSize = 16.0;

    var user = AuthService().user;

    Future<void> launchURL() async {
      await launchUrl(_uri, mode: LaunchMode.externalApplication);
    }

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Settings', false, false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Personalization',
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
                  'General',
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
                    child: Icon(Icons.person_rounded),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                            fontSize: headerSize,
                          ),
                        ),
                        Visibility(
                          visible: user != null,
                          child: Text(
                            user?.email?.toString() ?? 'Anonymous',
                            style: TextStyle(
                              fontSize: headerSize - 3,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        user == null ? login() : logout();
                      },
                      icon: const Icon(Icons.login_rounded),
                      label: Text(user == null ? "Log in" : "Log out"),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    launchURL();
                  },
                  child: const Image(
                    image: AssetImage(
                      'ourfuture.png',
                    ),
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
