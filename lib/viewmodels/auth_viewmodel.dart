import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = false;

  AuthViewModel() {
    _auth.authStateChanges().listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Handle error
    }
    isLoading = false;
    notifyListeners();
  }

  // Future<void> signUp(String email, String password) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //   } catch (e) {
  //     // Handle error
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }
  Future<void> signUp(String email, String password) async {
  isLoading = true;
  notifyListeners();
  try {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    user = result.user;
    // Save user info in Firestore
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'email': email,
      'uid': user!.uid,
    });
  } catch (e) {
    // Handle error
  }
  isLoading = false;
  notifyListeners();
}

  Future<void> signOut() async {
    await _auth.signOut();
  }
}