import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future loginUser(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> loginMicrosoft() async {
    var provider = OAuthProvider('microsoft.com');
    await FirebaseAuth.instance.signInWithPopup(provider);
  }

  Future loginAnon() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
