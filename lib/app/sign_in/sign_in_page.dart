import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/sign_in/email_sign_in_page.dart';
import 'package:test_01/app/sign_in/sign_in_bloc.dart';
import 'package:test_01/app/sign_in/sign_in_button.dart';
import 'package:test_01/app/sign_in/social_sign_in_button.dart';
import 'package:test_01/common_widgets/show_exception_alert_dialog.dart';
import 'package:test_01/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.bloc}) : super(key: key);

  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPage(bloc: bloc),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(context,
        title: "Sign in failed", exception: exception, defaultActionText: "OK");
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    /// TODO: function navigate to EmailSignInPage
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => EmailSignInPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 4.0,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool? isLoading) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: _buildHeader(context, isLoading!),
            height: 50.0,
          ),
          SizedBox(
            height: 60.0,
          ),
          SocialSignInButton(
            onPressed:
                isLoading == true ? () {} : () => _signInWithGoogle(context),
            text: "Sign in with Google",
            color: Colors.white,
            textColor: Colors.black,
            heightBtn: 60,
            pathImage: "images/ic_login_google.png",
          ),
          SizedBox(
            height: 10.0,
          ),
          SocialSignInButton(
            onPressed:
                isLoading == true ? () {} : () => _signInWithFacebook(context),
            text: "Sign in with Facebook",
            color: Color(0xFF334D92),
            textColor: Colors.white,
            heightBtn: 60,
            pathImage: "images/ic_login_face.png",
          ),
          SizedBox(
            height: 10.0,
          ),
          SignInButton(
            onPressed:
                isLoading == true ? () {} : () => _signInWithEmail(context),
            text: "Sign in with Email",
            color: Colors.deepOrange,
            textColor: Colors.black,
            heightBtn: 60.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Or",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.0,
          ),
          SignInButton(
            onPressed:
                isLoading == true ? () {} : () => _signInAnonymously(context),
            text: "Go Anonymous",
            color: Colors.blueGrey,
            textColor: Colors.white,
            heightBtn: 60.0,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isLoading) {
    if (isLoading == true) {
      return Center(child: CircularProgressIndicator());
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}
