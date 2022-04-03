import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'signup_button.dart';

import '../../../constants.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _dateOfBirthFieldController = TextEditingController();


  String? _validateName(value) {
    if (value.isEmpty) return 'Please enter your name.';
    return null;
  }

  String? _validateEmail(value) {
    // TODO: add a validation to check whether the email is already been taken
    // if (exists(value)) return 'Email has already been taken.'

    if (!EmailValidator.validate(value)) return 'Please enter a valid email.';
    return null;
  }

  String? _validateDob(value) {
    if (value.isEmpty) return 'Please enter your date of birth.';
    return null;
  }

  _updateDate(DateTime date) {
    setState(() {
      _dateOfBirthFieldController.text = DateFormat.yMMMd().format(date);
    });
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: false,
      maxTime: DateTime.now(),
      minTime: DateTime(1900),
      onChanged: _updateDate,
      currentTime: _dateOfBirthFieldController.text == ''
          ? DateTime.now()
          : DateFormat.yMMMd().parse(_dateOfBirthFieldController.text),
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
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  cursorWidth: 2,
                  maxLength: 50,
                  textInputAction: TextInputAction.next,
                  validator: _validateName,
                  controller: _nameFieldController,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 20),
                  decoration: _decorateFields('Name'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  cursorWidth: 2,
                  style: const TextStyle(fontSize: 20),
                  validator: _validateEmail,
                  controller: _emailFieldController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decorateFields('Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 20),
                  readOnly: true,
                  validator: _validateDob,
                  controller: _dateOfBirthFieldController,
                  onTap: _showDatePicker,
                  decoration: _decorateFields('Date of birth'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SignUpButton(_formKey),
          ),
        ],
      ),
    );
  }
}
