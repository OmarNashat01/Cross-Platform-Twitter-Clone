import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class UsernameScreen extends StatefulWidget {
  static const routeName = '/username-screen';

  @override
  State<UsernameScreen> createState() => UsernameScreenState();
}

class UsernameScreenState extends State<UsernameScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameFieldController = TextEditingController();

  String? validateUsername(username) {
    if (username == null || username.isEmpty || username.length <= 4) {
      return 'Username should be more than 4 characters.';
    }
    if (Provider.of<UserProvider>(context, listen: false).isUsernameTaken) {
      return 'Username has already been taken';
    }
    return null;
  }

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('username: PASSED');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).signup().then((res) {
        if (res.statusCode == 200) {
          Provider.of<UserProvider>(context, listen: false)
              .setIsEmailTaken(false);
          Navigator.of(context).pushReplacementNamed(TimelineScreen.routeName);
        } else {
          Provider.of<UserProvider>(context, listen: false)
              .setIsUsernameTaken(true);
        }
      });
    } else {
      log('username: FAILED');
    }
  }

  void _pressSkipButton(context) {
    // To gurantee empty username
    Provider.of<UserProvider>(context, listen: false).username = '';
    Navigator.of(context).pushReplacementNamed(TimelineScreen.routeName);
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
      prefix: const Text('@ '),
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
                          validator: validateUsername,
                          controller: usernameFieldController,
                          onSaved: (username) => value.username = username,
                          onFieldSubmitted: (_) => _pressNextButton(context),
                          decoration: _decorateField('Username'),
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
