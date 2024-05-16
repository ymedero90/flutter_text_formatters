import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that formats numeric input as currency.
///
/// This formatter converts numerical input into a currency format, allowing for customization
/// of the currency symbol, decimal places, and the usage of thousands separators. It's particularly
/// useful for fields where monetary amounts are entered, ensuring consistency and readability
/// of currency values.
///
/// ## Parameters
/// - [currencySymbol]: A string specifying the currency symbol to prepend to the formatted value.
///   Defaults to '\$' for US Dollar.
/// - [decimalPlaces]: An integer defining the number of decimal places to include. Defaults to 2.
/// - [useThousandsSeparator]: A boolean indicating whether to include thousands separators in the
///   formatted output. Defaults to true.
/// - [decimalSeparator]: A string defining the character used to separate the decimal part from the whole
///   number. Defaults to '.'.
/// - [thousandsSeparator]: A string defining the character used as the thousands separator.
///   Defaults to ','.
///
/// ## Example
/// To use [CurrencyFormatter] with custom configurations, include it in the `inputFormatters`
/// property of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [
///     CurrencyFormatter(
///       currencySymbol: '€',
///       decimalPlaces: 2,
///       useThousandsSeparator: true,
///       decimalSeparator: ',',
///       thousandsSeparator: '.',
///     ),
///   ],
/// )
/// ```
///
/// This example configures the formatter to format values as Euros, with two decimal places,
/// using a comma as the decimal separator and a period as the thousands separator, common
/// in many European countries.
class CurrencyFormatter extends TextFormatterBase {
  final String currencySymbol;
  final int decimalPlaces;
  final bool useThousandsSeparator;
  final String decimalSeparator;
  final String thousandsSeparator;

  CurrencyFormatter({
    this.currencySymbol = '\$',
    this.decimalPlaces = 2,
    this.useThousandsSeparator = true,
    this.decimalSeparator = '.',
    this.thousandsSeparator = ',',
  });

  @override
  String applyFormat(String input) {
    // Handle empty input immediately to format as zero value.
    if (input.isEmpty) {
      return '${currencySymbol}0$decimalSeparator${'0' * decimalPlaces}';
    }

    // Remove all non-digit characters except the decimal point.
    String digitsOnly = input.replaceAll(RegExp(r'[^\d.]'), '');

    // Prepend '0' if the string starts with a decimal point for correct formatting.
    if (digitsOnly.startsWith('.')) {
      digitsOnly = '0$digitsOnly';
    }

    // Split the input into whole and decimal parts.
    List<String> parts = digitsOnly.split('.');
    String wholePart = parts[0];
    // Pad or truncate the decimal part to match the specified decimal places.
    String decimalPart = parts.length > 1 ? parts[1] : '0'.padRight(decimalPlaces, '0');

    // Format the whole number part with thousands separators if enabled.
    String formattedWholePart = useThousandsSeparator ? _formatWholePart(wholePart) : wholePart;
    // Concatenate formatted parts into the final currency string.
    String formattedDecimalPart = _formatDecimalPart(decimalPart);

    return '$currencySymbol$formattedWholePart$decimalSeparator$formattedDecimalPart';
  }

  String _formatWholePart(String wholePart) {
    return wholePart
        .split('')
        .reversed
        .join('')
        .replaceAllMapped(RegExp(r'.{1,3}'), (match) => '${match[0]}$thousandsSeparator')
        .split('')
        .reversed
        .join('')
        .replaceFirst(RegExp('^$thousandsSeparator'), '');
  }

  String _formatDecimalPart(String decimalPart) {
    return decimalPart.padRight(decimalPlaces, '0').substring(0, decimalPlaces);
  }
}
