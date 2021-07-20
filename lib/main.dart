import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/landing_page.dart';
import 'package:test_01/services/auth.dart';
import 'package:test_01/services/auth_provider.dart';

Future<void> main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (BuildContext context) => Auth(),
      child: MaterialApp(
        title: "Test",
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LandingPage(),
      ),
    );
  }
}
