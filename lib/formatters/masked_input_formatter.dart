import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats input text based on a custom mask.
///
/// This formatter restricts and formats the entered text according to a specified pattern,
/// enhancing usability and consistency for fields that require formatted input, like postal codes,
/// phone numbers, or other identification numbers.
///
/// ## Parameters
/// - [mask]: The pattern defining the input format, using custom placeholders for characters.
///   For example, '###-##-####' can be used for U.S. SSNs.
/// - [placeholder]: A character used as a placeholder in the mask, representing input positions.
///   Defaults to '#'.
/// - [separator]: The character used to separate groups of characters in the formatted output.
///   This is optional and can be part of the mask itself.
class MaskedInputFormatter extends TextFormatterBase {
  final String mask;
  final String placeholder;
  final Map<String, RegExp> translations;

  MaskedInputFormatter(
    this.mask, {
    this.placeholder = '#',
    Map<String, RegExp>? translations,
  }) : translations = translations ??
            {
              '#': RegExp(r'[0-9]'), // Default placeholder for digits.
              'A': RegExp(r'[a-zA-Z]'), // Placeholder for letters.
              '*': RegExp(r'.') // Placeholder for any character.
              // Add more custom translations as needed.
            };

  @override
  String applyFormat(String input) {
    final buffer = StringBuffer();
    int inputIndex = 0;

    for (var i = 0; i < mask.length; i++) {
      if (inputIndex >= input.length) {
        break; // Stop if there's no more input to process.
      }
      var maskChar = mask[i];
      var inputChar = input[inputIndex];

      if (translations.containsKey(maskChar)) {
        var regex = translations[maskChar]!;
        if (regex.hasMatch(inputChar)) {
          buffer.write(inputChar); // Input matches the mask's requirement, add to buffer.
          inputIndex++;
        }
      } else {
        buffer.write(maskChar); // Mask character is a literal, add to buffer.
        if (maskChar == inputChar) {
          inputIndex++; // Literal matches input, consume this character.
        }
      }
    }

    return buffer.toString();
  }
}
