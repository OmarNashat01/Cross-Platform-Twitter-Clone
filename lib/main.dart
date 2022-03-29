// Dart packages

// Flutter packages
import 'package:flutter/material.dart';
import 'screens/welcome_screen/welcome_screen.dart';

// Other imports
import 'routes.dart';

void main() {
  runApp(TwitterApp());
}

class TwitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      theme: null,
      home: WelcomeScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
