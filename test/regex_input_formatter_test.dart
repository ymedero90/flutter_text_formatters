import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/regex_input_formatter.dart';

void main() {
  group('RegExInputFormatter Tests', () {
    test('Allows valid input based on regex', () {
      final regexFormatter = RegExInputFormatter(
        inputRegex: RegExp(r'^\d{3}-\d{2}-\d{4}$'), // Formato SSN de EE.UU.
      );
      final result = regexFormatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '123-45-6789'),
      );
      expect(result.text, equals('123-45-6789'));
    });

    test('Rejects invalid input based on regex', () {
      final regexFormatter = RegExInputFormatter(
        inputRegex: RegExp(r'^\d{3}-\d{2}-\d{4}$'), // Formato SSN de EE.UU.
      );
      final result = regexFormatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: 'abc-de-fghi'),
      );
      expect(result.text, isEmpty); // La entrada no coincide con la regex, se espera una cadena vacía.
    });

    test('Applies format pattern to valid input', () {
      final regexFormatter = RegExInputFormatter(
        inputRegex: RegExp(r'^\d+$'), // Solo dígitos.
        formatPattern: '###-##-####', // Formato de patrón específico.
      );
      final result = regexFormatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '123456789'),
      );
      expect(result.text, equals('123-45-6789')); // Aplica el formato al input válido.
    });

    test('Handles partial input for format pattern', () {
      final regexFormatter = RegExInputFormatter(
        inputRegex: RegExp(r'^\d+$'), // Solo dígitos.
        formatPattern: '###-###-####', // Formato de patrón específico.
      );
      final result = regexFormatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '12345'),
      );
      expect(result.text, equals('123-45')); // Aplica el formato al input parcial.
    });
  });
}
