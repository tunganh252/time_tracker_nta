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
    updateWith(
        isLoading: true,
        submitted: true,
        formType: _model.formType,
        email: _model.email,
        password: _model.password);
    try {
      await Future.delayed(Duration(seconds: 1));
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else if (_model.formType == EmailSignInFormType.register) {
        await auth.createWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
      updateWith(
          isLoading: false,
          submitted: _model.submitted,
          formType: _model.formType,
          email: _model.email,
          password: _model.password);
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
        isLoading: _model.isLoading,
        submitted: _model.submitted,
        formType: _model.formType,
        password: _model.password);
  }

  void updatePassword(String password) {
    updateWith(
        email: _model.email,
        isLoading: _model.isLoading,
        submitted: _model.submitted,
        formType: _model.formType,
        password: password);
  }

  void updateWith(
      {required String email,
      required String password,
      required EmailSignInFormType formType,
      required bool isLoading,
      required bool submitted}) {
    // update model
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
    // add model to _modelController
    _modelController.add(_model);
  }
}
