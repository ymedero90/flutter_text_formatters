import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that allows only digits to be entered.
///
/// This formatter filters out any non-digit character from the input,
/// allowing only numbers [0-9]. It's particularly useful for fields where
/// only numeric values are expected, such as phone numbers, PIN codes, etc.
///
/// ## Example
/// To use [DigitsOnlyFormatter], simply include it in the `inputFormatters` property
/// of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [DigitsOnlyFormatter()],
/// )
/// ```
class DigitsOnlyFormatter extends TextFormatterBase {
  @override
  String applyFormat(String input) {
    // Filter out any non-digit character.
    final String digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly;
  }

  @override
  TextSelection updateCursorPosition(
      String oldText, String newText, TextSelection newSelection, TextSelection oldSelection) {
    // Always positions the cursor at the end of the current text, regardless of addition or deletion operations.
    return newSelection;
  }
}
