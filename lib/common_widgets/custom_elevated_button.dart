import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.child = const Text("hello"),
    this.color = Colors.purpleAccent,
    this.borderRadius = 15.0,
    this.height = 50.0,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
      ),
    );
  }
}
