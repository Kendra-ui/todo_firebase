import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential create = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return create.user;
    } catch (e) {
      print("Error creating user: $e");
    }
    return null;
  }

  Future<User?> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final sign = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await storeUser(sign.user);
      return sign.user;
    } catch (e) {
      print("Error signing in");
    }
    return null;
  }

  Future<void> storeUser(User? user) async {
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove('email');
      await storage.delete(key: 'token');
      await storage.delete(key: 'user');
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
