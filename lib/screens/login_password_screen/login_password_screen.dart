import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';
import '../forgot_password_screen/forgot_password_screen.dart';

/// Login Screen that takes password as an input
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      log('Login Password PASSED');
      _formKey.currentState!.save();
      userProvider.login().then((res) async {
        switch (res.statusCode) {
          case 200: // Todo
          case 201: // OK (success)
            final response = jsonDecode(res.body);
            Auth.email = userProvider.email;
            Auth.password = userProvider.password;
            Auth.token = response['token'];
            Auth.userId = response['_id'].toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs
              ..setString('email', Auth.email)
              ..setString('password', Auth.password);

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
            // userProvider.email = '';
            // userProvider.password = '';

            break;
          default: // status code 404 (user doesn't exist)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Sorry, we could not find your account.'),
            ));
            // userProvider.email = '';
            // userProvider.password = '';
            break;
        }
      });
    } else {
      log('Login Password FAILED');
    }
  }

  void _pressForgotPassButton(context) {
    // Todo
    Navigator.of(context).pushReplacementNamed(ForgotPasswordScreen.routeName);

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
                          onSaved: (email) => userProvider.email = email,
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          keyboardType: TextInputType.text,
                          decoration: FieldDecorations.abnormal(),
                          initialValue: userProvider.email,
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
                              userProvider.password = hashToMd5(pass as String),
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIcon(
                            'Password',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObscure = !_isObscure),
                              icon: Icon(
                                _isObscure
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
