import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateOfBirth = TextEditingController();

  //! is to be changed
  String? _validateName(value) {}

  String? _validateEmail(value) {
    // TODO: add a validation to check whether the email is already been taken
    // if (exists(value)) return 'Email has already been taken.'

    if (value.isEmpty) return null;
    if (!EmailValidator.validate(value)) return 'Please enter a valid email.';
    return null;
  }

  String? _validateDob(value) {}

  _updateDate(DateTime date) {
    setState(() {
      _dateOfBirth.text = DateFormat.yMMMd().format(date);
    });
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      maxTime: DateTime.now(),
      minTime: DateTime(1900),
      onChanged: _updateDate,
      currentTime: _dateOfBirth.text == ''
          ? DateTime.now()
          : DateFormat.yMMMd().parse(_dateOfBirth.text),
      onConfirm: null,
    );
  }

  InputDecoration _decorateFields(String hint) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            cursorWidth: 2,
            maxLength: 50,
            validator: _validateName,
            keyboardType: TextInputType.name,
            style: const TextStyle(fontSize: 20),
            decoration: _decorateFields('Name'),
          ),
          const SizedBox(height: 20),

          TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            cursorWidth: 2,
            style: const TextStyle(fontSize: 20),
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: _decorateFields('Email'),
          ),
          const SizedBox(height: 20),

          TextFormField(
            style: const TextStyle(fontSize: 20),
            readOnly: true,
            validator: _validateDob,
            controller: _dateOfBirth,
            onTap: _showDatePicker,
            decoration: _decorateFields('Date of birth'),
          ),

          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {}
          //   },
          //   child: Text('Sign Up'),
          // ),
        ],
      ),
    );
  }
}
