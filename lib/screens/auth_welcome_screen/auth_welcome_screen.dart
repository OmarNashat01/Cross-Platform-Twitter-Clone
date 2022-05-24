import 'package:flutter/material.dart';

import 'widgets/signup_buttons.dart';
import '../login_email_screen/login_email_screen.dart';

import '../../constants.dart';
import '../../themes.dart';

/// First page to choose among "signup" and "login" screens
class AuthWelcomeScreen extends StatelessWidget {
  static const routeName = '/auth-welcome-screen';

  void _switchToSigninScreen(context) {
    Navigator.of(context).pushNamed(LoginEmailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBars.welcomeAppBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Center(
                    child: Text(
                  'See what\'s happening in the world right \nnow.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ),
              Expanded(
                flex: 1,
                child: SignUpButtons(),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const Text('Have an account already?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: kSecondaryColor,
                      ),
                      onPressed: () => _switchToSigninScreen(context),
                      child: const Text('Log in'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
