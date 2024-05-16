import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/html_tag_stripper_formatter.dart';

void main() {
  test('Removes HTML tags from input', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Hello <b>World</b>!'),
    );
    expect(result.text, equals('Hello World!'));
  });

  test('Leaves text without HTML tags unchanged', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Hello World!'),
    );
    expect(result.text, equals('Hello World!'));
  });

  test('Removes simple HTML tags', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '<p>Hello World</p>'),
    );
    expect(result.text, equals('Hello World'));
  });

  test('Removes nested HTML tags', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '<div><span>Nested </span>content</div>'),
    );
    expect(result.text, equals('Nested content'));
  });

  test('Handles text without HTML tags', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'No HTML here'),
    );
    expect(result.text, equals('No HTML here'));
  });

  test('Removes HTML tags but leaves HTML entities', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Some &amp; HTML entities &lt; &gt;'),
    );
    expect(result.text, equals('Some &amp; HTML entities &lt; &gt;'));
  });

  test('Removes multiple successive HTML tags', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Text <b>with</b> <i>multiple</i> <u>tags</u>'),
    );
    expect(result.text, equals('Text with multiple tags'));
  });

  test('Ignores malformed HTML tags', () {
    final formatter = HtmlTagStripperFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Malformed <HTML> tags'),
    );
    // Expect the formatter to remove even malformed tags, but this behavior can be adjusted based on your needs.
    expect(result.text, equals('Malformed  tags'));
  });
}
