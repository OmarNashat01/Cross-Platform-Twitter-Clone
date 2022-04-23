import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/providers/user_provider.dart';

import '../auth_welcome_screen/auth_welcome_screen.dart';
import '../timeline_screen/timeline_screen.dart';

import '../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _switchToAuthWelcomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed(AuthWelcomeScreen.routeName);
  }

  void _switchToTimelineScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed(TimelineScreen.routeName);
  }

  void _checkAndSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAlreadyLoggedIn = (prefs.getString('email') != null);

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (!isAlreadyLoggedIn) {
      _switchToAuthWelcomeScreen();
      return;
    }
    userProvider
      ..email = prefs.getString('email')
      ..password = prefs.getString('password')
      ..login().then((res) {
        switch (res.statusCode) {
          case 200: // User exists (success)
            final response = jsonDecode(res.body);
            Auth.email = userProvider.email;
            Auth.password = userProvider.password;
            Auth.token = response['token'];
            Auth.userId = response['user_id'];

            log('token : ${Auth.token}');
            log('userid : ${Auth.userId}');
            log('email : ${Auth.email}');
            log('password : ${Auth.password}');
            break;
          case 400: // Wrong password
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wrong password!'),
            ));
            userProvider.email = '';
            userProvider.password = '';

            break;
          default: // status code 401 (user doesn't exist)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Sorry, we could not find your account.'),
            ));
            userProvider.email = '';
            userProvider.password = '';
            break;
        }
      });
    _switchToTimelineScreen();
  }

  @override
  void initState() {
    super.initState();
    _checkAndSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
          child: SvgPicture.asset(
            kLogoPath,
            color: kOnSecondaryColor,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
