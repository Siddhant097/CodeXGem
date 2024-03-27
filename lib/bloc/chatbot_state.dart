part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotState {}

final class ChatbotInitial extends ChatbotState {}

class ChatSuccessState extends ChatbotState {
  final List<ChatMessageModel> messages;
  ChatSuccessState({
    required this.messages,
  });
}
