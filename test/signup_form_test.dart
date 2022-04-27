import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/signup_screen/widgets/signup_form.dart';

void main() {
  final SignupFormState signupFormState =
      SignupForm().createElement().state as SignupFormState;

  group('Name Validation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please enter your name.';
      expect(expected, signupFormState.validateName(dummy));
    });
    test('ValidName', () {
      String dummy = 'hazem tarek 22';
      expect(null, signupFormState.validateName(dummy));
    });
  });

  group('Email Validation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy, false));
    });
    test('Invalid Email1', () {
      String dummy = 'ahmedmahmoud';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy, false));
    });
    test('Invalid Email2', () {
      String dummy = 'ahmedmahmoud89@yousry';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy, false));
    });

    test('Invalid Email3', () {
      String dummy = 'ahmedmahmoud89@yousry';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy, false));
    });

    test('Invalid Email4', () {
      String dummy = 'ahmedmahmoud89@yousry..';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy, false));
    });

    test('Email Taken', () {
      String dummy = 'hazem.elaswad00@eng-st.cu.edu.eg';
      String expected = 'Email has already been taken.';
      expect(expected, signupFormState.validateEmail(dummy, true));
    });

    test('Valid Email', () {
      String dummy = 'hazem.elaswad00@eng-st.cu.edu.eg';
      expect(null, signupFormState.validateEmail(dummy, false));
    });
  });
  group('DateOfBirth Validation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please enter your date of birth.';
      expect(expected, signupFormState.validateDob(dummy));
    });

    test('ValidDob', () {
      String dob = '2019-04-04';
      expect(null, signupFormState.validateDob(dob));
    });
  });
}
