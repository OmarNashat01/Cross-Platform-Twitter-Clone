import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../signup_screen/signup_screen.dart';

import '../../../themes.dart';
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
