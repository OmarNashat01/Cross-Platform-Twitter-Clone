import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/password_screen/password_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification-screen';

  @override
  State<VerificationScreen> createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _verificationFieldController = TextEditingController();

  String? validateVerificationCode(code) {
    if (code == null || code.isEmpty) {
      return '';
    }
    return null;
  }

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Verification PASSED');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).verifyCode();
      // Todo: Check for the response of verifyCode() to confirm that the code is written correctly
      // Todo: Display the verification code expiration time (elapsed time)
      Navigator.of(context)
        ..pop()
        ..pop();
      Navigator.of(context).pushReplacementNamed(PasswordScreen.routeName);
    } else {
      log('Verification FAILED');
    }
  }

  InputDecoration _decorateVerificationField(String hint) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        ' Enter it below to verify ${Provider.of<UserProvider>(context, listen: false).email}',
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      cursorWidth: 2,
                      style: const TextStyle(fontSize: 20),
                      validator: validateVerificationCode,
                      controller: _verificationFieldController,
                      onSaved: (code) =>
                          Provider.of<UserProvider>(context, listen: false)
                              .verificationCode = code,
                      onFieldSubmitted: (_) => _pressNextButton(context),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration:
                          _decorateVerificationField('Verification code'),
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
