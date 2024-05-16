import 'package:flutter/services.dart';

/// A [TextInputFormatter] that restricts input to a specific numerical range.
/// Rejects values that are outside the defined minimum and maximum.
class MaxValueTextInputFormatter extends TextInputFormatter {
  final double minValue;
  final double maxValue;

  MaxValueTextInputFormatter({
    this.minValue = double.negativeInfinity, // Default with no minimum limit
    required this.maxValue,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow empty for easier deletion and correction.
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value == null) {
      // Not a number, revert to the previous value.
      return oldValue;
    }

    if (value < minValue || value > maxValue) {
      // Out of range, revert to the previous value.
      return oldValue;
    }

    // Value within range, allow the update.
    return newValue;
  }
}
