import 'package:flutter/material.dart';

import '../picker/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;
  bool isLoading;

  AuthForm(this.submitAuthForm, this.isLoading);
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  var _userEmail = "";
  var _userName = "";
  var _userPassword = "";

  void _trySaving(BuildContext ctx) {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _formKey.currentState.save();
      widget.submitAuthForm(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        ctx,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isLogin) UserImagePicker(),
          TextFormField(
            key: ValueKey("Email"),
            validator: (value) {
              if (value == null) return "Field is empty";
              if (value.isEmpty || !value.contains("@"))
                return "Enter a valid Emil";
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email Address",
            ),
            onSaved: (value) {
              _userEmail = value ?? "";
            },
          ),
          if (!_isLogin)
            TextFormField(
              key: ValueKey("username"),
              validator: (value) {
                if (value == null) return "Field is empty";
                if (value.isEmpty || value.length < 4)
                  return "Username must be atleast 4 character";
                return null;
              },
              decoration: InputDecoration(labelText: "Username"),
              onSaved: (value) {
                _userName = value ?? "";
              },
            ),
          TextFormField(
            key: ValueKey("password"),
            validator: (value) {
              if (value == null) return "Field is empty";
              if (value.isEmpty || value.length < 7)
                return "Password must be atleast 7 character";
              return null;
            },
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            onSaved: (value) {
              _userPassword = value ?? "";
            },
          ),
          SizedBox(
            height: 12,
          ),
          widget.isLoading
              ? CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )
              : RaisedButton(
                  onPressed: () {
                    _trySaving(context);
                  },
                  child: Text(_isLogin ? "Login" : "Sign Up"),
                ),
          if (!widget.isLoading)
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                _isLogin ? "Create an account" : "I already have an account",
              ),
            ),
        ],
      ),
    );
  }
}
