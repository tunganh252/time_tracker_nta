import 'package:flutter/material.dart';
import 'package:test_01/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required onPressed,
    @required text,
    Color color = Colors.black,
    Color textColor = Colors.purpleAccent,
    double heightBtn = 50,
  })  : assert(text != null),
         super(
            onPressed: () {},
            child:
                Text(text, style: TextStyle(color: textColor, fontSize: 15.0)),
            color: color,
            borderRadius: 5.0,
            height: heightBtn);
}
