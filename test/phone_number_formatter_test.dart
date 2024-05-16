import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/phone_number_formatter.dart';

void main() {
  group('PhoneNumberFormatFormatter Tests', () {
    final formatter = PhoneNumberFormatFormatter(format: '(XXX) XXX-XXXX');

    test('Formats short number correctly', () {
      const input = TextEditingValue(text: '123');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) ')); // Expecting partial format application
    });

    test('Formats full number correctly', () {
      const input = TextEditingValue(text: '1234567890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) 456-7890')); // Expecting complete format application
    });

    test('Ignores non-numeric characters', () {
      const input = TextEditingValue(text: 'abc123def456ghi7890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) 456-7890')); // Non-numeric characters should be removed
    });

    test('Handles input longer than format', () {
      const input = TextEditingValue(text: '12345678901234');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) 456-7890')); // Excess characters should be ignored
    });

    test('Formats with custom format', () {
      final customFormatter = PhoneNumberFormatFormatter(format: 'XX-XX-XXXX');
      const input = TextEditingValue(text: '12345678');
      final output = customFormatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12-34-5678')); // Custom format should be applied
    });
  });

  group('PhoneNumberFormatFormatter International Tests', () {
    test('Formats US phone number correctly', () {
      final formatter = PhoneNumberFormatFormatter(format: '(XXX) XXX-XXXX');
      const input = TextEditingValue(text: '1234567890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) 456-7890'));
    });

    test('Formats UK phone number correctly', () {
      final formatter = PhoneNumberFormatFormatter(format: '+44 XXXX XXXXXX');
      const input = TextEditingValue(text: '2034567890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('+44 2034 567890'));
    });

    test('Formats AU phone number correctly', () {
      final formatter = PhoneNumberFormatFormatter(format: '+61 X XXXX XXXX');
      const input = TextEditingValue(text: '412345678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('+61 4 1234 5678'));
    });

    test('Formats DE phone number correctly', () {
      final formatter = PhoneNumberFormatFormatter(format: '+49 XXXX XXXXXXX');
      const input = TextEditingValue(text: '3012345678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('+49 3012 345678'));
    });

    test('Formats CA phone number correctly', () {
      final formatter = PhoneNumberFormatFormatter(format: '(XXX) XXX-XXXX');
      const input = TextEditingValue(text: '1234567890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('(123) 456-7890')); // Same format as US
    });
  });
}
