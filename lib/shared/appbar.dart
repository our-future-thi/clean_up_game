import 'package:clean_up_game/screens/utils/admin_wrapper.dart';
import 'package:flutter/material.dart';

import '../screens/settings.dart';

AppBar getAppBar(BuildContext context, String title,
    [bool adminSettingsVisible = false, bool settingsVisible = true]) {
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
        visible: adminSettingsVisible,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AdminWrapper();
                },
              ),
            );
          },
          icon: const Icon(Icons.admin_panel_settings_rounded),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(5),
      ),
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
