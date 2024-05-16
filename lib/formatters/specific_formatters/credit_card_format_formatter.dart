import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats input text into a credit card number format.
/// Allows customization of the digit grouping pattern, the placeholder for digits,
/// and the separator between groups.
///
/// ## Parameters
/// - [formatPattern]: The pattern defining the grouping of digits, using a placeholder character.
/// - [placeholder]: The character used as a placeholder for digits in the [formatPattern].
/// - [separator]: The character used to separate groups of digits in the formatted output.
class CreditCardFormatFormatter extends TextFormatterBase {
  final String formatPattern;
  final String placeholder;
  final String separator;

  CreditCardFormatFormatter({
    this.formatPattern = '#### #### #### ####',
    this.placeholder = '#',
    this.separator = ' ',
  });

  @override
  String applyFormat(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();
    int digitIndex = 0;

    for (var i = 0; i < formatPattern.length && digitIndex < digitsOnly.length; i++) {
      // Replace placeholder with digit.
      if (formatPattern[i] == placeholder) {
        buffer.write(digitsOnly[digitIndex++]);
      } else {
        // Write non-placeholder format character (separator, etc.) to buffer.
        // We need to ensure it's not adding a separator unnecessarily.
        // Check if the current character and the next character in the format pattern are not placeholders,
        // which implies we're between digit groups, and only append the separator if more digits follow.
        if (i < formatPattern.length - 1 && formatPattern[i + 1] == placeholder && digitIndex < digitsOnly.length) {
          buffer.write(separator);
        }
      }
    }

    // The core issue was the formatter adding a space after exactly matching a group.
    // This removes any trailing separator that might have been incorrectly added.
    // This can happen if the input ends exactly at a group boundary.
    String formattedText = buffer.toString();
    if (formattedText.endsWith(separator)) {
      formattedText = formattedText.substring(0, formattedText.length - 1);
    }

    return formattedText;
  }
}
