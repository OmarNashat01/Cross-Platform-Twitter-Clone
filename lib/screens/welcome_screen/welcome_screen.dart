import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter/screens/signin_screen/signin_screen.dart';

import '../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _switchToSignInScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed(SigninScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _switchToSignInScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
          child: SvgPicture.asset(
            kLogoPath,
            color: Colors.white,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
