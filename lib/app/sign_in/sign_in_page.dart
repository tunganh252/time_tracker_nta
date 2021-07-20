import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:test_01/app/sign_in/email_sign_in_page.dart';
import 'package:test_01/app/sign_in/sign_in_button.dart';
import 'package:test_01/app/sign_in/social_sign_in_button.dart';
import 'package:test_01/services/auth.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
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
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60.0,
          ),
          SocialSignInButton(
            onPressed: () => _signInWithGoogle(context),
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
            onPressed: () => _signInWithFacebook(context),
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
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
            text: "Go Anonymous",
            color: Colors.blueGrey,
            textColor: Colors.white,
            heightBtn: 60.0,
          ),
        ],
      ),
    );
  }
}
