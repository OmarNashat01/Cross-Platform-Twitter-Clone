import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

import '../../themes.dart';
import '../../constants.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const routeName = '/update-password-screen';

  @override
  State<UpdatePasswordScreen> createState() => UpdatePasswordScreenState();
}

class UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _isObsecure1 = true;
  bool _isObsecure2 = true;
  bool _isObsecure3 = true;

  final _formKey = GlobalKey<FormState>();

  final _passwordFieldController1 = TextEditingController();
  final _passwordFieldController2 = TextEditingController();
  final _passwordFieldController3 = TextEditingController();

  String? validatePassword1(pass) {
    if (pass == null || pass.isEmpty || pass.length < 8) {
      return '';
    }
    if (pass != Auth.password) {
      return 'Your old password was entered incorrectly, please enter it again.';
    }
    return null;
  }

  String? validatePassword2(pass) {
    if (pass == null || pass.isEmpty || pass.length < 8) {
      return 'Your password needs to be at least 8 characters.\nPlease enter a longer one.';
    }
    if (pass == _passwordFieldController1.text) {
      return 'New password cannot be same as the old password.';
    }
    return null;
  }

  String? validatePassword3(pass) {
    if (pass == null ||
        pass.isEmpty ||
        pass != _passwordFieldController2.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  void _pressUpdatePasswordButton(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      log('update Password PASSED');
      _formKey.currentState!
          .save(); //? Password and new Password are saved in user provider

      userProvider.updatePassword().then((res) async {
        if (res.statusCode == 200) {
          // TODO: add snack bar for successful update
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Your password has been updated successfully'),
          ));
          log('Updated successfully');
          Navigator.of(context).pop();
        } else if (res.statusCode == 406) {
          //todo: it should check for the current password if it is entered successfully
          log('Bad: Old password entered ');
        } else {
          log('Bad: Unauthorized ');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Server is down, please try again later.'),
          ));
          Navigator.of(context).pop();
        }
      });
    } else {
      log('update Password FAILED');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Update password'),
            Text(
              '@${Auth.username}',
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          obscureText: _isObsecure1,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword1,
                          controller: _passwordFieldController1,
                          onSaved: (pass) =>
                              userProvider.password = hashToMd5(pass as String),
                          onFieldSubmitted: (_) =>
                              _pressUpdatePasswordButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIconAndLabel(
                            'Current password',
                            '',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure1 = !_isObsecure1),
                              icon: Icon(
                                _isObsecure1
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: _isObsecure2,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword2,
                          controller: _passwordFieldController2,
                          onSaved: (newPass) => userProvider.newPassword =
                              hashToMd5(newPass as String),
                          onFieldSubmitted: (_) =>
                              _pressUpdatePasswordButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIconAndLabel(
                            'New password',
                            'At least 8 characters',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure2 = !_isObsecure2),
                              icon: Icon(
                                _isObsecure2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: _isObsecure3,
                          cursorColor: kSecondaryColor,
                          cursorWidth: 2,
                          style: const TextStyle(fontSize: 20),
                          validator: validatePassword3,
                          controller: _passwordFieldController3,
                          onFieldSubmitted: (_) =>
                              _pressUpdatePasswordButton(context),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: FieldDecorations.normalWithIconAndLabel(
                            'Confirm password',
                            'At least 8 characters',
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isObsecure3 = !_isObsecure3),
                              icon: Icon(
                                _isObsecure3
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pressUpdatePasswordButton(context),
                      style: CustomButtons.blueButton(),
                      child: const Text('Update password'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
