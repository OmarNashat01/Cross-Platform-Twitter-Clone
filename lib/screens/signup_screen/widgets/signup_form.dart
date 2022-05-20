import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/themes.dart';

import 'signup_button.dart';
import '../../../providers/user_provider.dart';

import '../../../constants.dart';

/// Basic form for creating accounts that includes Name, Email and DOB
class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _dateOfBirthFieldController = TextEditingController();

  /// Proper validations for name field
  String? validateName(value) {
    if (value.isEmpty) return 'Please enter your name.';
    return null;
  }

  // Seperated to make unit testing work
  /// Check if the entered email is already taken or previously stored in the database
  bool isEmailTakenChecker() {
    return Provider.of<UserProvider>(context, listen: false).isEmailTaken;
  }

  /// Proper validations for email input field
  String? validateEmail(value, isEmailTaken) {
    if (isEmailTaken) {
      return 'Email has already been taken.';
    }

    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  /// Proper validations for dob input field
  String? validateDob(value) {
    if (value.isEmpty) return 'Please enter your date of birth.';
    return null;
  }

  _updateDate(DateTime date) {
    setState(() {
      _dateOfBirthFieldController.text = DateFormat.yMMMd().format(date);
    });
  }

  /// Handle Date Picker
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
                  cursorColor: kSecondaryColor,
                  cursorWidth: 2,
                  maxLength: 50,
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                  controller: _nameFieldController,
                  onSaved: (name) => userProvider.name = name,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 20),
                  decoration: FieldDecorations.normal('Name'),
                ),
                const SizedBox(height: 20),
                Consumer<UserProvider>(
                  builder: (context, value, child) => TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: kSecondaryColor,
                    cursorWidth: 2,
                    style: const TextStyle(fontSize: 20),
                    validator: (value) =>
                        validateEmail(value, isEmailTakenChecker()),
                    controller: _emailFieldController,
                    onSaved: (email) => value.email = email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: FieldDecorations.normal('Email'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 20),
                  readOnly: true,
                  validator: validateDob,
                  controller: _dateOfBirthFieldController,
                  onSaved: (dob) => userProvider.dob = DateFormat('yyyy-MM-dd')
                      .format(DateFormat.yMMMd().parse(dob as String)),
                  onTap: _showDatePicker,
                  decoration: FieldDecorations.normal('Date of birth'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SignupButton(_formKey),
          ),
        ],
      ),
    );
  }
}
