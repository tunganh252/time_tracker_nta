enum EmailSignInFormType { signIn, register }

class EmailSignInModel {
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
