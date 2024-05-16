import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/max_value_text_input_formatter.dart';

void main() {
  group('MaxValueTextInputFormatter Tests', () {
    test('Allows numbers within the range', () {
      final formatter = MaxValueTextInputFormatter(minValue: 1, maxValue: 10);
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '5'),
      );
      expect(result.text, equals('5'));
    });

    test('Rejects numbers above the maximum', () {
      final formatter = MaxValueTextInputFormatter(minValue: 1, maxValue: 10);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '5'),
        const TextEditingValue(text: '15'),
      );
      expect(result.text, equals('5')); // Reverts to previous value
    });

    test('Allows empty input for correction', () {
      final formatter = MaxValueTextInputFormatter(minValue: 1, maxValue: 10);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: '5'),
        const TextEditingValue(text: ''),
      );
      expect(result.text, equals('')); // Allows empty for correction
    });

    test('Rejects non-numeric input', () {
      final formatter = MaxValueTextInputFormatter(minValue: 1, maxValue: 10);
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'abc'),
      );
      expect(result.text, isEmpty); // Non-numeric input is rejected
    });
  });
}
