import 'dart:async';
import 'package:test_01/app/sign_in/email_sign_in_model.dart';
import 'package:test_01/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});

  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submitButton() async {
    updateWith(isLoading: true, submitted: true);
    try {
      await Future.delayed(Duration(seconds: 1));
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else if (_model.formType == EmailSignInFormType.register) {
        await auth.createWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleForm() {
    final formType = _model.formType == EmailSignInFormType.signIn
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
    // update model
    _model = _model.copyWith(
        email: email ?? _model.email,
        password: password ?? _model.password,
        formType: formType ?? _model.formType,
        isLoading: isLoading ?? _model.isLoading,
        submitted: submitted ?? _model.submitted);
    // add model to _modelController
    _modelController.add(_model);
  }
}
