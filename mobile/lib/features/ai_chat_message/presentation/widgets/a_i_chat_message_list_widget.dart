import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../gen_models/enums/a_i_chat_role.dart';

class AIChatMessageListWidget extends StatelessWidget {
  final List<AIChatMessage> messages;
  final Function(AIChatMessage)? onTap;

  const AIChatMessageListWidget({
    super.key,
    required this.messages,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUser = message.role == AIChatRole.USER;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) _buildAvatar(isUser),
              const SizedBox(width: 8),
              Flexible(
                child: InkWell(
                  onTap: () => onTap?.call(message),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        topLeft: isUser ? const Radius.circular(16) : Radius.zero,
                        topRight: isUser ? Radius.zero : const Radius.circular(16),
                      ),
                      border: Border.all(color: isUser ? Colors.blue.shade100 : Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUser ? 'You' : 'AI Assistant',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isUser ? Colors.blue : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.content ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(message.createdAt),
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (isUser) _buildAvatar(isUser),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(bool isUser) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: isUser ? Colors.blue : Colors.green,
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        size: 16,
        color: Colors.white,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
