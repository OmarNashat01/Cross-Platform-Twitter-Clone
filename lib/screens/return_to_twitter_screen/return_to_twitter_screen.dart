import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';

class ReturnToTwitterScreen extends StatefulWidget {
  static const routeName = '/return-to-twitter-screen';

  @override
  State<ReturnToTwitterScreen> createState() => ReturnToTwitterScreenState();
}

class ReturnToTwitterScreenState extends State<ReturnToTwitterScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBars.welcomeAppBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'You\'re all\nset. You\'ve\nsuccessfully\nchanged your\npassword.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue to Twitter'),
                style: CustomButtons.blueButton(isFit: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
