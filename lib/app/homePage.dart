import 'package:flutter/material.dart';
import 'package:test_01/common_widgets/show_alert_dialog.dart';
import 'package:test_01/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: "Logout",
        content: "Are you sure that you want logout?",
        defaultActionText: "Logout",
        cancelActionText: "Cancel");

    if (didRequestSignOut == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          TextButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 15.5),
              ),
              onPressed: () => _confirmSignOut(context))
        ],
      ),
    );
  }
}
