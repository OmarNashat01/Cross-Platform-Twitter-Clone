import 'dart:developer';
import 'package:flutter/material.dart';
import '../../password_screen/password_screen.dart';


import '../../../themes.dart';
import '../../../constants.dart';

class SignUpButton extends StatelessWidget {
  final _formKey;
  final _user;
  const SignUpButton(this._formKey, this._user);

  void _pressSignupButton(context) {
    if (_formKey.currentState!.validate()) {
      log('passed');
      _formKey.currentState!.save();
      _user.save();
      Navigator.of(context).pushNamed(PasswordScreen.routeName);
    } else {
      log('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => _pressSignupButton(context),
        style: CustomButtons.blueButton(isFit: false),
        child: const Text('Sign Up'),
      ),
    );
  }
}
