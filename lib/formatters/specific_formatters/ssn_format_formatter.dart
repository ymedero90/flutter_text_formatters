import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats social security numbers (SSNs) or similar identification numbers.
///
/// This formatter applies a specific pattern to the input, enhancing readability and consistency,
/// especially for fields requiring standardized ID formats. While designed with U.S. SSN format in mind,
/// it can be customized for other countries' standards.
///
/// ## Parameters
/// - [formatPattern]: The pattern defining the SSN format, using '#' as placeholders for digits.
///   Default is '###-##-####' for U.S. SSNs.
/// - [separator]: The character used to separate groups of digits in the formatted output.
///   Defaults to '-'.
/// - [allowOverflow]: A boolean that determines how the formatter handles input digits that exceed
///   the length specified by the `formatPattern`. When set to `false`, the formatter will strictly
///   adhere to the pattern and exclude any digits that exceed this limit, ensuring the output matches
///   the specified format pattern exactly. If set to `true`, the formatter allows additional digits
///   beyond the pattern's capacity to be appended directly to the end of the formatted string, accommodating
///   inputs that may not fit neatly into the defined pattern. This can be useful for custom formats
///   that might require flexibility in handling variable-length identification numbers. Defaults to `false`.
class SSNFormatFormatter extends TextFormatterBase {
  final String formatPattern;
  final String separator;
  final bool allowOverflow;

  SSNFormatFormatter({
    this.formatPattern = '###-##-####',
    this.separator = '-',
    this.allowOverflow = false,
  });

  @override
  String applyFormat(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    StringBuffer buffer = StringBuffer();
    int digitIndex = 0;
    int formatIndex = 0;

    // Itera a través del patrón de formato
    while (formatIndex < formatPattern.length && digitIndex < digitsOnly.length) {
      if (formatPattern[formatIndex] == '#') {
        buffer.write(digitsOnly[digitIndex]);
        digitIndex++;
      } else if (formatPattern[formatIndex] == separator) {
        if (buffer.isNotEmpty) buffer.write(separator);
      }
      formatIndex++;
    }

    // Si allowOverflow es verdadero y quedan dígitos, se agregan directamente.
    if (allowOverflow && digitIndex < digitsOnly.length) {
      while (digitIndex < digitsOnly.length) {
        buffer.write(digitsOnly[digitIndex]);
        digitIndex++;
      }
    }

    return buffer.toString();
  }
}
