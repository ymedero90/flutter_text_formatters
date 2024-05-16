import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that allows only alphanumeric characters to be entered.
///
/// This formatter filters out any character that is not an alphabetic letter or a digit
/// from the input, allowing only letters (both uppercase and lowercase) and numbers [0-9].
/// Optionally, spaces can be allowed if the `allowSpaces` flag is set to true. This is
/// particularly useful for fields where identifiers, codes, or other mixed data types are expected.
///
/// ## Parameters
/// [allowSpaces] - A boolean value that controls whether spaces are allowed in the input.
///
/// ## Example
/// To use [AlphanumericFormatter] and optionally allow spaces, include it in the
/// `inputFormatters` property of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [AlphanumericFormatter(allowSpaces: true)], // Or false to disallow spaces
/// )
/// ```
class AlphanumericFormatter extends TextFormatterBase {
  final bool allowSpaces;

  AlphanumericFormatter({this.allowSpaces = false});

  @override
  String applyFormat(String input) {
    // If allowSpaces is true, include space in the allowed characters.
    final String pattern = allowSpaces ? r'[^a-zA-Z0-9 ]' : r'[^a-zA-Z0-9]';
    return input.replaceAll(RegExp(pattern), '');
  }

  @override
  TextSelection updateCursorPosition(
      String oldText, String newText, TextSelection newSelection, TextSelection oldSelection) {
    // For simplicity, we are using the base class implementation which
    // maintains natural cursor behavior. If needed, customize here.
    return super.updateCursorPosition(oldText, newText, newSelection, oldSelection);
  }
}
