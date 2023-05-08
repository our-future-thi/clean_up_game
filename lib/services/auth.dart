import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final userStream = FirebaseAuth.instance.authStateChanges();
  static final user = FirebaseAuth.instance.currentUser;

  static Future loginUser(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> loginMicrosoft() async {
    var provider = OAuthProvider('microsoft.com');
    await FirebaseAuth.instance.signInWithPopup(provider);
  }

  static Future loginAnon() async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
