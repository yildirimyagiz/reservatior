import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/agent_team.dart';

final adminAgentTeamsProvider = FutureProvider<List<AgentTeam>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/agent-team');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AgentTeam.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
