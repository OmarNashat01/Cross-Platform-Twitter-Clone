import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../signup_screen/signup_screen.dart';

import '../../../constants.dart';

class SignUpButtons extends StatelessWidget {
  
  void _switchToSignupScreen(context) {
    Navigator.of(context).pushNamed(SignupScreen.routeName);
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
          onPressed: () {},
          label: const Text(
            "Continue with Google",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: OutlinedButton.styleFrom(
            primary: Theme.of(context).colorScheme.onSurface,
            onSurface: Theme.of(context).colorScheme.surface,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        const Divider(
          color: Colors.black12,
          thickness: 1,
        ),
        ElevatedButton(
          onPressed: () => _switchToSignupScreen(context),
          child: const Text(
            "Create account",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
            onPrimary: Theme.of(context).colorScheme.onSecondary,
            minimumSize: const Size(double.infinity, 40),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    );
  }
}
