import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/alphanumeric_formatter.dart';

void main() {
  group('Alphanumeric Formatter Tests', () {
    test('Should allow alphanumeric characters only, no spaces allowed', () {
      final formatter = AlphanumericFormatter(allowSpaces: false);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'abc123 DEF456 ghi789!@# \$%^&*()'),
      );

      // Only alphanumeric characters should remain, no spaces.
      expect(result.text, 'abc123DEF456ghi789');
    });

    test('Should allow alphanumeric characters and spaces when configured', () {
      final formatter = AlphanumericFormatter(allowSpaces: true);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'abc123 DEF456 ghi789!@# \$%^&*()'),
      );

      // Alphanumeric characters and spaces should remain.
      expect(result.text, 'abc123 DEF456 ghi789 ');
    });

    test('Should handle empty input gracefully', () {
      final formatter = AlphanumericFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: ''),
      );

      // The result should be an empty string if the input is also empty.
      expect(result.text, '');
    });

    test('Should remove all non-alphanumeric characters, including symbols', () {
      final formatter = AlphanumericFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '!@#\$%^&*()ABCxyz123'),
      );

      // All non-alphanumeric characters should be removed.
      expect(result.text, 'ABCxyz123');
    });

    // Add more tests as necessary to cover additional cases.
  });
}
