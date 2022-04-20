import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  DateTime _dob = DateTime.now();
  String _verificationCode = '';
  String _profilePic = ''; //! image local path, to be changed later
  String _username = '';
  String _password = '';
  String _bio = '';

  set name(name) => _name = name;
  set email(email) => _email = email;
  set dob(dob) => _dob = dob;
  set verificationCode(code) => _verificationCode = code;
  set profilePic(pic) =>
      _profilePic = pic; // if you need to set it without rerendering
  set username(name) => _username = name;
  set password(password) => _password = password;
  set bio(bio) => _bio = bio;

  String get name => _name;
  String get email => _email;
  DateTime get dob => _dob;
  String get verificationCode => _verificationCode;
  String get profilePic => _profilePic;
  String get username => _username;
  String get password => _password;

  void setProfilePic(pic) {
    _profilePic = pic;
    notifyListeners();
  }

  // Todo: Send the email to the backend for verification and OTP
  Future<http.Response> verifyEmail() async {
    log(_email);

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/verify/$_email'),
    );
    return response;
  }

  // Todo: Send the verification code (OTP) and email to the backend
  void verifyCode() {
    log(_verificationCode);
  }

  // Todo: Send the username to the backend to check its existance
  void verifyUsername() {
    log(_username);
  }

  // Todo: Send basic user data to the backend
  void signUp() {
    log('name: $_name');
    log('email: $_email');
    log('dob: ${_dob.toString()}');
    log('code: $_verificationCode');
    log('pic path: $_profilePic');
    log('username: $_username');
    log('pass: $_password');
    log('bio: $_bio');
  }
}
