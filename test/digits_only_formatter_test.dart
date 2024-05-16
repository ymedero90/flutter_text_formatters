import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/flutter_text_formatters.dart'; // Adjust the path according to your project structure

void main() {
  group('DigitsOnlyFormatter Tests', () {
    final digitsOnlyFormatter = DigitsOnlyFormatter();

    test('Should allow digit characters only', () {
      final result = digitsOnlyFormatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123abc456'),
      );

      // Only digits should remain in the result.
      expect(result.text, '123456');
    });

    test('Should handle empty input gracefully', () {
      final result = digitsOnlyFormatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: ''),
      );

      // The result should be an empty string if the input is also empty.
      expect(result.text, '');
    });

    test('Should remove all non-digit characters', () {
      final result = digitsOnlyFormatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '!@#\$%^&*()abc'),
      );

      // All non-digit characters should be removed.
      expect(result.text, '');
    });

    test('Cursor position should follow the last digit on addition', () {
      final result = digitsOnlyFormatter.formatEditUpdate(
        const TextEditingValue(text: '1234', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '12345', selection: TextSelection.collapsed(offset: 5)),
      );

      // The cursor position should be at the end of the text after adding a digit.
      expect(result.selection.baseOffset, 5);
      expect(result.selection.extentOffset, 5);
    });

    test('Cursor position should remain correct after deletion', () {
      final result = digitsOnlyFormatter.formatEditUpdate(
        const TextEditingValue(text: '12345', selection: TextSelection.collapsed(offset: 5)),
        const TextEditingValue(text: '1234', selection: TextSelection.collapsed(offset: 4)),
      );

      // The cursor position should adjust correctly after deleting a character.
      expect(result.selection.baseOffset, 4);
      expect(result.selection.extentOffset, 4);
    });
  });
}
