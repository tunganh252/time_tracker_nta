import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_01/app/sign_in/sign_in_button.dart';
import 'package:test_01/app/sign_in/social_sign_in_button.dart';
import 'package:test_01/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 4.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
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
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: _signInAnonymously,
            text: "Go Anonymous",
            color: Colors.blueGrey,
            textColor: Colors.white,
            heightBtn: 60.0,
          ),
        ],
      ),
    );
  }

// void _signInWithGoogle() {
//   // TODO: Auth with Google
//   print("hello");
// }
}
