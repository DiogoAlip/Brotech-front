enum ChatMessageType { text, product, taskConfirmation, typing }

class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isUser;
  final ChatMessageType type;
  final Map<String, dynamic>? metadata;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isUser,
    this.type = ChatMessageType.text,
    this.metadata,
  });
}
