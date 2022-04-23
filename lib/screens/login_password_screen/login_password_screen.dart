import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/password_screen/password_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class LoginPasswordScreen extends StatefulWidget {
  static const routeName = '/login-password-screen';

  @override
  State<LoginPasswordScreen> createState() => LoginPasswordScreenState();
}

class LoginPasswordScreenState extends State<LoginPasswordScreen> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final _passwordFieldController = TextEditingController();

  String? validatePassword(pass) {
    if (pass == null || pass.isEmpty) {
      return 'Please enter your password.';
    }
    return null;
  }

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('Login Password PASSED');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).login().then((res) {
        switch (res.statusCode) {
          case 200: // User exists (success)
            final response = jsonDecode(res.body);
            Auth.email =
                Provider.of<UserProvider>(context, listen: false).email;
            Auth.password =
                Provider.of<UserProvider>(context, listen: false).password;
            Auth.token = response['token'];
            Auth.userId = response['user_id'];
            log('token : ${Auth.token}');
            log('userid : ${Auth.userId}');
            log('email : ${Auth.email}');
            log('password : ${Auth.password}');
            Navigator.of(context)
              ..pop()
              ..pushReplacementNamed(TimelineScreen.routeName);
            break;
          case 400: // Wrong password
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wrong password!'),
            ));
            Provider.of<UserProvider>(context, listen: false).email = '';
            Provider.of<UserProvider>(context, listen: false).password = '';

            break;
          default: // status code 401 (user doesn't exist)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Sorry, we could not find your account.'),
            ));
            Provider.of<UserProvider>(context, listen: false).email = '';
            Provider.of<UserProvider>(context, listen: false).password = '';
            break;
        }
      });

    } else {
      log('Login Password FAILED');
    }
  }

  void _pressForgotPassButton(context) {
    // Todo
  }

  String hashToMd5(String pass) {
    return md5.convert(utf8.encode(pass)).toString();
  }

  InputDecoration _decorateField() {
    return const InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      enabled: false,
      counterStyle: TextStyle(fontSize: 16),
    );
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
                      padding: EdgeInsets.only(top: 20, bottom: 25),
                      child: Text(
                        'Enter your password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword,
                          // Can be ignored
                          onSaved: (email) =>
                              Provider.of<UserProvider>(context, listen: false)
                                  .email = email,
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          keyboardType: TextInputType.text,
                          decoration: _decorateField(),
                          initialValue:
                              Provider.of<UserProvider>(context, listen: false)
                                  .email,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
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
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: _decoratePasswordField('Password'),
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
                      child: const Text('Log in'),
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
