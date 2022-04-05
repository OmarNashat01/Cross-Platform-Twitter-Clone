import 'package:flutter_test/flutter_test.dart';

import 'package:twitter/screens/bio_screen/bio_screen.dart';

void main() {
  final BioScreenState bioScreenState =
      BioScreen().createElement().state as BioScreenState;

  group('BioValidation', () {
    test('EmptyString', () {
      String dummy = '';
      String expected = 'Please describe yourself, or you can just skip\n this for now';
      expect(expected, bioScreenState.validateBio(dummy));
    });
    test('ValidBio', () {
      String dummy = 'I am computer engineer at company x';
      expect(null, bioScreenState.validateBio(dummy));
    });
  });
}


