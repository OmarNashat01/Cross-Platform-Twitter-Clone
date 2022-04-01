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
      title: 'Twitter',
      theme: ThemeData(
        //color for scrollbar
          highlightColor: Color(0xff757575)
      ),
      home: Timeline(),
      routes: {
        SigninScreen.routeName: (context) => SigninScreen(),
        Timeline.routeName: (context) => Timeline(),
        ProfileScreen.routeName:(context)=>ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
