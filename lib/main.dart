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
      theme: ThemeData(
        backgroundColor: Colors.white,
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
      home: WelcomeScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
