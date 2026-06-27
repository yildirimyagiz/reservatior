import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/ai_model.dart';

final adminAiModelsProvider = FutureProvider<List<AiModel>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/ai-model');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AiModel.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
