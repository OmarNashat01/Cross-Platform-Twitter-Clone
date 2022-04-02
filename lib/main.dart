// Dart packages

// Flutter packages
import 'package:flutter/material.dart';
import 'screens/welcome_screen/welcome_screen.dart';
import 'screens/timeline_screen/timeline.dart';
import 'screens/signin_screen/signin_screen.dart';
import 'screens/profile_screen/profile_screen.dart';
// Other imports
import 'routes.dart';

void main() {
  runApp(TwitterApp());
}

class TwitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Twitter',
      theme: ThemeData(
        backgroundColor: Colors.white,
        highlightColor: Color(0xff757575),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Color(0xFF1D9BF0),
          onSecondary: Colors.white,
          error: Colors.white,
          onError: Colors.redAccent,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: Timeline(),
      routes: routes,
    );
  }
}
