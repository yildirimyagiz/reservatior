import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/message.dart';
import 'package:reservatior/core/providers/admin/message_provider.dart';

enum AiSentiment {
  angry(color: Colors.redAccent, label: 'Kızgın', priority: 1),
  urgent(color: Colors.orangeAccent, label: 'Acil', priority: 2),
  neutral(color: Colors.blueGrey, label: 'Nötr', priority: 3),
  positive(color: Colors.green, label: 'Memnun', priority: 4);

  final Color color;
  final String label;
  final int priority;

  const AiSentiment({required this.color, required this.label, required this.priority});
}

class AnalyzedMessage {
  final Message message;
  final AiSentiment sentiment;

  const AnalyzedMessage({required this.message, required this.sentiment});
}

final aiAnalyzedMessagesProvider = FutureProvider<List<AnalyzedMessage>>((ref) async {
  final originalMessages = await ref.watch(adminMessagesProvider.future);
  
  if (originalMessages.isEmpty) return [];

  // Simple local mock of an AI Sentiment Analysis process
  final analyzedList = originalMessages.map((msg) {
    final text = (msg.body + ' ' + (msg.subject ?? '')).toLowerCase();
    
    AiSentiment sentiment = AiSentiment.neutral;
    
    // Keywords representing "Angry" or "Urgent" cases
    if (text.contains('iptal') || 
        text.contains('şikayet') || 
        text.contains('kötü') || 
        text.contains('cancel') || 
        text.contains('angry') || 
        text.contains('berbat')) {
      sentiment = AiSentiment.angry;
    } else if (text.contains('acil') || 
               text.contains('hemen') || 
               text.contains('urgent') || 
               text.contains('help') || 
               text.contains('sorun')) {
      sentiment = AiSentiment.urgent;
    } else if (text.contains('teşekkür') || 
               text.contains('harika') || 
               text.contains('iyi') || 
               text.contains('thanks') || 
               text.contains('great')) {
      sentiment = AiSentiment.positive;
    }

    // You could theoretically call a real RunPod / Gemini endpoint here:
    // sentiment = await aiService.analyze(msg.body);
    
    return AnalyzedMessage(message: msg, sentiment: sentiment);
  }).toList();

  // Sort by AI Priority (Angry/Urgent first, then newest)
  analyzedList.sort((a, b) {
    if (a.sentiment.priority != b.sentiment.priority) {
      return a.sentiment.priority.compareTo(b.sentiment.priority);
    }
    return b.message.createdAt.compareTo(a.message.createdAt);
  });

  return analyzedList;
});
