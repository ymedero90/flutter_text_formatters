import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/credit_card_format_formatter.dart';

void main() {
  group('CreditCardFormatFormatter Tests', () {
    test('Formats using default pattern and separator', () {
      final formatter = CreditCardFormatFormatter();
      const input = TextEditingValue(text: '1234567812345678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('1234 5678 1234 5678')); // Default pattern
    });

    test('Respects custom placeholder and separator', () {
      final formatter = CreditCardFormatFormatter(
        formatPattern: '##-##-##-##-##-##-##-##',
        placeholder: '#',
        separator: '-',
      );
      const input = TextEditingValue(text: '1234567812345678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12-34-56-78-12-34-56-78')); // Custom pattern
    });

    test('Handles incomplete number correctly', () {
      final formatter = CreditCardFormatFormatter();
      const input = TextEditingValue(text: '1234');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('1234')); // Partial input without trailing separator
    });

    test('Removes non-numeric characters', () {
      final formatter = CreditCardFormatFormatter(
        formatPattern: '#### #### #### ####',
        placeholder: '#',
        separator: ' ',
      );
      const input = TextEditingValue(text: 'abcd1234efgh5678ijkl9012mnop3456');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('1234 5678 9012 3456')); // Cleansed input
    });

    test('Adapts to shorter custom formats', () {
      final formatter = CreditCardFormatFormatter(
        formatPattern: '####-####-####',
        placeholder: '#',
        separator: '-',
      );
      const input = TextEditingValue(text: '123456789012');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('1234-5678-9012')); // Shorter format
    });

    test('Exceeding format pattern length', () {
      final formatter = CreditCardFormatFormatter(
        formatPattern: '#### ####',
        placeholder: '#',
        separator: ' ',
      );
      const input = TextEditingValue(text: '1234567890123456');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      // Tests that formatter does not exceed defined format pattern
      expect(output.text, equals('1234 5678')); // Stops at the pattern's limit
    });
  });
}
