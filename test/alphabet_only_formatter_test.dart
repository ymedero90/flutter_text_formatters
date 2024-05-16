import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/alphanumerics/alphabet_only_formatter.dart';

void main() {
  group('AlphabetOnlyFormatter Tests', () {
    test('Should allow alphabetic characters only, no spaces allowed', () {
      final formatter = AlphabetOnlyFormatter(allowSpaces: false);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'abc DEF ghi!@# 123'),
      );

      // Solo los caracteres alfabéticos deben permanecer, sin espacios.
      expect(result.text, 'abcDEFghi');
    });

    test('Should allow alphabetic characters and spaces when configured', () {
      final formatter = AlphabetOnlyFormatter(allowSpaces: true);
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: 'abc DEF ghi!@# 123'),
      );

      // Los caracteres alfabéticos y los espacios deben permanecer.
      expect(result.text, 'abc DEF ghi ');
    });

    test('Should handle empty input gracefully', () {
      final formatter = AlphabetOnlyFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: ''),
      );

      // El resultado debe ser una cadena vacía si la entrada también lo es.
      expect(result.text, '');
    });

    test('Should remove all non-alphabetic characters, including digits and symbols', () {
      final formatter = AlphabetOnlyFormatter();
      final result = formatter.formatEditUpdate(
        const TextEditingValue(text: ''),
        const TextEditingValue(text: '123!@#ABCxyz'),
      );

      // Todos los caracteres no alfabéticos deben ser eliminados.
      expect(result.text, 'ABCxyz');
    });

    // Agrega más pruebas según sea necesario para cubrir casos adicionales.
  });
}
