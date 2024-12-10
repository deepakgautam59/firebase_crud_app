
// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:newapp/pages/auth/signup_screen.dart';
import 'package:newapp/pages/homescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
void login() async{
String email = emailController.text.trim();
String password = passwordController.text.trim();
if(email.isEmpty || password.isEmpty){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please Fill All The Fields'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 81),
      ),
    );
    return;
}
else{
  // ignore: non_constant_identifier_names
 try
 {
   UserCredential userCredential = await FirebaseAuth.instance.
  signInWithEmailAndPassword(email: email, password: password);
  if(userCredential.user !=null){
  Navigator.popUntil(context, (route) => route.isFirst);

    Navigator.pushReplacement(context, CupertinoPageRoute(
      
      builder: (context) =>HomePage()
      ));

    emailController.clear();
    passwordController.clear();
    
  }
 }on FirebaseAuthException catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error creating account: $e'),
        backgroundColor: const Color.fromARGB(255, 255, 0, 81),
      ),
    );
 }
}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
   body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
     children: [
      const Text(
      "Welcome Back !",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email'
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'password'
          ),
        ),
      ),
         SizedBox(
          width: 350,
          child: ElevatedButton(
            onPressed: (){
              login();
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
              "Login"
            ),
          ),
        ),
      SizedBox(height: 30,),
      RichText(
        text: TextSpan(
          text: "Not have any account? ",
          style: TextStyle(color: const Color.fromARGB(255, 3, 7, 28), fontSize: 16),
           children: [
                TextSpan(
                  text: "Create here",
                  style: TextStyle(
                    color: Colors.blue, // Link color
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Underline the text
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                       Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
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

    );
  }

  AppBar _appBar() {
    return AppBar(
    backgroundColor: const Color.fromARGB(255, 1, 38, 130),
    automaticallyImplyLeading: false,
    centerTitle: true,
      title: const Text(
        "login Now",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,

        ),
      ),
    );
  }
}