import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/masked_input_formatter.dart';

void main() {
  group('MaskedInputFormatter Tests', () {
    test('Applies mask correctly for phone number', () {
      final formatter = MaskedInputFormatter('###-###-####', translations: {'#': RegExp(r'[0-9]')});
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '1234567890'),
      );
      expect(result.text, equals('123-456-7890'));
    });

    test('Ignores invalid characters according to mask', () {
      final formatter =
          MaskedInputFormatter('###-A##', translations: {'#': RegExp(r'[0-9]'), 'A': RegExp(r'[a-zA-Z]')});
      final result = formatter.formatEditUpdate(TextEditingValue.empty, const TextEditingValue(text: '12a45'));
      expect(result.text, equals('12-a45'));
    });

    test('Handles partial input gracefully', () {
      final formatter = MaskedInputFormatter('###-###-####', translations: {'#': RegExp(r'[0-9]')});
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '123'),
      );
      expect(result.text, equals('123'));
    });

    test('Excludes characters beyond the mask', () {
      final formatter = MaskedInputFormatter('###-###', translations: {'#': RegExp(r'[0-9]')});
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '1234567'),
      );
      expect(result.text, equals('123-456'));
    });

    test('Accepts complex patterns with mixed placeholders', () {
      final formatter = MaskedInputFormatter('AA-999-*',
          translations: {'A': RegExp(r'[a-zA-Z]'), '9': RegExp(r'[0-9]'), '*': RegExp(r'.')});
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'AB123X'),
      );
      expect(result.text, equals('AB-123-X'));
    });
  });
}
