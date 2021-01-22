import 'package:telebot/telebot.dart';

class TelegramBotUtil {
  static String _chatId;

  TelegramBotUtil._(String token, String chatId) {
    _chatId = chatId;
    TelegramBot.init(token);
  }

  static void init(String token, String chatId) {
    TelegramBotUtil._(token, chatId);
  }

  static void sendMessage(String msg) {
    print("azhansy,bot sendMessage======${msg}");

    if (TelegramBot.instance != null) {
      TelegramBot.instance
          .sendMessage(chatId: _chatId, text: msg)
          .then((Message messageResult) {
//        print("bot sendMessage result=${messageResult.toString()}");
      }).catchError((error) {
        // handle error
        print("bot sendMessage error=${error.toString()}");
      });
    }
  }
}
