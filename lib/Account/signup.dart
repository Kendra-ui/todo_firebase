// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:project1/Account/signin.dart';
import 'package:project1/Pages/addTask.dart';
import 'package:project1/main_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = Auth();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              const Text(
                "Create your account",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15,
                    child: TextField(
                      controller: _fullnameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        filled: true,
                        fillColor: Color.fromARGB(255, 226, 207, 247),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15,
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: Color.fromARGB(255, 226, 207, 247),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15,
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Color.fromARGB(255, 226, 207, 247),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  )),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              ElevatedButton(
                  onPressed: () async {
                    final user = await _auth.createUserWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                    if (user != null) {
                      print("User created successfully");
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Addtask()));
                    }
                  },
                  child: const Text('Sign Up')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const SignIn()));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
