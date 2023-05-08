import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../screens/login.dart';
import '../services/firestore.dart';

class AuthWrapper extends StatefulWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snapshot) => FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : StreamProvider<List<Log>>(
              create: (_) => FirestoreService().getLogsFromPlayer(
                  FirebaseAuth.instance.currentUser?.uid ?? ''),
              initialData: List<Log>.empty(),
              catchError: (context, error) {
                return List<Log>.empty();
              },
              child: widget.child,
            ),
    );
  }
}
