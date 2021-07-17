import 'package:flutter/material.dart';
import 'package:test_01/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInform(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
