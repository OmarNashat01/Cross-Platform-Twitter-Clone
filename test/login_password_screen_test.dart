import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/login_password_screen/login_password_screen.dart';

void main() {
  final LoginPasswordScreenState loginPassScreenState =
      LoginPasswordScreen().createElement().state as LoginPasswordScreenState;

  group('Password Validation', () {
    test('Empty String', () {
      String dummy = '';
      String expected = 'Please enter your password.';
      expect(expected, loginPassScreenState.validatePassword(dummy));
    });

    test('Null String', () {
      String? dummy; // null
      String expected = 'Please enter your password.';
      expect(expected, loginPassScreenState.validatePassword(dummy));
    });

    test('Valid Password', () {
      String dummy = 'haz12356';
      expect(null, loginPassScreenState.validatePassword(dummy));
    });
  });
}
