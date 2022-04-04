import 'package:flutter/material.dart';

import '../../themes.dart';
import '../../constants.dart';

class PasswordScreen extends StatelessWidget {
  static const routeName = '/password-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBars.welcomeAppBar,
      body: const Center(
        child: Text('Create Password'),
      ),
    );
  }
}
