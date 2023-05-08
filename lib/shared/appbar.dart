import 'package:flutter/material.dart';

import '../screens/settings.dart';

AppBar getAppBar(BuildContext context, String title,
    [bool settingsVisible = true]) {
  return AppBar(
    title: Row(
      children: [
        const Image(
            image: AssetImage(
              'logo.png',
            ),
            height: 30),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    actions: [
      Visibility(
        visible: settingsVisible,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SettingsPage();
                },
              ),
            );
          },
          icon: const Icon(Icons.settings_rounded),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
      ),
    ],
  );
}
