import 'package:flutter/material.dart';
import 'package:twitter/screens/welcome_screen/welcome_screen.dart';

import 'screens/auth_welcome_screen/auth_welcome_screen.dart';
import 'screens/signup_screen/signup_screen.dart';
import 'screens/login_email_screen/login_email_screen.dart';
import 'screens/login_password_screen/login_password_screen.dart';
import 'screens/verification_screen/verification_screen.dart';
import 'screens/timeline_screen/timeline_screen.dart';
import 'screens/profile_screen/profile_screen.dart';
import 'screens/password_screen/password_screen.dart';
import 'screens/profile_pic_screen/profile_pic_screen.dart';
import 'screens/bio_screen/bio_screen.dart';
import 'screens/username_screen/username_screen.dart';
import 'screens/profile_screen/edit_profile_screen.dart';
import 'screens/notifications_screen/NotificationsScreen.dart';
import 'screens/search_screen/SearchScreen.dart';
import 'screens/settings_screen/settings_screen.dart';

/// All app routes
Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  AuthWelcomeScreen.routeName: (context) => AuthWelcomeScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  LoginEmailScreen.routeName: (context) => LoginEmailScreen(),
  LoginPasswordScreen.routeName: (context) => LoginPasswordScreen(),
  TimelineScreen.routeName: (context) => TimelineScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  PasswordScreen.routeName: (context) => PasswordScreen(),
  ProfilePicScreen.routeName: (context) => ProfilePicScreen(),
  BioScreen.routeName: (context) => BioScreen(),
  UsernameScreen.routeName: (context) => UsernameScreen(),
  VerificationScreen.routeName: (context) => VerificationScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen()
};
