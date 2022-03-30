// Dart packages

// Flutter packages
import 'package:flutter/material.dart';
import 'screens/welcome_screen/welcome_screen.dart';
import 'screens/timeline_screen/timeline.dart';

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
      home: Timeline(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
