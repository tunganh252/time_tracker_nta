import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_01/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
        {
          required String title,
        required Exception exception,
        required String defaultActionText}) =>
    showAlertDialog(context,
        title: title,
        content: _message(exception),
        defaultActionText: defaultActionText);

_message(Exception exception) {
  if (exception is FirebaseAuthException) {
    return exception.message;
  }
  return exception.toString();
}
