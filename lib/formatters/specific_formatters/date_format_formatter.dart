import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats input text into a specified date format.
///
/// This formatter ensures that the text input adheres to a specific date pattern, making it
/// useful for date fields where consistency and standardization of date format are required.
///
/// ## Parameters
/// - [dateFormat]: A string specifying the desired date format. The formatter will
///   automatically add separators (e.g., '/', '-') as the user types.
/// - [separator]: A character used to separate date components (e.g., '/', '-'). This should
///   match the separator used in the [dateFormat].
///
/// ## Example
/// To use [DateFormatFormatter] with custom configurations, include it in the `inputFormatters`
/// property of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [
///     DateFormatFormatter(
///       dateFormat: 'YYYY-MM-DD',
///       separator: '-',
///     ),
///   ],
/// )
/// ```
///
/// This example configures the formatter to enforce a date format of 'YYYY-MM-DD', using
/// '-' as the separator.
class DateFormatFormatter extends TextFormatterBase {
  final String dateFormat;
  final String separator;

  DateFormatFormatter({
    this.dateFormat = 'MM/DD/YYYY',
    this.separator = '/',
  });

  @override
  String applyFormat(String input) {
    // Remove all characters except digits.
    final digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');

    final buffer = StringBuffer();
    int length = digitsOnly.length;

    // Iterate through each character in the cleaned input.
    for (int i = 0; i < length; i++) {
      // Append the current digit.
      buffer.write(digitsOnly[i]);

      // After appending the month (2 digits), add the separator, but only if
      // it's not the final character or if exactly 2 characters have been input.
      if (i == 1 && length == 2) {
        // Checks if only the month has been input.
        buffer.write(separator);
        break; // No more formatting needed since we're only dealing with the month.
      } else if (i == 1 || i == 3) {
        // Positions after the month and day.
        // Append the separator if not at the end of the input.
        if (i != length - 1) {
          buffer.write(separator);
        }
      }
    }

    return buffer.toString();
  }
}
