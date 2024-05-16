import 'package:flutter/services.dart';
import 'package:flutter_text_formatters/core/text_formatter_base.dart';

/// Un [TextInputFormatter] que filtra emojis del texto ingresado o permite solo emojis,
/// bloqueando texto tradicional, según se configure.
///
/// ## Parámetros
/// - [allowEmojis]: Si se establece en `true`, el formateador permitirá solo emojis y bloqueará
///   texto tradicional. Si se establece en `false`, eliminará todos los emojis del texto ingresado.
class EmojiFilterFormatter extends TextFormatterBase {
  final bool allowEmojis;

  EmojiFilterFormatter({this.allowEmojis = false});

  @override
  String applyFormat(String input) {
    // Expresión regular para identificar emojis.
    final RegExp emojiRegex = RegExp(
      // Esta es una expresión simplificada y puede necesitar ajustes para ser más inclusiva o exclusiva.
      r'[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
      unicode: true,
    );

    if (allowEmojis) {
      // Permite solo emojis, eliminando todo lo que no coincida con la expresión regular.
      return input.splitMapJoin(emojiRegex, onNonMatch: (_) => '');
    } else {
      // Elimina emojis, manteniendo el texto que no coincide con la expresión regular.
      return input.replaceAll(emojiRegex, '');
    }
  }
}
