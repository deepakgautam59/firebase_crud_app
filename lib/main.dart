import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newapp/firebase_options.dart';
import 'package:newapp/pages/auth/login_screen.dart';
import 'package:newapp/pages/homescreen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white), // Default icon color
      backgroundColor: Colors.blue, // Default background color
    ),
  ),
   debugShowCheckedModeBanner: false,
      home:  (FirebaseAuth.instance.currentUser != null) ? LoginPage() : HomePage(),
    );
  }
}

