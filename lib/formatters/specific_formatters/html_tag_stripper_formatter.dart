import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// A [TextInputFormatter] that removes all HTML tags from the input text.
/// Useful for text fields that must avoid including HTML for security or formatting reasons.
class HtmlTagStripperFormatter extends TextFormatterBase {
  HtmlTagStripperFormatter();

  @override
  String applyFormat(String input) {
    // Use a regular expression to find and remove all HTML tags.
    final RegExp htmlTags = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return input.replaceAll(htmlTags, '');
  }
}
