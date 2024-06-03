import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Account/signin.dart';
import 'package:project1/Pages/TodoCard.dart';
import 'package:project1/Pages/ViewData.dart';
import 'package:project1/Pages/addTask.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final auth = FirebaseAuth.instance;

//displayiing task for a particular user
  Stream<QuerySnapshot> getTaskStream() {
    User? user = auth.currentUser;
    return FirebaseFirestore.instance
        .collection('Todo')
        .where('userId', isEqualTo: user?.uid)
        .snapshots();
  }

  List<Select> selected = [];

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const SignIn()),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Padding(
          padding: EdgeInsets.only(right: 45.0),
          child: Text(
            "Today Schedule",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Friday 31",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: signOut,
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: getTaskStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var document = snapshot.data?.docs[index];
                          selected.add(Select(
                              check: false, id: snapshot.data!.docs[index].id));
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => ViewData(
                                  document:
                                      document?.data() as Map<String, dynamic>,
                                  id: document?.id ?? '',
                                ),
                              ),
                            ),
                            child: Todocard(
                              title: document?['title'] ?? '',
                              iconData: Icons.alarm,
                              iconColor: Colors.blue,
                              time: '',
                              check: selected[index].check,
                              iconBgColor: Colors.white,
                              onChanged: onChanged,
                              index: index,
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }

  void onChanged(int index) {
    setState(() {
      selected[index].check = !selected[index].check;
    });
  }
}

class Select {
  String id;
  bool check = false;
  Select({required this.check, required this.id});
}
