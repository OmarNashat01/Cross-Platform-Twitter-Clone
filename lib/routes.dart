import 'package:flutter/material.dart';

import 'screens/auth_welcome_screen/auth_welcome_screen.dart';
import 'screens/signin_screen/signin_screen.dart';
import 'screens/signup_screen/signup_screen.dart';
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

Map<String, WidgetBuilder> routes = {
  AuthWelcomeScreen.routeName: (context) => AuthWelcomeScreen(),
  SigninScreen.routeName: (context) => SigninScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
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
};
