import 'package:reservatior/features/saga_flow/domain/entities/saga_instance.dart';
import 'package:reservatior/features/saga_flow/domain/entities/saga_config.dart';
import 'package:reservatior/features/saga_flow/domain/entities/saga_timeline.dart';
import 'package:reservatior/features/saga_flow/domain/entities/saga_stats.dart';

abstract class AbstractSagaRepository {
  Future<List<SagaInstance>> getActiveSagas({
    int page,
    int limit,
    String? status,
  });

  Future<List<SagaInstance>> getSagaHistory({
    int page,
    int limit,
    String? status,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<SagaInstance> getSagaById(String id);

  Future<SagaInstance> createSaga({
    required String name,
    required String type,
    Map<String, dynamic>? payload,
  });

  Future<void> cancelSaga(String id);

  Future<SagaInstance> retrySaga(String id);

  Future<SagaConfig> getSagaConfig(String configId);

  Future<SagaConfig> updateSagaConfig(SagaConfig config);

  Future<List<SagaInstance>> getOrchestrationSagas({String path});

  Future<Map<String, dynamic>> getOrchestrationGraph();

  Future<List<SagaTimeline>> getSagaTimelines({int limit});

  Future<SagaTimeline> getSagaTimelineById(String id);

  Future<SagaStats> getSagaStats();

  Future<List<String>> getSagaTypes();
}
