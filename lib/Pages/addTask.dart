import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Account/signin.dart';

class Addtask extends StatefulWidget {
  const Addtask({super.key});

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final _taskController = TextEditingController();
  final titleController = TextEditingController();
  int _selectedIndex =
      1; // To highlight the "Add" button in the bottom navigation

  Future<void> addTask() async {
    // Get the current user ID

    // Add task to Firestore under the user's collection
    await FirebaseFirestore.instance.collection('Todo').add({
      'title': titleController.text.trim(),
      'description': _taskController.text.trim(),
    }).then((_) {
      print('Task added successfully');
    }).catchError((error) {
      print('Failed to add task: $error');
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pop(context); // Go back to the previous page
    }
    // You can handle other index cases here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const Addtask()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purple])),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Add',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
      ),
      body: Container(
        constraints: const BoxConstraints(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create your task",
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignIn())),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Task title",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  title(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Task Description",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  description()
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      alignment: Alignment.center,
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "title",
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: _taskController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
