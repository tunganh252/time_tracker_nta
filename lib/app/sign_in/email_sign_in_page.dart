import 'package:flutter/material.dart';
import 'package:test_01/app/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:test_01/services/auth_provider.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            // child: EmailSignInFormBlocBased.create(context),
            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
