import 'package:child_vaccination/screen/chatbot/chat_message.dart';
import 'package:dart_openai/dart_openai.dart';
import 'key.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = Key.openAikey;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage
                    ? OpenAIChatMessageRole.user
                    : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    print(chatCompletion.choices);
    return chatCompletion.choices.first.message.content;
  }
}
