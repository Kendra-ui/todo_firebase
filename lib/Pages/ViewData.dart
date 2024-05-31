import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Pages/homePage.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key, required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController titleController;
  late TextEditingController _taskController;
  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document['title'] ?? '';
    String description = widget.document['description'] ?? '';
    titleController = TextEditingController(text: title);
    _taskController = TextEditingController(text: description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Container(
        constraints: const BoxConstraints(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const HomePage())),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    edit ? "Edit your task" : "View your task",
                    style: const TextStyle(
                        letterSpacing: 2,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            color: edit ? Colors.green : Colors.white,
                          )),
                      GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('Todo')
                                .doc(widget.id)
                                .delete()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Icon(Icons.delete, color: Colors.red)),
                    ],
                  ),
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
                height: 20,
              ),
              edit ? button() : Container(),
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
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: titleController,
          enabled: edit,
          decoration: const InputDecoration(
            hintText: "title",
            hintStyle: TextStyle(color: Colors.black),
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
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          controller: _taskController,
          enabled: edit,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Description",
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
        onTap: () {
          FirebaseFirestore.instance.collection('Todo').doc(widget.id).update({
            'title': titleController.text.trim(),
            'description': _taskController.text.trim(),
          }).then((_) {
            print('Task updated successfully');
          }).catchError((error) {
            print('Failed to update task: $error');
          });
          Navigator.pop(context);
        },
        child: Container(
            height: 56,
            width: MediaQuery.of(context).size.width - 80,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Color(0xff8a32f1), Color(0xffad32f9)])),
            child: const Center(
              child: Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
