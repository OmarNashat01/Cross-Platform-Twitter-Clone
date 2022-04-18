import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bio_screen/bio_screen.dart';

import '../../providers/user_provider.dart';

import 'widgets/upload_image_button.dart';

import '../../themes.dart';
import '../../constants.dart';

class ProfilePicScreen extends StatefulWidget {
  static const routeName = '/profile-pic-screen';

  @override
  State<ProfilePicScreen> createState() => ProfilePicScreenState();
}

class ProfilePicScreenState extends State<ProfilePicScreen> {
  // String? validateBio(bio) {
  //   if (bio == null || bio.isEmpty) {
  //     return 'Please describe yourself, or you can just skip\n this for now';
  //   }
  //   return null;
  // }

  void _pressNextButton(context) {
    if (Provider.of<UserProvider>(context, listen: false).profilePic.isEmpty) {
      // Todo: add error msg
      return;
    }

    log('Pic: PASSED');
    Provider.of<UserProvider>(context, listen: false).signUp();
    Navigator.of(context).pushReplacementNamed(BioScreen.routeName);
  }

  void _pressSkipButton(context) {
    Provider.of<UserProvider>(context, listen: false).profilePic = '';
    Navigator.of(context).pushReplacementNamed(BioScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBars.welcomeAppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Pick a profile picture',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 25),
                      child: Text('Have a favorite selfie? Upload it now.'),
                    ),
                  ),
                  UploadImageButton(),
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
