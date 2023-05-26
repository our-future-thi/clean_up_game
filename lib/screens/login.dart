import 'dart:math';

import 'package:clean_up_game/screens/utils/sign_in_button.dart';
import 'package:clean_up_game/services/auth.dart';
import 'package:clean_up_game/services/config.dart';
import 'package:flutter/material.dart';

import '../shared/appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  final maxWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context, 'Login'),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Stack(
            children: [
              Positioned.fill(
                top: min(MediaQuery.of(context).size.width / 2, maxWidth / 2),
                child: Container(
                  color: HSLColor.fromColor(
                          Theme.of(context).colorScheme.background)
                      .withLightness(themeNotifier.isDark ? 0.07 : 0.9)
                      .withSaturation(themeNotifier.isDark ? 0 : 0.2)
                      .toColor(),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // gradient from white to blue
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                          ),
                          child: Image.asset(
                            'cleanup.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
