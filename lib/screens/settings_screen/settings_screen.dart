import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/auth_welcome_screen/auth_welcome_screen.dart';

import '../../constants.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-screen';

  Future<void> _pressLogoutButton(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.resetAll();
    Auth.token = '';
    Auth.userId = '';
    Auth.email = '';
    Auth.password = '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.of(context)
      ..pop()
      ..pushReplacementNamed(AuthWelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Account information'),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () => _pressLogoutButton(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: const [
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 206, 55, 44),
                    ),
                  ),
                ],
              ),
            ),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blueGrey.shade100),
            ),
          ),
        ],
      ),
    );
  }
}
