import 'package:flutter/material.dart';
import 'first_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-link',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstScreen(),
    );
  }
}
