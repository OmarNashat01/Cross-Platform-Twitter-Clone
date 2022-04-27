import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/password_screen/password_screen.dart';

void main() {
  final PasswordScreenState passwordScreenState =
      PasswordScreen().createElement().state as PasswordScreenState;

  group('PasswordValidation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Your password needs to be at least 8 characters.\nPlease enter a longer one.';
      expect(expected, passwordScreenState.validatePassword(dummy));
    });
    test('InvalidLength', () {
      String dummy = 'dfdqo[v';
      String expected = 'Your password needs to be at least 8 characters.\nPlease enter a longer one.';
      expect(expected, passwordScreenState.validatePassword(dummy));
    });
    test('ValidPassword', () {
      String dummy = '87ekql[q';
      expect(null, passwordScreenState.validatePassword(dummy));
    });
  });
}
