import 'package:clean_up_game/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../shared/appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SocialLoginButton(
                  onPressed: () async {
                    await AuthService().loginGoogle();
                  },
                  buttonType: SocialLoginButtonType.google,
                ),
                const SizedBox(height: 8),
                SocialLoginButton(
                  onPressed: () async {
                    await AuthService().loginMicrosoft();
                  },
                  buttonType: SocialLoginButtonType.microsoft,
                ),
                const SizedBox(height: 8),
                SocialLoginButton(
                  onPressed: () async {
                    await AuthService().loginGithub();
                  },
                  buttonType: SocialLoginButtonType.github,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
