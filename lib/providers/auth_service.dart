import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';

class AuthService extends ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFiresbase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
        id: user.uid,
        email: user.email != null ? user.email : 'sss',
        name: 'sass');
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFiresbase);
  }

  Future<User?> signInwithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return _userFromFiresbase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final auth.UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFiresbase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
