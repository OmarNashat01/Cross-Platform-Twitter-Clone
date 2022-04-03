import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class SigninScreen extends StatelessWidget {
  static const routeName = 'signin-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Screen'),
      ),
      body: const Center(
        child: Text("Signin Screen"),
      ),
    );
  }
}
