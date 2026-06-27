import 'package:reservatior/shared/repositories/queue_message_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetQueueMessageByIdUseCase {
  final QueueMessageRepository _repository;
  GetQueueMessageByIdUseCase(this._repository);
  Future<QueueMessage> execute(String id) => _repository.getById(id);
}

class GetQueueMessagesUseCase {
  final QueueMessageRepository _repository;
  GetQueueMessagesUseCase(this._repository);
  Future<List<QueueMessage>> execute({
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

class CreateQueueMessageUseCase {
  final QueueMessageRepository _repository;
  CreateQueueMessageUseCase(this._repository);
  Future<QueueMessage> execute(QueueMessage item) => _repository.create(item);
}

class UpdateQueueMessageUseCase {
  final QueueMessageRepository _repository;
  UpdateQueueMessageUseCase(this._repository);
  Future<QueueMessage> execute(String id, QueueMessage item) => _repository.update(id, item);
}

class DeleteQueueMessageUseCase {
  final QueueMessageRepository _repository;
  DeleteQueueMessageUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
