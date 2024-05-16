import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/date_format_formatter.dart';

void main() {
  group('DateFormatFormatter Tests', () {
    final formatter = DateFormatFormatter(dateFormat: 'MM/DD/YYYY', separator: '/');

    test('Correctly formats a partial date', () {
      const input = TextEditingValue(text: '12');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/')); // Expecting month part to be followed by a separator
    });

    test('Removes non-numeric characters', () {
      const input = TextEditingValue(text: '12a/34b/5678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/34/5678')); // Non-numeric characters should be removed
    });

    test('Handles complete date correctly', () {
      const input = TextEditingValue(text: '12312023');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/31/2023')); // Expecting complete date to be correctly formatted
    });

    test('Ignores invalid separators', () {
      const input = TextEditingValue(text: '12-31-2023');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/31/2023')); // Invalid '-' separators should be replaced with '/'
    });

    test('Limits month and day format', () {
      const input = TextEditingValue(text: '12312023');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/31/2023')); // Month and day should not exceed two digits
    });

    test('Handles incomplete year', () {
      const input = TextEditingValue(text: '12/31/23');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('12/31/23')); // Incomplete year should be allowed as is
    });
  });
}
