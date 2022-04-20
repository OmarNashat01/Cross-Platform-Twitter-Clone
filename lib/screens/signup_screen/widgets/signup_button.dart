import 'dart:developer';
import 'package:flutter/material.dart';
import '../../password_screen/password_screen.dart';

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
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondary,
          onPrimary: Theme.of(context).colorScheme.onSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          shadowColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Sign Up'),
      ),
    );
  }
}
