import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../verification_screen/verification_screen.dart';


import '../../../themes.dart';

class SignupButton extends StatelessWidget {
  final _formKey;
  const SignupButton(this._formKey);

  void _pressSignupButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Name, email, dob: PASSED');
      _formKey.currentState!.save();  // to save name, email, dob in user_provider
      Provider.of<UserProvider>(context, listen: false).verifyEmail();
      // Todo: Check for the "already taken emails" from the response of verifyEmail()
      
      Navigator.of(context).pushNamed(VerificationScreen.routeName);
    } else {
      log('Name, email, dob: FAILED');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => _pressSignupButton(context),
        style: CustomButtons.blueButton(isFit: false),
        child: const Text('Sign Up'),
      ),
    );
  }
}
