import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_01/app/sign_in/validators.dart';
import 'package:test_01/common_widgets/form_submit_button.dart';
import 'package:test_01/common_widgets/show_alert_dialog.dart';
import 'package:test_01/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInform extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInform({Key? key, required this.auth}) : super(key: key);

  // EmailSignInform({required this.auth});

  final AuthBase auth;

  @override
  _EmailSignInformState createState() => _EmailSignInformState();
}

class _EmailSignInformState extends State<EmailSignInform> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  bool _submitted = false;
  bool _loading = false;

  void _submitButton() async {
    setState(() {
      _submitted = true;
      _loading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 1));
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else if (_formType == EmailSignInFormType.register) {
        await widget.auth.createWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(context,
          title: "Login failed",
          content: e.toString(),
          defaultActionText: "OK",
          cancelActionText: "Cancel");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
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

    bool submitEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_loading;

    return [
      _buildEmailTextField(),
      SizedBox(height: 10),
      _buildPasswordTextField(),
      SizedBox(height: 15),
      FormSubmitButton(
          text: primaryText, onPressed: submitEnable ? _submitButton : null),
      SizedBox(height: 15),
      TextButton(
          onPressed: _loading ? null : _toggleFormType,
          child: Text(secondaryText))
    ];
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    String emailErrorText = widget.emailErrorText;

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "tunganh2521999@gmail.com",
          errorText: showErrorText ? emailErrorText : null),
      enabled: !_loading,
      autocorrect: false,
      onChanged: (password) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    String passwordErrorText = widget.passwordErrorText;

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          labelText: "Password",
          errorText: showErrorText ? passwordErrorText : null),
      enabled: !_loading,
      obscureText: true,
      onChanged: (email) => _updateState(),
      textInputAction: TextInputAction.done,
      onEditingComplete: _submitButton,
    );
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

  void _updateState() {
    setState(() {});
  }
}
