import 'package:flutter/material.dart';

import 'screens/auth_welcome_screen/auth_welcome_screen.dart';
import 'screens/signin_screen/signin_screen.dart';
import 'screens/signup_screen/signup_screen.dart';

Map<String, WidgetBuilder> routes = {
  AuthWelcomeScreen.routeName: (context) => AuthWelcomeScreen(),
  SigninScreen.routeName: (context) => SigninScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
};
