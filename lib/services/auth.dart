import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  dynamic get currentUser;

  Stream<User?> authStateChanges();

  Future<UserCredential> signInAnonymously();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  dynamic get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInAnonymously() async {
    final userCredential = _firebaseAuth.signInAnonymously();
    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
