import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/pages/auth/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  void logout() async {
await FirebaseAuth.instance.signOut();
  Navigator.popUntil(context, (route) => route.isFirst);

    Navigator.pushReplacement(context, CupertinoPageRoute(
      
      builder: (context) =>LoginPage()
      ));
  }

  void saveData() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      FirebaseFirestore.instance.collection("details").add(userData).then((_) {
        log("User Created");
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data saved successfully!")),
        );
      }).catchError((error) {
        log("Error saving data: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error saving data!")),
        );
      });
    } else {
      log("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  void updateData(String docId) {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      Map<String, dynamic> updatedData = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      FirebaseFirestore.instance
          .collection("details")
          .doc(docId)
          .update(updatedData)
          .then((_) {
        log("User Updated");
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data updated successfully!")),
        );
      }).catchError((error) {
        log("Error updating data: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error updating data!")),
        );
      });
    } else {
      log("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  void deleteData(String docId) {
    FirebaseFirestore.instance.collection("details").doc(docId).delete().then((_) {
      log("User Deleted");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data deleted successfully!")),
      );
    }).catchError((error) {
      log("Error deleting data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error deleting data!")),
      );
    });
  }

  void showDeleteConfirmationDialog(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                deleteData(docId);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(String docId, Map<String, dynamic> userData) {
    nameController.text = userData["name"];
    emailController.text = userData["email"];
    phoneController.text = userData["phone"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                updateData(docId);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _formFields(),
    );
  }

  Padding _formFields() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saveData,
              child: const Text("Submit"),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("details").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userMap =
                            snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        String docId = snapshot.data!.docs[index].id;

                        return ListTile(
                          title: Text(userMap["name"] ?? "No Name"),
                          subtitle: Text(
                              "${userMap["email"] ?? "No Email"} || ${userMap["phone"] ?? "No Phone"}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showEditDialog(docId, userMap);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDeleteConfirmationDialog(docId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("No data!");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      
      title: const Text(
        "CRUD Operation",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 20, 1, 72),
      actions: [
        IconButton(
          onPressed: () {
         logout();
          },
          icon: Icon(Icons.exit_to_app),
        )
      ],
    );
  }
}
