import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/sign_in/sign_in_page.dart';

void main() async{
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SignInPage(),
    );
  }
}
