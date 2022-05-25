import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/forgot_pass_otp_screen/forgot_pass_otp_screen.dart';
import 'package:twitter/screens/forgot_password_screen/forgot_password_screen.dart';
import '../login_password_screen/login_password_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

/// Login screen to handle email input field
class ForgotPassEmailScreen extends StatefulWidget {
  static const routeName = '/forgot_pass_email_screen';

  @override
  State<ForgotPassEmailScreen> createState() => ForgotPassEmailScreeState();
}

class ForgotPassEmailScreeState extends State<ForgotPassEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailFieldController = TextEditingController();

  String? validateEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email.';
    }
    return null;
  }

  void _pressNextButton(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      log('Forgot password Email PASSED');
      _formKey.currentState!.save();
      userProvider.forgotPassEmail().then((res) async {
        if (res.statusCode == 200) {
          log('Forgot password email SUCCESS : OTP: ${res.body}');
          Navigator.of(context)
              .pushReplacementNamed(ForgotPassOtpScreen.routeName);
        } else {
          log('Bad Forgot password email NOT FOUND');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sorry, we could not find your account.'),
          ));
        }
      });
    } else {
      log('Forgot password FAILED');
    }
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
                        'Find your Twitter account',
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
                      decoration: FieldDecorations.normal('Enter your email'),
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
                  child: const Text('Search'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
