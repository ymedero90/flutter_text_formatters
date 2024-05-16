import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that capitalizes the first letter of each word in a text input.
///
/// This formatter can also convert the rest of each word to lowercase and exclude specific
/// words from being modified, based on the provided configurations. It's useful for fields
/// where names, titles, or any other text require standard capitalization for better readability
/// and consistency.
///
/// ## Parameters
/// [convertRestToLowercase] - A boolean value that controls whether the rest of the characters
/// in a word, after the first character, should be converted to lowercase.
///
/// [excludeWords] - A list of words that should be excluded from capitalization changes. These
/// words will be output exactly as they appear in the list, preserving their case.
///
/// [delimiter] - A string used to identify word boundaries. By default, this is a single space
/// character, indicating that words are separated by spaces.
///
/// ## Example
/// To use [CapitalizeFormatter] with custom configurations, include it in the `inputFormatters`
/// property of your `TextField` or `TextFormField` widgets like so:
///
/// ```dart
/// TextField(
///   inputFormatters: [
///     CapitalizeFormatter(
///       convertRestToLowercase: true,
///       excludeWords: ['iOS', 'ID'],
///       delimiter: ' ',
///     )
///   ],
/// )
/// ```
///
/// This example configures the formatter to capitalize the first letter of each word, convert
/// the rest of the word to lowercase, exclude the words 'iOS' and 'ID' from any changes, and
/// use space as the delimiter between words.
class CapitalizeFormatter extends TextFormatterBase {
  final bool convertRestToLowercase;
  final List<String> excludeWords;
  final String delimiter;

  CapitalizeFormatter({
    this.convertRestToLowercase = false,
    this.excludeWords = const [],
    this.delimiter = ' ',
  });

  @override
  String applyFormat(String input) {
    final buffer = StringBuffer();
    final words = RegExp(r'(\w+|\W+)').allMatches(input).map((match) => match.group(0)!);

    for (var match in words) {
      if (match.trim().isEmpty || !match.contains(RegExp(r'[a-zA-Z]'))) {
        buffer.write(match);
      } else {
        String lowerCaseWord = match.toLowerCase();
        if (excludeWords.any((exWord) => exWord.toLowerCase() == lowerCaseWord)) {
          String originalWord =
              excludeWords.firstWhere((exWord) => exWord.toLowerCase() == lowerCaseWord, orElse: () => match);
          buffer.write(originalWord);
        } else {
          buffer.write(_capitalize(match));
        }
      }
    }

    return buffer.toString();
  }

  /// Capitalizes the first letter of a word and, depending on [convertRestToLowercase],
  /// converts the rest of the word to lowercase.
  String _capitalize(String word) {
    if (word.isEmpty) return word;
    final firstChar = word[0].toUpperCase();
    final rest = convertRestToLowercase ? word.substring(1).toLowerCase() : word.substring(1);
    return firstChar + rest;
  }
}
