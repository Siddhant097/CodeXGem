// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotEvent {}

class ChatGenerateNewTextMessageEvent extends ChatbotEvent {
   final String inputMessage;
  ChatGenerateNewTextMessageEvent({
    required this.inputMessage,
  });

}
