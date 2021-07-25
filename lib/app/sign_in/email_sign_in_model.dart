import 'package:test_01/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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

  EmailSignInModel copyWith(
      {required String email,
      required String password,
      required EmailSignInFormType formType,
      required bool isLoading,
      required bool submitted}) {
    return EmailSignInModel(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
  }
}
