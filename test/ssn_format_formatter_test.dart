import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/ssn_format_formatter.dart';

void main() {
  group('SSNFormatFormatter Tests', () {
    final formatter = SSNFormatFormatter();

    test('Formats SSN correctly', () {
      const input = TextEditingValue(text: '123456789');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('123-45-6789')); // Standard SSN format
    });

    test('Handles partial SSN input correctly', () {
      const input = TextEditingValue(text: '123');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('123')); // Partial input without trailing separator
    });

    test('Removes non-numeric characters', () {
      const input = TextEditingValue(text: 'abc123-def-4567ghi89');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('123-45-6789')); // Cleansed and formatted input
    });

    test('Ignores excess digits beyond format pattern', () {
      const input = TextEditingValue(text: '1234567890');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('123-45-6789')); // Stops formatting at pattern's limit
    });

    test('Adapts to custom format patterns', () {
      final customFormatter = SSNFormatFormatter(formatPattern: '##-##-####', separator: '-', allowOverflow: true);
      const input = TextEditingValue(text: '123456789');
      final output = customFormatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12-34-56789')); // Custom format application
    });
  });
}
