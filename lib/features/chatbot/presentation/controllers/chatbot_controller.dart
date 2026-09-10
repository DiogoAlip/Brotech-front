import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/chatbot_repository.dart';
import '../../domain/models/chat_message.dart';

class ChatbotState {
  final List<ChatMessage> messages;
  final bool isTyping;

  const ChatbotState({
    required this.messages,
    this.isTyping = false,
  });

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class ChatbotController extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository;

  ChatbotController(this._repository)
      : super(
          ChatbotState(
            messages: _repository.getInitialMessages(),
          ),
        );

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      time: 'Ahora',
      isUser: true,
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
    );

    await Future.delayed(const Duration(milliseconds: 1000));

    final botReply = ChatMessage(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      text: 'Entendido. He procesado tu solicitud agronómica para "$text". Datos sincronizados con sensores de suelo y estación meteorológica.',
      time: 'Ahora',
      isUser: false,
    );

    state = state.copyWith(
      messages: [...state.messages, botReply],
      isTyping: false,
    );
  }
}

final chatbotRepositoryProvider = Provider<ChatbotRepository>((ref) {
  return ChatbotRepository();
});

final chatbotControllerProvider =
    StateNotifierProvider<ChatbotController, ChatbotState>((ref) {
  final repo = ref.watch(chatbotRepositoryProvider);
  return ChatbotController(repo);
});
