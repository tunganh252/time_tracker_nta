import 'package:flutter/material.dart';
import 'package:test_01/services/auth.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider({Key? key, required Widget child, required this.auth})
      : super(key: key, child: child);

  final AuthBase auth;

  // final auth = AuthBase.of(context);
  static AuthBase? of(BuildContext context) {
    final AuthProvider? provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider?.auth;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
