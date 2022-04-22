import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';

import '../profile_pic_screen/profile_pic_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password-screen';

  @override
  State<PasswordScreen> createState() => PasswordScreenState();
}

class PasswordScreenState extends State<PasswordScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  final _passwordFieldController = TextEditingController();

  String? validatePassword(pass) {
    if (pass == null || pass.isEmpty || pass.length < 8) {
      return 'Your password needs to be at least 8 characters.\nPlease enter a longer one.';
    }
    return null;
  }

  void _pressSignupButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Password: PASSED');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).logAll();
      Navigator.of(context).pushReplacementNamed(ProfilePicScreen.routeName);
    } else {
      log('Password: FAILED');
    }
  }

  String hashToMd5(String pass) {
    return md5.convert(utf8.encode(pass)).toString();
  }

  InputDecoration _decoratePasswordField(String hint) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
      suffixIcon: IconButton(
        onPressed: () => setState(() => _isObscure = !_isObscure),
        icon: Icon(
          _isObscure ? Icons.visibility_off : Icons.visibility,
        ),
        color: Colors.grey,
      ),
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
                        'You\'ll need a password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 25),
                      child: Text(' Make sure it\'s 8 characters or more.'),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      obscureText: _isObscure,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      cursorWidth: 2,
                      style: const TextStyle(fontSize: 20),
                      validator: validatePassword,
                      controller: _passwordFieldController,
                      onSaved: (pass) =>
                          Provider.of<UserProvider>(context, listen: false)
                              .password = hashToMd5(pass as String),
                      onFieldSubmitted: (_) => _pressSignupButton(context),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: _decoratePasswordField('Password'),
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
                  onPressed: () => _pressSignupButton(context),
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
