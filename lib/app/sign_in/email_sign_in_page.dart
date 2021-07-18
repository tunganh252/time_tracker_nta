import 'package:flutter/material.dart';
import 'package:test_01/app/sign_in/email_sign_in_form.dart';
import 'package:test_01/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInform(
              auth: auth,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
