import 'package:reservatior/shared/repositories/ai_fraud_detection_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiFraudDetectionByIdUseCase {
  final AiFraudDetectionRepository _repository;
  GetAiFraudDetectionByIdUseCase(this._repository);
  Future<AiFraudDetection> execute(String id) => _repository.getById(id);
}

class GetAiFraudDetectionsUseCase {
  final AiFraudDetectionRepository _repository;
  GetAiFraudDetectionsUseCase(this._repository);
  Future<List<AiFraudDetection>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateAiFraudDetectionUseCase {
  final AiFraudDetectionRepository _repository;
  CreateAiFraudDetectionUseCase(this._repository);
  Future<AiFraudDetection> execute(AiFraudDetection item) => _repository.create(item);
}

class UpdateAiFraudDetectionUseCase {
  final AiFraudDetectionRepository _repository;
  UpdateAiFraudDetectionUseCase(this._repository);
  Future<AiFraudDetection> execute(String id, AiFraudDetection item) => _repository.update(id, item);
}

class DeleteAiFraudDetectionUseCase {
  final AiFraudDetectionRepository _repository;
  DeleteAiFraudDetectionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
