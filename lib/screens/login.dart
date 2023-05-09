import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';

import '../shared/appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, 'Login'),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => AuthService().loginMicrosoft(),
          icon: const Icon(Icons.login),
          label: const Text('Login'),
        ),
      ),
    );
  }
}
