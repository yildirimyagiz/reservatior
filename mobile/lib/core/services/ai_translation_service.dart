import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:reservatior/core/network/dio_client.dart';

class AiTranslationService {
  final DioClient _client;

  AiTranslationService(this._client);

  Future<String> translate(String text, {String targetLang = 'tr'}) async {
    try {
      final response = await _client.post(
        ApiEndpoints.aiTranslate,
        data: {
          'text': text,
          'targetLang': targetLang,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['translation'] ?? text;
      }
      return text;
    } catch (e) {
      print('Translation Error: $e');
      return text;
    }
  }
}

final aiTranslationServiceProvider = Provider<AiTranslationService>((ref) {
  final client = ref.watch(dioClientProvider);
  return AiTranslationService(client);
});
