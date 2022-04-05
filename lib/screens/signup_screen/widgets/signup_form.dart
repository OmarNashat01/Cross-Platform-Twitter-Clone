import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'next_button.dart';
import '../../../providers/user_provider.dart';

import '../../../constants.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _dateOfBirthFieldController = TextEditingController();

  String? validateName(value) {
    if (value.isEmpty) return 'Please enter your name.';
    return null;
  }

  String? validateEmail(value) {
    // Todo: add a validation to check whether the email has already been taken
    // if (exists(value)) return 'Email has already been taken.'

    if (!EmailValidator.validate(value)) return 'Please enter a valid email.';
    return null;
  }

  String? validateDob(value) {
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
                  autofocus: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  cursorWidth: 2,
                  maxLength: 50,
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                  controller: _nameFieldController,
                  onSaved: (name) =>
                      Provider.of<UserProvider>(context, listen: false).name =
                          name,
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
                  validator: validateEmail,
                  controller: _emailFieldController,
                  onSaved: (email) =>
                      Provider.of<UserProvider>(context, listen: false).email =
                          email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _decorateFields('Email'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 20),
                  readOnly: true,
                  validator: validateDob,
                  controller: _dateOfBirthFieldController,
                  onSaved: (dob) =>
                      Provider.of<UserProvider>(context, listen: false).dob =
                          DateFormat.yMMMd().parse(dob as String),
                  onTap: _showDatePicker,
                  decoration: _decorateFields('Date of birth'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: NextButton(_formKey),
          ),
        ],
      ),
    );
  }
}
