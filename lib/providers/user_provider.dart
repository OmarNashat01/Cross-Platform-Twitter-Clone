import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  DateTime _dob = DateTime.now();
  String _password = '';
  String _bio = '';

  set name(name) => _name = name;
  set email(email) => _email = email;
  set dob(dob) => _dob = dob;
  set password(password) => _password = password;
  set bio(bio) => _bio = bio;

  String get name => _name;
  String get email => _email;
  DateTime get dob => _dob;
  String get password => _password;
  String get bio => _bio;

  // Todo: should save the data in the DB provided by the backend
  void signUp() {
    print(_name);
    print(_email);
    print(_dob);
    print(_password);
    print(_bio);
  }
}
