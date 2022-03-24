// Dart packages

// Flutter packages
import 'package:flutter/material.dart';

// Other imports
import 'routes.dart'
void main() {
  runApp(TwitterApp());
}

class TwitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      theme: null,
      initialRoute: null,
      routes: routes,
    );
  }
}