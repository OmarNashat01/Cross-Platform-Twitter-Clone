import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/return_to_twitter_screen/return_to_twitter_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';

  @override
  State<ForgotPasswordScreen> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isObsecure1 = true;
  bool _isObsecure2 = true;

  final _formKey = GlobalKey<FormState>();

  final _passwordFieldController1 = TextEditingController();
  final _passwordFieldController2 = TextEditingController();

  String? validatePassword1(pass) {
    if (pass == null || pass.isEmpty || pass.length < 8) {
      return 'Your password needs to be at least 8 characters.\nPlease enter a longer one.';
    }
    return null;
  }

  String? validatePassword2(pass) {
    if (pass == null ||
        pass.isEmpty ||
        pass != _passwordFieldController1.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  void _pressResetPasswordButton(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      log('forgot Password PASSED');
      _formKey.currentState!.save(); //? Password is saved in user provider

      userProvider.forgotPassword().then((res) async {
        // TODO: is to be implemented
        Navigator.of(context)
            .pushReplacementNamed(ReturnToTwitterScreen.routeName);
      });
    } else {
      log('forgot Password FAILED');
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
                      padding: EdgeInsets.only(top: 20, bottom: 25),
                      child: Text(
                        'Reset your password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 25),
                    child: Text(
                        'Strong passwords include numbers, letters, and punctuation marks.'),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          obscureText: _isObsecure1,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword1,
                          controller: _passwordFieldController1,
                          onSaved: (pass) =>
                              userProvider.password = hashToMd5(pass as String),
                          onFieldSubmitted: (_) =>
                              _pressResetPasswordButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIcon(
                            'Enter your new password',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure1 = !_isObsecure1),
                              icon: Icon(
                                _isObsecure1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: _isObsecure2,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword2,
                          controller: _passwordFieldController2,
                          onFieldSubmitted: (_) =>
                              _pressResetPasswordButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIcon(
                            'Enter your new password one more time',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure2 = !_isObsecure2),
                              icon: Icon(
                                _isObsecure2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pressResetPasswordButton(context),
                      style: CustomButtons.blackButton(),
                      child: const Text('Reset password'),
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
