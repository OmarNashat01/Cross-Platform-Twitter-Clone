import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/username_screen/username_screen.dart';

void main() {
  final UsernameScreenState usernameScreenState =
      UsernameScreen().createElement().state as UsernameScreenState;

  group('Username Validation', () {
    test('Empty String', () {
      String dummy = '';
      String expected = 'Username should be more than 4 characters.';
      expect(expected, usernameScreenState.validateUsername(dummy, false));
    });

    test('Null String', () {
      String? dummy; // null
      String expected = 'Username should be more than 4 characters.';
      expect(expected, usernameScreenState.validateUsername(dummy, false));
    });

    test('Invalid Length String', () {
      String dummy = 'haz2';
      String expected = 'Username should be more than 4 characters.';
      expect(expected, usernameScreenState.validateUsername(dummy, false));
    });

    test('Taken Username', () {
      String dummy = 'haz52';
      String expected = 'Username has already been taken';
      expect(expected, usernameScreenState.validateUsername(dummy, true));
    });

    test('Valid Username', () {
      String dummy = 'haz52';
      expect(null, usernameScreenState.validateUsername(dummy, false));
    });
  });
}
