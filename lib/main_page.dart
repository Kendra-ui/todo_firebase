
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final create = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return create.user;
    } catch (e) {
      print("Error creating");
    }
    return null;
  }

  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final sign = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return sign.user;
    } catch (e) {
      print("Error signing in");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error");
    }
  }
}
