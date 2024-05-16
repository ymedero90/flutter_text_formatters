import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/capitalize_formatter.dart';

void main() {
  group('CapitalizeFormatter Tests', () {
    test('Should capitalize the first letter of each word', () {
      final formatter = CapitalizeFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'this is a test'),
      );

      expect(result.text, 'This Is A Test');
    });

    test('Should convert the rest of each word to lowercase when configured', () {
      final formatter = CapitalizeFormatter(convertRestToLowercase: true);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'tHiS IS aNOTher TeST'),
      );

      expect(result.text, 'This Is Another Test');
    });

    test('Should exclude specified words from capitalization', () {
      final formatter = CapitalizeFormatter(excludeWords: ['and', 'iOS', 'android']);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'android and iOS'),
      );

      expect(result.text, 'android and iOS');
    });

    test('Should handle empty input gracefully', () {
      final formatter = CapitalizeFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: ''),
      );

      expect(result.text, '');
    });

    test('Should not affect non-alphabetic characters', () {
      final formatter = CapitalizeFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123 !@#'),
      );

      expect(result.text, '123 !@#');
    });

    test('Should correctly capitalize words separated by multiple spaces', () {
      final formatter = CapitalizeFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'multiple    spaces'),
      );

      expect(result.text, 'Multiple    Spaces');
    });

    test('Should correctly capitalize words with custom delimiters', () {
      final formatter = CapitalizeFormatter(delimiter: '-');
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'custom-delimited-words'),
      );

      expect(result.text, 'Custom-Delimited-Words');
    });

    test('Should convert entirely uppercase words correctly when convertRestToLowercase is true', () {
      final formatter = CapitalizeFormatter(convertRestToLowercase: true);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'THIS IS TEST'),
      );

      expect(result.text, 'This Is Test');
    });

    test('Should correctly handle input starting with non-alphabetic characters', () {
      final formatter = CapitalizeFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123start with numbers'),
      );

      expect(result.text, '123start With Numbers');
    });
  });
}
