import 'package:mockito/mockito.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/validators/validators.dart';
import 'package:test/test.dart';

class MockS extends Mock implements S {}

void main() {
  group('Verify Validator methods', () {
    final validators = Validators();
    test('Verify the functionality of the method that validates emails.', () {
      final email = 'psp@com';
      final isValidEmail = Validators.isValidEmail(email);
      expect(isValidEmail, false);
    });

    test('Verify the functionality of the method that validates emails.', () {
      final email = 'psp@mail.com';
      final isValidEmail = Validators.isValidEmail(email);
      expect(isValidEmail, true);
    });

    test('Verify the functionality of the method that validates passwords.',
        () {
      final password = 'passw';
      final isValidPassword = Validators.isValidPassword(password);
      expect(isValidPassword, false);
    });

    test('Verify the functionality of the method that validates passwords.',
        () {
      final password = 'password123';
      final isValidPassword = Validators.isValidPassword(password);
      expect(isValidPassword, true);
    });

    test('Verify the functionality of the method that validates phone numbers.',
        () {
      final phoneNumber = 'phoneNumber123';
      final isValidPhoneNumber = validators.isValidPhoneNumber(phoneNumber);
      expect(isValidPhoneNumber, false);
    });

    test('Verify the functionality of the method that validates phone numbers.',
        () {
      final phoneNumber = '3146432187';
      final isValidPhoneNumber = validators.isValidPhoneNumber(phoneNumber);
      expect(isValidPhoneNumber, true);
    });

    test(
        'Verify the functionality of the method that validates that a text is not empty.',
        () {
      final s = MockS();
      final text = '';

      when(s.inputRequiredError).thenReturn('This input is required');

      final isValidRequiredText = validators.validateRequiredInput(s, text);
      expect(isValidRequiredText, 'This input is required');
    });
    test(
        'Verify the functionality of the method that validates that a text is not empty.',
        () {
      final s = MockS();
      final text = 'text';

      when(s.inputRequiredError).thenReturn('This input is required');

      final isValidRequiredText = validators.validateRequiredInput(s, text);
      expect(isValidRequiredText, isNull);
    });
  });
}
