import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Sign up Screen'),
      ),
      body: const Center(
        child: Text("Sign up Screen"),
      ),
    );
  }
}
