import 'package:clean_up_game/screens/utils/sign_in_button.dart';
import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';

import '../shared/appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Login'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SignInButton(
                    provider: 'Anonymously',
                    onPressed: () async {
                      // open dialog to warn user about data loss
                      var accept = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text(
                            'You are about to sign in anonymously. This means that your data will be lost when you log out or your session expires. Do you want to continue?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Continue'),
                            ),
                          ],
                        ),
                      );

                      if (accept) {
                        await AuthService().loginAnon();
                      }
                    },
                    prefix: 'Sign in',
                    icon: Icons.lock_rounded,
                  ),
                  const SizedBox(height: 8),
                  SignInButton(
                    img: 'google.svg',
                    provider: 'Google',
                    onPressed: () async {
                      await AuthService().loginGoogle();
                    },
                  ),
                  const SizedBox(height: 8),
                  SignInButton(
                    img: 'microsoft.svg',
                    provider: 'Microsoft',
                    onPressed: () async {
                      await AuthService().loginMicrosoft();
                    },
                  ),
                  const SizedBox(height: 8),
                  SignInButton(
                    img: 'github.svg',
                    provider: 'Github',
                    onPressed: () async {
                      await AuthService().loginGithub();
                    },
                    invert: true,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
