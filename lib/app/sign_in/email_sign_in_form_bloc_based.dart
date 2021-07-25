import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/sign_in/email_sign_in_bloc.dart';
import 'package:test_01/app/sign_in/email_sign_in_model.dart';
import 'package:test_01/common_widgets/form_submit_button.dart';
import 'package:test_01/common_widgets/show_exception_alert_dialog.dart';
import 'package:test_01/services/auth.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  EmailSignInFormBlocBased({Key? key, required this.bloc}) : super(key: key);

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitButton() async {
    try {
      await widget.bloc.submitButton();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(context,
          title: "Login failed", exception: e, defaultActionText: "OK");
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleForm();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(height: 10),
      _buildPasswordTextField(model),
      SizedBox(height: 15),
      FormSubmitButton(
          text: model.primaryButtonText,
          onPressed: model.submitEnable ? _submitButton : null),
      SizedBox(height: 15),
      TextButton(
          onPressed: model.isLoading ? null : _toggleFormType,
          child: Text(model.secondaryButtonText))
    ];
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "tunganh2521999@gmail.com",
          errorText: model.errorTextEmail),
      enabled: !model.isLoading,
      autocorrect: false,
      onChanged: widget.bloc.updateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          labelText: "Password", errorText: model.errorTextPassword),
      enabled: !model.isLoading,
      obscureText: true,
      onChanged: widget.bloc.updatePassword,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submitButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel? model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model!),
            ),
          );
        });
  }
}
