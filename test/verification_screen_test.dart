import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/verification_screen/verification_screen.dart';

void main() {
  final VerificationScreenState verificationScreenState =
      VerificationScreen().createElement().state as VerificationScreenState;

  group('verification Code Validation', () {
    test('Empty String', () {
      String dummy = '';
      String expected = 'Please enter the verification code.';
      expect(expected, verificationScreenState.validateVerificationCode(dummy));
    });

    test('Valid Code', () {
      String dummy = '5987';
      expect(null, verificationScreenState.validateVerificationCode(dummy));
    });
  });
}
