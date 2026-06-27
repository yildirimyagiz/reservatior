import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class AiVideoEnhancementService {
  final DioClient _dioClient;

  AiVideoEnhancementService(this._dioClient);

  Future<void> requestVoiceOver(String videoId, String script, String voiceId) async {
    await _dioClient.post('${ApiEndpoints.aiVideos}/voice-over', data: {
      'videoId': videoId,
      'script': script,
      'voiceId': voiceId,
    });
  }

  Future<void> automatedEditing(String videoId, Map<String, dynamic> preferences) async {
    await _dioClient.post('${ApiEndpoints.aiVideos}/auto-edit', data: {
      'videoId': videoId,
      'preferences': preferences,
    });
  }

  Future<void> applyVirtualStaging(String photoId, Map<String, dynamic> roomPreferences) async {
    await _dioClient.post('${ApiEndpoints.aiImageAnalyses}/virtual-staging', data: {
      'photoId': photoId,
      'preferences': roomPreferences,
    });
  }

  Future<void> enhanceImage(String photoId, Map<String, dynamic> options) async {
    await _dioClient.post('${ApiEndpoints.aiImageAnalyses}/enhance', data: {
      'photoId': photoId,
      'options': options,
    });
  }

  Stream<double> getVideoProcessingProgress(String videoId) async* {
    // This could be a WebSocket stream or polling
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      final response = await _dioClient.get('${ApiEndpoints.aiVideos}/status/$videoId');
      final progress = response.data['data']['progress'] as double;
      yield progress;
      if (progress >= 1.0) break;
    }
  }
}
