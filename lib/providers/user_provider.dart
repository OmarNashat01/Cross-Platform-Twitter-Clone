import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/constants.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  DateTime _dob = DateTime.now();
  String _verificationCode = '';
  String _profilePic = ''; //! image local path, to be changed later
  String _username = '';
  String _password = '';
  String _bio = '';

  bool _isEmailTaken = false;
  bool _isUsernameTaken = false;

  set name(name) => _name = name;
  set email(email) => _email = email;
  set dob(dob) => _dob = dob;
  set verificationCode(code) => _verificationCode = code;
  // if you need to set it without rerendering
  set profilePic(pic) => _profilePic = pic;
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

  bool get isEmailTaken => _isEmailTaken;
  bool get isUsernameTaken => _isUsernameTaken;

  void setProfilePic(pic) {
    _profilePic = pic;
    notifyListeners();
  }

  void setIsEmailTaken(check) {
    _isEmailTaken = check;
    notifyListeners();
  }

  void setIsUsernameTaken(check) {
    _isUsernameTaken = check;
    notifyListeners();
  }

  Future<http.Response> verifyEmail() async {
    log(_email);

    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/signup/verify'),
      body: {'email': _email},
    );
    return response;
  }

  Future<http.Response> verifyCode() async {
    log(_verificationCode);

    final queryParameters = {
      'OTP': _verificationCode,
      'email': _email,
    };
    final uri =
        Uri.http(Http().getBaseUrl(), '/signup/confirm_email', queryParameters);
    final response = await http.get(uri);
    return response;
  }

  Future<http.Response> signup() async {

    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/signup'),
      body: {
        "email": _email,
        "password": _password,
        "name": _name,
        "date_of_birth": _dob.toString(),
        "gender": "",
        "username": _username
      },
    );
    return response;
  }

  Future<http.Response> login() async {

    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/login'),
      body: {
        "email": _email,
        "password": _password,
      },
    );
    return response;
  }

  void logAll() {
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
