import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project1/Account/signup.dart';
import 'package:project1/Pages/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MainApp(email: email));
}

class MainApp extends StatelessWidget {
  final String? email;
  const MainApp({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email != null ? const HomePage() : const Signup(),
    );
  }
}
