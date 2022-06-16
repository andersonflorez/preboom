import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:preboom/models/challenges_complete_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class SigninState with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firebaseUser = FirebaseFirestore.instance.collection("users");
  late SharedPreferences _prefs;

  bool _loggedIn = false;
  bool _loading = true;
  late UserModel _userStateModel;

  SigninState() {
    loginState();
  }

  bool isLoggedIn() => _loggedIn;
  bool isLoading() => _loading;

  int numberChallengsComplete() => _userStateModel.challengesComplete.length;

  UserModel currentUser() => _userStateModel;

  List<ChallengesCompleteModel> getChallengesComplete() =>
      _userStateModel.challengesComplete;

  ChallengesCompleteModel? getChallengeComplete(String idChallenge) {
    try {
      return _userStateModel.challengesComplete
          .firstWhere((element) => element.idChallenge == idChallenge);
    } catch (e) {
      return null;
    }
  }

  Future<String> createCredential(String? email, String? password) async {
    try {
      _loading = true;
      notifyListeners();
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      await userFirebase(userCredential.user);

      return "";
    } on FirebaseAuthException catch (e) {
      _loggedIn = false;
      return e.code;
    } catch (e) {
      _loggedIn = false;
      return "service-error";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      return "";
    } catch (e) {
      return "service-error";
    }
  }

  Future<String> loginCredential(String? email, String? password) async {
    try {
      _loading = true;
      notifyListeners();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      await userFirebase(userCredential.user);

      return "";
    } on FirebaseAuthException catch (e) {
      _loggedIn = false;
      return e.code;
    } catch (e) {
      _loggedIn = false;
      return "service-error";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> loginGoogle() async {
    try {
      _loading = true;
      notifyListeners();
      UserCredential userCredential = await signInWithGoogle();

      await userFirebase(userCredential.user);

      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  void loguot() {
    _loading = true;
    _prefs.clear();
    _firebaseAuth.signOut();
    GoogleSignIn().signOut();
    _loggedIn = false;
    notifyListeners();
    _loading = false;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return _firebaseAuth.signInWithCredential(credential);
  }

  void loginState() async {
    _loading = true;
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("isLoggedIn")) {
      User? user = _firebaseAuth.currentUser;

      await userFirebase(user);

      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> userFirebase(User? user) async {
    if (user != null) {
      _prefs.setBool("isLoggedIn", true);
      _loggedIn = true;

      DocumentSnapshot<Map<String, dynamic>> queryUser =
          await _firebaseUser.doc(user.uid).get();

      var userFirebase = queryUser.data();

      if (userFirebase == null) {
        _userStateModel = UserModel.userFirebase(user);
      } else {
        _userStateModel = UserModel.firestore(user.uid, userFirebase);
      }
    } else {
      _loggedIn = false;
    }
  }

  Future<dynamic> updateUserInFirestore(UserModel user) async {
    _loading = true;

    var response = await _firebaseUser.doc(user.uid).set(
          user.toFirestore(),
          SetOptions(merge: true),
        );
    _userStateModel = user;
    _loading = false;
    return response;
  }

  void updateCurrentUserFirestore(Map<String, dynamic>? userFirebase) {
    _userStateModel = UserModel.firestore(_userStateModel.uid, userFirebase);
    notifyListeners();
  }
}
