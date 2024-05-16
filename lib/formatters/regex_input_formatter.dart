import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// An input formatter that uses regular expressions to validate and format
/// input text according to complex patterns. Ideal for fields requiring
/// specific input formats, such as phone numbers, postal codes, etc.
///
/// ## Parameters
/// - [inputRegex]: A regular expression that defines the valid input pattern.
/// - [formatPattern]: An optional pattern that defines how the valid input text
///   should be formatted. If provided, the text will be formatted according to this pattern.
class RegExInputFormatter extends TextFormatterBase {
  final RegExp inputRegex;
  final String? formatPattern;

  RegExInputFormatter({
    required this.inputRegex,
    this.formatPattern,
  });

  @override
  String applyFormat(String input) {
    // First, validate if the input matches the regular expression.
    if (!inputRegex.hasMatch(input)) {
      // If the input is not valid, return empty or the original input as needed.
      return '';
    }

    // If a format pattern is provided, try to format the valid input.
    if (formatPattern != null) {
      final buffer = StringBuffer();
      int inputIndex = 0;

      // Iterate through the format pattern to apply formatting.
      for (var i = 0; i < formatPattern!.length && inputIndex < input.length; i++) {
        final patternChar = formatPattern![i];
        // If the pattern character is a placeholder for a digit or letter (e.g., '#'),
        // and there are available input characters, add the next input character.
        if (patternChar == '#' && inputIndex < input.length) {
          buffer.write(input[inputIndex]);
          inputIndex++;
        } else {
          // Otherwise, add the literal character from the format pattern to the buffer.
          buffer.write(patternChar);
        }
      }

      return buffer.toString();
    }

    // If no format pattern is provided, return the input as it is.
    return input;
  }
}
