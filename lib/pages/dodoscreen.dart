

import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
        ),
centerTitle: true,
backgroundColor: const Color.fromARGB(255, 54, 3, 172),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                "Add Todo",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,   
                ),
              ),
              const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
               const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Discription",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20,),
        SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: (){
                
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 217, 131, 10),
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                
                ),
            
              child: const Text(
                "Add Todo"
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}