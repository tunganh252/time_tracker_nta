import 'package:flutter/material.dart';
import 'package:test_01/common_widgets/form_submit_button.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInform extends StatefulWidget {
  @override
  _EmailSignInformState createState() => _EmailSignInformState();
}

class _EmailSignInformState extends State<EmailSignInform> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submitButton() {
    /// TODO: print email and password
    print(
        'email: ${_emailController.text} and password: ${_passwordController.text}');
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an account";
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
            labelText: "Email", hintText: "tunganh252@gmail.com"),
      ),
      TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: "Password"),
          obscureText: true),
      SizedBox(height: 15),
      FormSubmitButton(text: primaryText, onPressed: _submitButton),
      SizedBox(height: 15),
      TextButton(onPressed: _toggleFormType, child: Text(secondaryText))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
