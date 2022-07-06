import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth-screen";

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    final _auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      await FirebaseFirestore.instance
          .collection("users")
          .doc(authResult.user.uid)
          .set({
        "username": username,
        "email": email,
      });
    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials";

      if (err.message != null) {
        message = err.message ?? message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }

    if (isLogin) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              child: AuthForm(
                _submitAuthForm,
                _isLoading,
              ),
              padding: const EdgeInsets.all(18),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
