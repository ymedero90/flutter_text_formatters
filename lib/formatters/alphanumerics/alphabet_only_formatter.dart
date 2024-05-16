import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that allows only alphabetic characters and optionally spaces to be entered.
///
/// This formatter filters out any non-alphabetic character from the input,
/// allowing only letters and, optionally, spaces. It's particularly useful for fields where
/// textual names, words, or even sentences are expected, such as names, cities, or short phrases.
///
/// ## Parameters
/// [allowSpaces] - A boolean value that controls whether spaces are allowed in the input.
///
/// ## Example
/// To use [AlphabetOnlyFormatter] and allow spaces, simply include it in the `inputFormatters` property
/// of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [AlphabetOnlyFormatter(allowSpaces: true)],
/// )
/// ```
class AlphabetOnlyFormatter extends TextFormatterBase {
  final bool allowSpaces;

  AlphabetOnlyFormatter({this.allowSpaces = false});

  @override
  String applyFormat(String input) {
    // If allowSpaces is true, include space in the allowed characters.
    final String pattern = allowSpaces ? r'[^a-zA-Z ]' : r'[^a-zA-Z]';
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
