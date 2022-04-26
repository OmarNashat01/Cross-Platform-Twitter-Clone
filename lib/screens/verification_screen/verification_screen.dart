import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/password_screen/password_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

/// Account validation screen
class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification-screen';

  @override
  State<VerificationScreen> createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _verificationFieldController = TextEditingController();

  /// Check if the entered verification code matches the one sent to this email 
  String? validateVerificationCode(code) {
    if (code == null || code.isEmpty) {
      return 'Please enter the verification code.';
    }
    return null;
  }

  /// Saves the verification code and handle the API responses
  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Verification PASSED');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false)
          .verifyCode()
          .then((res) {
        // email verified
        if (res.statusCode == 200) {
          Navigator.of(context)
            ..pop()
            ..pop();
          Navigator.of(context).pushReplacementNamed(PasswordScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('The code you entered is incorrect. Please try again.'),
            ),
          );
        }
      });
    } else {
      log('Verification FAILED');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBars.welcomeAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'We sent you a code',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 25),
                      child: Text(
                        ' Enter it below to verify ${userProvider.email}',
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: kSecondaryColor,
                      cursorWidth: 2,
                      style: const TextStyle(fontSize: 20),
                      validator: validateVerificationCode,
                      controller: _verificationFieldController,
                      onSaved: (code) => userProvider.verificationCode = code,
                      onFieldSubmitted: (_) => _pressNextButton(context),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: FieldDecorations.normal('Verification code'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => _pressNextButton(context),
                  style: CustomButtons.blackButton(),
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
