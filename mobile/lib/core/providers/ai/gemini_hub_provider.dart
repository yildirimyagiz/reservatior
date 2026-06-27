import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

class GeminiHubState {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> messages;

  GeminiHubState({
    this.isLoading = false,
    this.error,
    this.messages = const [],
  });

  GeminiHubState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? messages,
    bool clearError = false,
  }) {
    return GeminiHubState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      messages: messages ?? this.messages,
    );
  }
}

class GeminiHubNotifier extends StateNotifier<GeminiHubState> {
  final DioClient _dioClient;

  GeminiHubNotifier(this._dioClient) : super(GeminiHubState());

  void clearChat() {
    state = GeminiHubState();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message immediately
    final userMessage = {
      'role': 'user',
      'text': text,
    };
    
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      messages: [...state.messages, userMessage],
    );

    try {
      // Send the entire conversation history to the backend
      final response = await _dioClient.dio.post('/ai/gemini-hub', data: {
        'query': text,
        'history': state.messages,
      });

      if (response.data != null && response.data['data'] != null) {
        final data = response.data['data'];
        
        final actionsList = (data['actions'] as List?)?.map((e) {
          return {
            'label': e['label'] as String? ?? 'Action',
            'route': e['route'] as String? ?? '/',
            'icon': e['icon'] as String? ?? 'check_circle',
          };
        }).toList() ?? [];

        final aiMessage = {
          'role': 'ai',
          'text': data['response'] as String? ?? 'I am here to help.',
          'intent': data['intent'] as String?,
          'actions': actionsList,
        };

        state = state.copyWith(
          isLoading: false,
          messages: [...state.messages, aiMessage],
        );
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to connect: ${e.toString()}',
      );
    }
  }
}

final geminiHubProvider = StateNotifierProvider<GeminiHubNotifier, GeminiHubState>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return GeminiHubNotifier(dioClient);
});
