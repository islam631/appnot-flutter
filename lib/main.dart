import 'package:appnote/app/auth/login.dart';
import 'package:appnote/app/auth/signup.dart';
import 'package:appnote/app/auth/success..dart';
import 'package:appnote/app/home.dart';
import 'package:appnote/app/notes/add.dart';
import 'package:appnote/app/notes/edit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPre;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPre = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'course PHP Rest API',
      initialRoute: sharedPre.getString("id") == null ? "login" : "home",
      routes: {
        "login": (context) => const login(),
        "signup": (context) => const SignUp(),
        "home": (context) => const Home(),
        "success": (context) => const Seccess(),
        "addnotes": (context) => const AddNotes(),
        "editnotes": (context) => EditNotes(),
      },
    );
  }
}
