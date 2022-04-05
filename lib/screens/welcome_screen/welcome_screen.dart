import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth_welcome_screen/auth_welcome_screen.dart';

import '../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //! Needs to choose between signin screen or the home page according to cookies
  void _switchToSignInScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed(AuthWelcomeScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _switchToSignInScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
          child: SvgPicture.asset(
            kLogoPath,
            color: kOnSecondaryColor,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
