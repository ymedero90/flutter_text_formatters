import 'package:flutter/services.dart';

/// An abstract base class for custom text formatters in Flutter.
abstract class TextFormatterBase extends TextInputFormatter {
  TextFormatterBase();

  /// The main method that all concrete formatters must implement.
  /// It defines the specific formatting logic.
  ///
  /// [oldValue] is the text's previous value before the current edit.
  /// [newValue] is the current text value that might be modified.
  ///
  /// This method should return a modified [TextEditingValue] according to the formatting logic.
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = applyFormat(newValue.text);
    // Asegúrate de que la posición del cursor nunca exceda la longitud del nuevo texto.
    int cursorPosition = newValue.selection.end;
    cursorPosition = cursorPosition > newText.length ? newText.length : cursorPosition;

    // Actualiza la selección para reflejar la nueva posición del cursor.
    final newSelection = TextSelection.collapsed(offset: cursorPosition);

    return newValue.copyWith(text: newText, selection: newSelection);
  }

  /// Defines the specific formatting logic for each concrete formatter.
  /// This method must be overridden by subclasses.
  ///
  /// [input] is the current text that needs to be formatted.
  /// Returns the formatted text.
  String applyFormat(String input);

  /// Updates the cursor position based on the text before and after formatting.
  /// This method can be overridden by derived classes to implement custom logic.
  ///
  /// [oldText] is the text before formatting, [newText] is the text after formatting,
  /// [newSelection] is the new proposed selection (cursor position), and [oldSelection] is the old selection.
  ///
  /// Returns a new [TextSelection] adjusted after formatting.
  TextSelection updateCursorPosition(
      String oldText, String newText, TextSelection newSelection, TextSelection oldSelection) {
    // Default implementation; subclasses can provide their own version.
    // This is a basic implementation; it can be overridden for more specific cases.
    int offset = newText.length - oldText.length;
    int newOffset = oldSelection.extentOffset + offset;
    newOffset = newOffset > newText.length ? newText.length : newOffset;
    newOffset = newOffset < 0 ? 0 : newOffset;
    return TextSelection.collapsed(offset: newOffset);
  }
}
