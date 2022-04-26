import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/login_email_screen/login_email_screen.dart';

void main() {
  final LoginEmailScreenState loginEmailScreenState =
      LoginEmailScreen().createElement().state as LoginEmailScreenState;

  group('Email Validation', () {
    test('Empty String', () {
      String dummy = '';
      String expected = 'Please enter your email.';
      expect(expected, loginEmailScreenState.validateEmail(dummy));
    });

    test('Null String', () {
      String? dummy; // null
      String expected = 'Please enter your email.';
      expect(expected, loginEmailScreenState.validateEmail(dummy));
    });

    test('Valid Email', () {
      String dummy = 'hazem.elaswad@gmail.com';
      expect(null, loginEmailScreenState.validateEmail(dummy));
    });
  });
}
