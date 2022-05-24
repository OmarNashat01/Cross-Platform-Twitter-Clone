

import 'package:flutter/material.dart';
import 'package:twitter/screens/others_profile_screen/others_profile_screen.dart';
import 'package:twitter/screens/search_results_screen/search_results_screen.dart';
import 'package:twitter/screens/welcome_screen/welcome_screen.dart';

import 'screens/auth_welcome_screen/auth_welcome_screen.dart';
import 'screens/signup_screen/signup_screen.dart';
import 'screens/login_email_screen/login_email_screen.dart';
import 'screens/login_password_screen/login_password_screen.dart';
import 'screens/forgot_password_screen/forgot_password_screen.dart';
import 'screens/return_to_twitter_screen/return_to_twitter_screen.dart';
import 'screens/update_password_screen/UpdatePasswordScreen.dart';
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
import 'screens/forgot_pass_email_screen/forgot_pass_email_screen.dart';
import 'screens/forgot_pass_otp_screen/forgot_pass_otp_screen.dart';

/// All app routes
Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  AuthWelcomeScreen.routeName: (context) => AuthWelcomeScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  LoginEmailScreen.routeName: (context) => LoginEmailScreen(),
  LoginPasswordScreen.routeName: (context) => LoginPasswordScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ReturnToTwitterScreen.routeName: (context) => ReturnToTwitterScreen(),
  UpdatePasswordScreen.routeName: (context) => UpdatePasswordScreen(),
  TimelineScreen.routeName: (context) => TimelineScreen(firstTime: true,),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  PasswordScreen.routeName: (context) => PasswordScreen(),
  ProfilePicScreen.routeName: (context) => ProfilePicScreen(),
  BioScreen.routeName: (context) => BioScreen(),
  UsernameScreen.routeName: (context) => UsernameScreen(),
  VerificationScreen.routeName: (context) => VerificationScreen(),
  NotificationsScreen.routeName: (context) => NotificationsScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  ForgotPassEmailScreen.routeName: (context) => ForgotPassEmailScreen(),
  ForgotPassOtpScreen.routeName: (context) => ForgotPassOtpScreen(),
  OthersProfileScreen.routeName: (context) => OthersProfileScreen(),
  SearchResultsScreen.routeName: (context) => SearchResultsScreen()
};
