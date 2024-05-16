import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats input text into a specified phone number format.
///
/// This formatter ensures that the text input adheres to a specific phone number pattern,
/// making it useful for phone number fields where consistency and standardization are required.
///
/// ## Parameters
/// - [format]: A string specifying the desired phone number format. The formatter will
///   automatically add separators and placeholders (`X`) for digits.
///
/// ## Example
/// To use [PhoneNumberFormatFormatter] with a US phone number format, include it in the
/// `inputFormatters` property of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [
///     PhoneNumberFormatFormatter(format: '(XXX) XXX-XXXX'),
///   ],
/// )
/// ```
///
/// This example configures the formatter to enforce a phone number format of '(XXX) XXX-XXXX'.
class PhoneNumberFormatFormatter extends TextFormatterBase {
  final String format;

  PhoneNumberFormatFormatter({this.format = '(XXX) XXX-XXXX'});

  @override
  String applyFormat(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();
    int digitIndex = 0;

    bool shouldBreak = false;
    for (int i = 0; i < format.length; i++) {
      if (format[i] == 'X') {
        if (digitIndex < digitsOnly.length) {
          buffer.write(digitsOnly[digitIndex]);
          digitIndex++;
        } else {
          shouldBreak = true; // No more digits left to format.
        }
      } else {
        if (!shouldBreak || (shouldBreak && digitIndex > 0 && format[i] != 'X' && (i == 0 || format[i - 1] == 'X'))) {
          buffer.write(format[i]);
        }
      }
      if (shouldBreak && digitIndex == digitsOnly.length && i > 0 && format[i] == 'X') {
        break; // Stop if we've reached the end of the digits and the next character in the format is a placeholder.
      }
    }

    return buffer.toString();
  }
}
