import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/lower_case_formatter.dart';

void main() {
  group('LowerCaseFormatter Tests', () {
    final formatter = LowerCaseFormatter();

    test('Should convert uppercase letters to lowercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'UPPERCASE'),
      );

      // Verify all uppercase letters are converted to lowercase.
      expect(result.text, 'uppercase');
    });

    test('Should keep lowercase letters as lowercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'lowercase'),
      );

      // Verify lowercase letters remain unchanged.
      expect(result.text, 'lowercase');
    });

    test('Should handle mixed case letters by converting all to lowercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'MiXeD CaSe'),
      );

      // Verify mixed case letters are all converted to lowercase.
      expect(result.text, 'mixed case');
    });

    test('Should handle empty input gracefully', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: ''),
      );

      // Verify the result is an empty string if the input is also empty.
      expect(result.text, '');
    });

    test('Should not affect non-alphabetic characters', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123 !@#'),
      );

      // Verify non-alphabetic characters remain unchanged.
      expect(result.text, '123 !@#');
    });
  });
}
