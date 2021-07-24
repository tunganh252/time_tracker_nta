import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/sign_in/email_sign_in_bloc.dart';
import 'package:test_01/app/sign_in/email_sign_in_model.dart';
import 'package:test_01/app/sign_in/validators.dart';
import 'package:test_01/common_widgets/form_submit_button.dart';
import 'package:test_01/common_widgets/show_exception_alert_dialog.dart';
import 'package:test_01/services/auth.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidators {
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

  // String get _email => _emailController.text;
  //
  // String get _password => _passwordController.text;
  //
  // EmailSignInFormType _formType = EmailSignInFormType.signIn;
  //
  // bool _submitted = false;
  // bool _loading = false;

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
    final newFocus = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.updateWith(
      email: '',
      password: '',
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );

    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    final primaryText = model.formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an account";
    final secondaryText = model.formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";

    bool submitEnable = widget.emailValidator.isValid(model.email) &&
        widget.passwordValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(height: 10),
      _buildPasswordTextField(model),
      SizedBox(height: 15),
      FormSubmitButton(
          text: primaryText, onPressed: submitEnable ? _submitButton : null),
      SizedBox(height: 15),
      TextButton(
          onPressed: model.isLoading ? null : () => _toggleFormType(model),
          child: Text(secondaryText))
    ];
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.emailValidator.isValid(model.email);
    String emailErrorText = widget.emailErrorText;

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "tunganh2521999@gmail.com",
          errorText: showErrorText ? emailErrorText : null),
      enabled: !model.isLoading,
      autocorrect: false,
      onChanged: (email) => widget.bloc.updateWith(
          email: email,
          password: model.password,
          formType: model.formType,
          isLoading: model.isLoading,
          submitted: model.submitted),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
    );
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.passwordValidator.isValid(model.password);
    String passwordErrorText = widget.passwordErrorText;

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          labelText: "Password",
          errorText: showErrorText ? passwordErrorText : null),
      enabled: !model.isLoading,
      obscureText: true,
      onChanged: (password) => widget.bloc.updateWith(
          email: model.email,
          password: password,
          formType: model.formType,
          isLoading: model.isLoading,
          submitted: model.submitted),
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
