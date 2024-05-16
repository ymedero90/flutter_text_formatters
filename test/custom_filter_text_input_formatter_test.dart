import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/custom_filter_text_input_formatter.dart';

void main() {
  group('CustomFilterTextInputFormatter Tests', () {
    test('Filters out specified characters', () {
      final formatter = CustomFilterTextInputFormatter(ignoreChars: ['b', 'c']);
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'abcde'),
      );
      expect(result.text, equals('ade'));
    });

    test('Filters out matches to the RegExp pattern', () {
      final formatter = CustomFilterTextInputFormatter(ignorePattern: RegExp(r'[aeiou]'));
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'abcde'),
      );
      expect(result.text, equals('bcd'));
    });
    test('Correctly handles empty input', () {
      final formatter = CustomFilterTextInputFormatter();
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: ''),
      );
      expect(result.text, equals(''));
    });

    test('Ignores non-matching characters when RegExp is provided', () {
      final formatter = CustomFilterTextInputFormatter(ignorePattern: RegExp(r'\d'));
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'Text without digits'),
      );
      expect(result.text, equals('Text without digits'));
    });

    test('Combines character list and RegExp pattern effectively', () {
      final formatter = CustomFilterTextInputFormatter(
        ignoreChars: ['x', 'y'],
        ignorePattern: RegExp(r'\d'),
      );
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '1x2y3 Text 4'),
      );
      expect(result.text, equals(' Tet '));
    });

    test('Maintains cursor position after filtering', () {
      final formatter = CustomFilterTextInputFormatter(ignoreChars: ['a']);
      const oldValue = TextEditingValue(text: 'Ja', selection: TextSelection.collapsed(offset: 2));
      const newValue = TextEditingValue(text: 'Java', selection: TextSelection.collapsed(offset: 4));
      final result = formatter.formatEditUpdate(oldValue, newValue);
      // Expected cursor position is at the end of "Jv" since "a" is filtered out.
      expect(result.selection.baseOffset, equals(2));
      expect(result.selection.extentOffset, equals(2));
    });

    test('Allows specified characters while filtering others with RegExp', () {
      final formatter = CustomFilterTextInputFormatter(
        ignoreChars: ['!'],
        ignorePattern: RegExp(r'[a-z]'),
      );
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'Hello World!'),
      );
      expect(result.text, equals('H W'));
    });

    test('Processes complex input with mixed allowed and disallowed characters', () {
      final formatter = CustomFilterTextInputFormatter(
        ignoreChars: ['?', '.', ','],
        ignorePattern: RegExp(r'[aeiou]'),
      );
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'A quick, brown fox jumps over the lazy dog.'),
      );
      // Expected to remove vowels, '?', '.', and ',' from the input text.
      expect(result.text, equals('A qck brwn fx jmps vr th lzy dg'));
    });
  });
}
