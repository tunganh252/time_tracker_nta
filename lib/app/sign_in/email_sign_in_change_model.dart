import 'package:flutter/foundation.dart';
import 'package:test_01/app/sign_in/validators.dart';
import 'package:test_01/services/auth.dart';
import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel(
      {required this.auth,
      this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  String get primaryButtonText =>
      formType == EmailSignInFormType.signIn ? "Sign In" : "Create an account";

  String get secondaryButtonText => formType == EmailSignInFormType.signIn
      ? "Need an account? Register"
      : "Have an account? Sign In";

  String? get errorTextEmail =>
      submitted && !emailValidator.isValid(email) ? emailErrorText : null;

  String? get errorTextPassword =>
      submitted && !passwordValidator.isValid(password)
          ? passwordErrorText
          : null;

  bool get submitEnable {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  Future<void> submitButton() async {
    updateWith(isLoading: true, submitted: true);
    try {
      await Future.delayed(Duration(seconds: 1));
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else if (formType == EmailSignInFormType.register) {
        await auth.createWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleForm() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) {
    updateWith(
      email: email,
    );
  }

  void updatePassword(String password) {
    updateWith(password: password);
  }

  void updateWith(
      {String? email,
      String? password,
      EmailSignInFormType? formType,
      bool? isLoading,
      bool? submitted}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
