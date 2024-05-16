import 'package:flutter/services.dart';

/// A [TextInputFormatter] that filters characters based on an array of ignored characters
/// or matches with a given regular expression.
///
/// ## Parameters
/// - [ignoreChars]: A list of characters to be ignored in the input.
/// - [ignorePattern]: A regular expression that, if provided, is used to ignore
///   any matches in the input.
class CustomFilterTextInputFormatter extends TextInputFormatter {
  final List<String> ignoreChars;
  final RegExp? ignorePattern;

  CustomFilterTextInputFormatter({
    this.ignoreChars = const [],
    this.ignorePattern,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text;

    // Filter characters based on the provided list.
    for (String char in ignoreChars) {
      filteredText = filteredText.replaceAll(char, '');
    }

    // Apply the regular expression to filter any additional matches.
    if (ignorePattern != null) {
      filteredText = filteredText.replaceAll(ignorePattern!, '');
    }

    return newValue.copyWith(text: filteredText, selection: updateCursorPosition(filteredText, newValue.selection));
  }

  // Adjust the cursor position after filtering the input.
  TextSelection updateCursorPosition(String filteredText, TextSelection selection) {
    int cursorPosition = selection.extentOffset;
    cursorPosition = cursorPosition > filteredText.length ? filteredText.length : cursorPosition;
    return TextSelection.collapsed(offset: cursorPosition);
  }
}
