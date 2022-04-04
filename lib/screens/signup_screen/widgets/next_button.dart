import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../password_screen/password_screen.dart';


import '../../../themes.dart';
import '../../../constants.dart';

class NextButton extends StatelessWidget {
  final _formKey;
  const NextButton(this._formKey);

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('passed');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).save();
      Navigator.of(context).pushNamed(PasswordScreen.routeName);
    } else {
      log('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => _pressNextButton(context),
        style: CustomButtons.blackButton(),
        child: const Text('Next'),
      ),
    );
  }
}
