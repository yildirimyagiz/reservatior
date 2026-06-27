import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/project.dart';

final adminProjectsProvider = FutureProvider<List<Project>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/project');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Project.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
