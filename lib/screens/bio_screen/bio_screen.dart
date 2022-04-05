import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class BioScreen extends StatefulWidget {
  static const routeName = '/bio-screen';

  @override
  State<BioScreen> createState() => BioScreenState();
}

class BioScreenState extends State<BioScreen> {
  final _formKey = GlobalKey<FormState>();

  final bioFieldController = TextEditingController();

  String? validateBio(bio) {
    if (bio == null || bio.isEmpty) {
      return 'Please describe yourself, or you can just skip\n this for now';
    }
    return null;
  }

  void _pressNextButton(context) {
    if (_formKey.currentState!.validate()) {
      log('passed');
      _formKey.currentState!.save();
      Provider.of<UserProvider>(context, listen: false).signUp();
    } else {
      log('failed');
    }
  }

  void _pressSkipButton(context) {
    // Todo: skip by navigating to the "@username" screen
  }

  InputDecoration _decorateBioField(String hint) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBars.welcomeAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Describe yourself',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 25),
                    child: Text('What makes you special? Don\'t think too hard, just have fun with it.'),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      cursorWidth: 2,
                      maxLength: 160,
                      style: const TextStyle(fontSize: 20),
                      validator: validateBio,
                      controller: bioFieldController,
                      onSaved: (bio) =>
                          Provider.of<UserProvider>(context, listen: false)
                              .bio = bio, 
                      onFieldSubmitted: (_) => _pressNextButton(context),
                      decoration: _decorateBioField('Your bio'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => _pressSkipButton(context),
                      style: CustomButtons.whiteButton(),
                      child: const Text('Skip for now'),
                    ),
                    ElevatedButton(
                      onPressed: () => _pressNextButton(context),
                      style: CustomButtons.blackButton(),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
