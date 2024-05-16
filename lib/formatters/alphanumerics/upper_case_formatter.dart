import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that transforms all input text to uppercase.
///
/// This formatter converts every alphabetic character in the input to its uppercase equivalent,
/// allowing for consistent uppercase text entry. It's particularly useful for fields where
/// the data is expected to be in uppercase, such as certain codes, identifiers, or acronyms.
///
/// ## Example
/// To use [UpperCaseFormatter], simply include it in the `inputFormatters` property
/// of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [UpperCaseFormatter()],
/// )
/// ```
class UpperCaseFormatter extends TextFormatterBase {
  @override
  String applyFormat(String input) {
    // Convert and return the input text to uppercase.
    return input.toUpperCase();
  }

  @override
  TextSelection updateCursorPosition(
      String oldText, String newText, TextSelection newSelection, TextSelection oldSelection) {
    // Maintain natural cursor behavior by returning the new selection unchanged.
    return super.updateCursorPosition(oldText, newText, newSelection, oldSelection);
  }
}
