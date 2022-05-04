import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/constants.dart';
import 'package:twitter/services/users_services.dart';

import '../models/user_model.dart';

/// Holds user's data and utility functions to send API requests
class UserProvider with ChangeNotifier {
  String _id = '626551f44d5786f437cbb25b';
  String _name = '';
  String _email = '';
  String _dob = ''; //! must be in 'yyyy-mm-dd' format
  String _verificationCode = '';
  String _profilePic = ''; //! image local path, to be changed later
  String _username = '';
  String _password = '';
  String _bio = '';
  String _gender = ''; // 'M' or 'F'
  String _location = '';
  String _website = '';

  bool _isEmailTaken = false;
  bool _isUsernameTaken = false;

  set name(name) => _name = name;
  set email(email) => _email = email;
  set dob(dob) => _dob = dob;
  set verificationCode(code) => _verificationCode = code;
  set profilePic(pic) => _profilePic = pic;
  set username(name) => _username = name;
  set password(password) => _password = password;
  set bio(bio) => _bio = bio;
  set gender(gender) => _gender = gender; // 'M' | 'F'
  set location(location) => _location = location;
  set website(website) => _website = website;
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get dob => _dob;
  String get verificationCode => _verificationCode;
  String get profilePic => _profilePic;
  String get username => _username;
  String get password => _password;
  String get bio => _bio;
  String get gender => _gender;
  String get location => _location;
  String get website => _website;

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
    log(_dob);

    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/signup/verify'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({'email': _email}),
    );
    log(_email);

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
    LinkedHashMap<String, String> mapToFill = LinkedHashMap<String, String>();
    final general = LinkedHashMap<String, String>.from({
      'email': _email,
      'password': _password,
      'name': _name,
      'username': _username,
      'date_of_birth': _dob,
      'gender': _gender,
      'bio': _bio,
      'location': _location,
      'website': _website,
      // profilePic
    });
    general.forEach((key, value) {
      if (value.isNotEmpty)
        mapToFill[key] = value; //! should add empty values as null values
    });

    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/signup'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode(general /*mapToFill*/),
    );
    return response;
  }

  Future<http.Response> login() async {
    final response = await http.post(
      Uri.parse('http://${Http().getBaseUrl()}/Login/'),
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      body: jsonEncode({
        'email': _email,
        'password': _password,
      }),
    );
    return response;
  }

  void resetAll() {
    name = '';
    email = '';
    dob = ''; //! must be 'yyyy-mm-dd'
    verificationCode = '';
    profilePic = ''; //! image local path, to be changed later
    username = '';
    password = '';
    bio = '';
    gender = ''; // 'M' or 'F'
    location = '';
    website = '';
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

  Future<User> fetchUserByUserId(String userId) async {
    User user = await UsersApi().fetchUserByUserId(userId);
    return user;
    notifyListeners();
  }
}
