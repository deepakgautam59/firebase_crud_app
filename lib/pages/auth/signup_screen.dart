

// ignore_for_file: unused_local_variable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newapp/pages/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController cpasswordController=TextEditingController();

Future<void> createAccount() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String cpassword = cpasswordController.text.trim();

  if (email.isEmpty || password.isEmpty || cpassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: Please fill All Details'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 81),
      ),
    );
    return;
  } else if (password != cpassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Confirm Password Not Match'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 81),
      ),
    );
    return;
  }

  try {
    // Create New Account
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
      

    print("User Created");
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account Created Successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    emailController.clear();
    passwordController.clear();
    cpasswordController.clear();

       Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  } catch (e) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error creating account: $e'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 81),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
   body: Center(
     child: SingleChildScrollView(
       child: Column(
         
         children: [
          SizedBox(height: 50,),
          const Text(
          "Welcome To You !",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          ),
           
           Padding(
           padding: EdgeInsets.only(left: 25,right: 25),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
          ),
          
          Padding(
         padding: const EdgeInsets.only(left: 25,right: 25),
            child: TextField(
              controller: passwordController,
            
              decoration: const InputDecoration(
                labelText: 'password',
                
              ),
            ),
            
          ),
          Padding(
         padding: const EdgeInsets.only(left: 25,right: 25),
            child: TextField(
              controller: cpasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm password'
              ),
            ),
          ),
          
            SizedBox(height: 30,),
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: (){
                createAccount();
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                
                ),
            
              child: const Text(
                "Signup"
              ),
            ),
          ),
          SizedBox(height: 30,),
          RichText(
            text: TextSpan(
              text: "Already have account?",
              style: TextStyle(color: const Color.fromARGB(255, 3, 7, 28), fontSize: 16),
               children: [
                    TextSpan(
                      text: "Login here",
                      style: TextStyle(
                        color: Colors.blue, // Link color
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline, // Underline the text
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Action to perform on tap
                           Navigator.push(
       context,
       PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
       ),
     );
                        },
                    ),
                  ],
       
            ),
          )
         ],
         
       ),
     ),
   ),

    );
  }

  AppBar _appBar() {
    return AppBar(
    backgroundColor: const Color.fromARGB(255, 1, 38, 130),
    centerTitle: true,
      title: const Text(
        "Register Here",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,

        ),
      ),
    );
  }
}