import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/signup_buttons.dart';

import '../signin_screen/signin_screen.dart';

import '../../constants.dart';

class AuthWelcomeScreen extends StatelessWidget {
  static const routeName = '/auth-welcome-screen';

   void _switchToSigninScreen(context) {
    Navigator.of(context).pushNamed(SigninScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          kLogoPath,
          color: kSecondaryColor,
          width: 20,
          height: 20,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              const Expanded(
                flex: 4,
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
                        primary: Theme.of(context).colorScheme.secondary,
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
