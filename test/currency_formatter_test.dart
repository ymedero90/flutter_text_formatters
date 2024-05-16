import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/currency_formatter.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('Default formatter settings', () {
      final formatter = CurrencyFormatter();
      const input = TextEditingValue(text: '1234567.89');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$1,234,567.89'));
    });

    test('Custom currency symbol and thousands separator', () {
      final formatter = CurrencyFormatter(currencySymbol: '€', thousandsSeparator: ' ');
      const input = TextEditingValue(text: '1234567.89');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('€1 234 567.89'));
    });

    test('No thousands separator with custom decimal separator', () {
      final formatter = CurrencyFormatter(useThousandsSeparator: false, decimalSeparator: ',');
      const input = TextEditingValue(text: '1234.5678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$1234,56')); // Assuming rounding down and 2 decimal places
    });

    test('Custom decimal places', () {
      final formatter = CurrencyFormatter(decimalPlaces: 3);
      const input = TextEditingValue(text: '1234.5678');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$1,234.567')); // Rounding not implemented, so it truncates
    });

    test('Leading decimal point with custom decimal places', () {
      final formatter = CurrencyFormatter(decimalPlaces: 1);
      const input = TextEditingValue(text: '.99');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$0.9')); // Truncating to 1 decimal place
    });

    test('Removes non-numeric characters', () {
      final formatter = CurrencyFormatter();
      const input = TextEditingValue(text: '1,2a3b4c5');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$12,345.00')); // Correct expectation
    });

    test('Handles empty string', () {
      final formatter = CurrencyFormatter();
      const input = TextEditingValue(text: '');
      final output = formatter.formatEditUpdate(TextEditingValue.empty, input);
      expect(output.text, equals('\$0.00'));
    });
  });
}
