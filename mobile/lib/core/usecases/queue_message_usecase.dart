import '../../features/shared/services/queue_message_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for QueueMessage

class GetQueueMessageByIdUseCase {
  final QueueMessageService _service;
  
  GetQueueMessageByIdUseCase(this._service);
  
  Future<QueueMessage> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetQueueMessagesUseCase {
  final QueueMessageService _service;
  
  GetQueueMessagesUseCase(this._service);
  
  Future<List<QueueMessage>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateQueueMessageUseCase {
  final QueueMessageService _service;
  
  CreateQueueMessageUseCase(this._service);
  
  Future<QueueMessage> execute(QueueMessage queueMessage) async {
    // Add validation logic here
    return await _service.create(queueMessage);
  }
}

class UpdateQueueMessageUseCase {
  final QueueMessageService _service;
  
  UpdateQueueMessageUseCase(this._service);
  
  Future<QueueMessage> execute(String id, QueueMessage queueMessage) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, queueMessage);
  }
}

class DeleteQueueMessageUseCase {
  final QueueMessageService _service;
  
  DeleteQueueMessageUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// QueueMessage Use Case Container
class QueueMessageUseCases {
  final GetQueueMessageByIdUseCase getById;
  final GetQueueMessagesUseCase getAll;
  final CreateQueueMessageUseCase create;
  final UpdateQueueMessageUseCase update;
  final DeleteQueueMessageUseCase delete;
  
  QueueMessageUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory QueueMessageUseCases.create(QueueMessageService service) {
    return QueueMessageUseCases(
      getById: GetQueueMessageByIdUseCase(service),
      getAll: GetQueueMessagesUseCase(service),
      create: CreateQueueMessageUseCase(service),
      update: UpdateQueueMessageUseCase(service),
      delete: DeleteQueueMessageUseCase(service),
    );
  }
}
