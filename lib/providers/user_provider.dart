import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  DateTime _dob = DateTime.now();
  String _verificationCode = '';
  String _password = '';
  String _bio = '';

  set name(name) => _name = name;
  set email(email) => _email = email;
  set dob(dob) => _dob = dob;
  set verificationCode(code) => _verificationCode = code;
  set password(password) => _password = password;
  set bio(bio) => _bio = bio;

  String get name => _name;
  String get email => _email;
  DateTime get dob => _dob;
  String get verificationCode => _verificationCode;
  String get password => _password;
  String get bio => _bio;

  // Todo: Send the email to the backend for verification and OTP
  void verifyEmail() {
    print(_email);
  }

  // Todo: Send the verification code (OTP) and email to the backend
  void verifyCode() {
    print(_verificationCode);
  }

  // Todo: Send basic user data to the backend
  void signUp() {
    print(_name);
    print(_email);
    print(_dob);
    print(_verificationCode);
    print(_password);
    print(_bio);
  }
}
