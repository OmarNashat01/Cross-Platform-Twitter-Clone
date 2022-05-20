import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import 'package:twitter/screens/welcome_screen/welcome_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

/// @username screen
class UsernameScreen extends StatefulWidget {
  static const routeName = '/username-screen';

  @override
  State<UsernameScreen> createState() => UsernameScreenState();
}

class UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameFieldController = TextEditingController();

  /// Check if the entered username is already taken by another user
  bool isUsernameTakenChecker() {
    return Provider.of<UserProvider>(context, listen: false).isUsernameTaken;
  }

  /// Proper validations for username input field
  String? validateUsername(username, isUsernameTaken) {
    if (username == null || username.isEmpty || username.length <= 4) {
      return 'Username should be more than 4 characters.';
    }
    if (isUsernameTaken) {
      return 'Username has already been taken';
    }
    return null;
  }

  void _loginResponseHandler(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setIsEmailTaken(false);
    userProvider.login().then((loginRes) async {
      switch (loginRes.statusCode) {
        case 200: // User exists (success)
          final response = jsonDecode(loginRes.body);
          Auth.email = userProvider.email;
          Auth.password = userProvider.password;
          Auth.token = response['token'];
          Auth.userId = response['user_id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs
            ..setString('email', Auth.email)
            ..setString('password', Auth.password);

          log('token : ${Auth.token}');
          log('userid : ${Auth.userId}');
          log('email : ${Auth.email}');
          log('password : ${Auth.password}');
          Navigator.of(context).pushReplacementNamed(TimelineScreen.routeName);
          break;
        case 400: // Wrong password
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password!'),
          ));
          userProvider.email = '';
          userProvider.password = '';
          break;
        default: // status code 401 (user doesn't exist)
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Sorry, we could not find your account.'),
          ));
          userProvider.email = '';
          userProvider.password = '';
          break;
      }
    });
  }

  void _pressNextButton(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setIsUsernameTaken(false);

    if (_formKey.currentState!.validate()) {
      log('username: PASSED');
      _formKey.currentState!.save();
      userProvider.signup().then((res) {
        if (res.statusCode == 200) {
          userProvider.setIsUsernameTaken(false);
          Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
        } else {
          userProvider.setIsUsernameTaken(true);
        }
      });
    } else {
      log('username: FAILED');
    }
  }

  void _pressSkipButton(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // To gurantee empty username
    userProvider.username = '';
    userProvider.signup().then((res) {
      if (res.statusCode == 200) {
        userProvider.setIsUsernameTaken(false);
        Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
      } else {
        userProvider.setIsUsernameTaken(true);
      }
    });
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
                        'What should we call you?',
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
                      child: Text(
                          'Your @username is unique. You can always change it later.'),
                    ),
                  ),
                  Consumer<UserProvider>(
                    builder: (context, value, child) {
                      return Form(
                        key: _formKey,
                        child: TextFormField(
                          autofocus: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: (value) => validateUsername(value, isUsernameTakenChecker()),
                          controller: usernameFieldController,
                          onSaved: (username) => value.username = username,
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          decoration: FieldDecorations.normalWithPrefix(
                              'Username', '@ '),
                        ),
                      );
                    },
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
                      onPressed: () => _pressSkipButton(context),
                      style: CustomButtons.whiteButton(),
                      child: const Text('Skip'),
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
