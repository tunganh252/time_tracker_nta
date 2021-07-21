import 'package:flutter/material.dart';
import 'package:test_01/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required onPressed,
    String text = "hello",
    Color color = Colors.black,
    Color textColor = Colors.purpleAccent,
    double heightBtn = 50,
    required pathImage,
  })  : assert(pathImage != null),
        super(
            onPressed: onPressed,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(pathImage,
                      width: 40, height: 40, fit: BoxFit.fill),
                  Text(text,
                      style: TextStyle(color: textColor, fontSize: 15.0)),
                  Opacity(
                    opacity: 0,
                  )
                ]),
            color: color,
            borderRadius: 5.0,
            height: heightBtn);
}
