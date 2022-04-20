import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/password_screen/password_screen.dart';
import '../login_password_screen/login_password_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class LoginEmailScreen extends StatefulWidget {
  static const routeName = '/login-email-screen';

  @override
  State<LoginEmailScreen> createState() => LoginEmailScreenState();
}

class LoginEmailScreenState extends State<LoginEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();

  String? validateEmail(email) {
    if (email == null || email.isEmpty) {
      return '';
    }
    return null;
  }

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Login Email PASSED');
      _formKey.currentState!.save();
      Navigator.of(context).pushReplacementNamed(LoginPasswordScreen.routeName);
    } else {
      log('Login Email FAILED');
    }
  }

  void _pressForgotPassButton(context) {
    // Todo
  }

  InputDecoration _decorateField(String hint) {
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
                      padding: EdgeInsets.only(top: 20, bottom: 25),
                      child: Text(
                        'To get started, first enter your email or @username',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
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
                      validator: validateEmail,
                      controller: _emailFieldController,
                      onSaved: (email) =>
                          Provider.of<UserProvider>(context, listen: false)
                              .email = email,
                      onFieldSubmitted: (_) => _pressNextButton(context),
                      keyboardType: TextInputType.text,
                      decoration:
                          _decorateField('Email or username'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => _pressForgotPassButton(context),
                      style: CustomButtons.whiteButton(),
                      child: const Text('Forgot password?'),
                    ),
                    ElevatedButton(
                      onPressed: () => _pressNextButton(context),
                      style: CustomButtons.blackButton(),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
