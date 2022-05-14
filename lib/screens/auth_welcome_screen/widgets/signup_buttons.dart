import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter/providers/oAuth_api.dart';

import '../../signup_screen/signup_screen.dart';

import '../../../themes.dart';
import '../../../constants.dart';

/// Widgets of Buttons inside the signup / login screen
class SignUpButtons extends StatelessWidget {
  void _switchToSignupScreen(context) {
    Navigator.of(context).pushNamed(SignupScreen.routeName);
  }

  Future<void> _oAuth() async {
    final user = await OAuth.login();
    log('${user.email}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          icon: SvgPicture.asset(
            kGoogleLogoPath,
            width: 20,
          ),
          onPressed: _oAuth,
          label: const Text("Continue with Google"),
          style: CustomButtons.whiteButton(isFit: false),
        ),
        const Divider(
          color: Colors.black12,
          thickness: 1,
        ),
        ElevatedButton(
          onPressed: () => _switchToSignupScreen(context),
          child: const Text('Create account'),
          style: CustomButtons.blueButton(isFit: false),
        ),
      ],
    );
  }
}
