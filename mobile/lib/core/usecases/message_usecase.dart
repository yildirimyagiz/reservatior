import '../../features/shared/services/message_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Message

class GetMessageByIdUseCase {
  final MessageService _service;
  
  GetMessageByIdUseCase(this._service);
  
  Future<Message> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMessagesUseCase {
  final MessageService _service;
  
  GetMessagesUseCase(this._service);
  
  Future<List<Message>> execute({
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

class CreateMessageUseCase {
  final MessageService _service;
  
  CreateMessageUseCase(this._service);
  
  Future<Message> execute(Message message) async {
    // Add validation logic here
    return await _service.create(message);
  }
}

class UpdateMessageUseCase {
  final MessageService _service;
  
  UpdateMessageUseCase(this._service);
  
  Future<Message> execute(String id, Message message) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, message);
  }
}

class DeleteMessageUseCase {
  final MessageService _service;
  
  DeleteMessageUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Message Use Case Container
class MessageUseCases {
  final GetMessageByIdUseCase getById;
  final GetMessagesUseCase getAll;
  final CreateMessageUseCase create;
  final UpdateMessageUseCase update;
  final DeleteMessageUseCase delete;
  
  MessageUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MessageUseCases.create(MessageService service) {
    return MessageUseCases(
      getById: GetMessageByIdUseCase(service),
      getAll: GetMessagesUseCase(service),
      create: CreateMessageUseCase(service),
      update: UpdateMessageUseCase(service),
      delete: DeleteMessageUseCase(service),
    );
  }
}
