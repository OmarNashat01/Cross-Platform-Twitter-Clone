import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/signup_screen/widgets/signup_form.dart';

void main() {
  final SignupFormState signupFormState =
      SignupForm().createElement().state as SignupFormState;

  group('NameValidation', () {
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

  group('EmailValidation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy));
    });
    test('InvalidEmail1', () {
      String dummy = 'ahmedmahmoud';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy));
    });
    test('InvalidEmail2', () {
      String dummy = 'ahmedmahmoud89@yousry';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy));
    });

    test('InvalidEmail3', () {
      String dummy = 'ahmedmahmoud89@yousry';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy));
    });

    test('InvalidEmail4', () {
      String dummy = 'ahmedmahmoud89@yousry..';
      String expected = 'Please enter a valid email.';
      expect(expected, signupFormState.validateEmail(dummy));
    });

    test('ValidEmail', () {
      String dummy = 'hazem.elaswad00@eng-st.cu.edu.eg';
      expect(null, signupFormState.validateName(dummy));
    });
  });
  group('DateOfBirthValidation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please enter your date of birth.';
      expect(expected, signupFormState.validateDob(dummy));
    });

    test('ValidDob', () {
      String dob = '2019-04-04 00:00:00.000';
      expect(null, signupFormState.validateName(dob));
    });
  });
}
