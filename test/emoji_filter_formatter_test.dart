import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_formatters/formatters/specific_formatters/emoji_filter_formatter.dart';

void main() {
  test('Allows only emojis when configured', () {
    final formatter = EmojiFilterFormatter(allowEmojis: true);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Hello 😊 World 🌍!'),
    );
    expect(result.text, equals('😊🌍'));
  });

  test('Filters out all emojis when configured', () {
    final formatter = EmojiFilterFormatter(allowEmojis: false);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Hello 😊 World 🌍!'),
    );
    expect(result.text, equals('Hello  World !'));
  });

  test('Filters out all emojis, leaving text intact', () {
    final formatter = EmojiFilterFormatter(allowEmojis: false);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Test 😂 Message 📱'),
    );
    expect(result.text, equals('Test  Message '));
  });

  test('Allows only emojis, removing all text', () {
    final formatter = EmojiFilterFormatter(allowEmojis: true);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Emoji 😁 and Text 📖'),
    );
    expect(result.text, equals('😁📖'));
  });

  test('Handles string with only emojis correctly', () {
    final formatter = EmojiFilterFormatter(allowEmojis: true);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '😀😃😄😁'),
    );
    expect(result.text, equals('😀😃😄😁'));
  });

  test('Removes emojis from a complex mix of text, emojis, and symbols', () {
    final formatter = EmojiFilterFormatter(allowEmojis: false);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '🚀 Rocket to the 🌕! @#\$%^&*()'),
    );
    expect(result.text, equals(' Rocket to the ! @#\$%^&*()'));
  });

  test('Allows emojis while removing complex text and symbols', () {
    final formatter = EmojiFilterFormatter(allowEmojis: true);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: '🎉 Celebrate 🎂 - @#\$%^&*()'),
    );
    expect(result.text, equals('🎉🎂'));
  });

  test('Processes empty string correctly', () {
    final formatter = EmojiFilterFormatter(allowEmojis: false);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: ''),
    );
    expect(result.text, equals(''));
  });

  test('Ignores non-emoji, non-text symbols when emojis are allowed', () {
    final formatter = EmojiFilterFormatter(allowEmojis: true);
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(text: 'Symbols &*()_+ are here 😊'),
    );
    expect(result.text, equals('😊'));
  });
}
