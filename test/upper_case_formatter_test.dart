import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/upper_case_formatter.dart';

void main() {
  group('UpperCaseFormatter Tests', () {
    final formatter = UpperCaseFormatter();

    test('Should convert lowercase letters to uppercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'lowercase'),
      );

      // Verify all uppercase letters are converted to uppercase.
      expect(result.text, 'LOWERCASE');
    });

    test('Should keep uppercase letters as uppercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'UPPERCASE'),
      );

      // Verify uppercase letters remain unchanged.
      expect(result.text, 'UPPERCASE');
    });

    test('Should handle mixed case letters by converting all to uppercase', () {
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'MiXeD CaSe'),
      );

      // Verify mixed case letters are all converted to uppercase.
      expect(result.text, 'MIXED CASE');
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
