import 'package:reservatior/shared/repositories/message_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMessageByIdUseCase {
  final MessageRepository _repository;
  GetMessageByIdUseCase(this._repository);
  Future<Message> execute(String id) => _repository.getById(id);
}

class GetMessagesUseCase {
  final MessageRepository _repository;
  GetMessagesUseCase(this._repository);
  Future<List<Message>> execute({
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

class CreateMessageUseCase {
  final MessageRepository _repository;
  CreateMessageUseCase(this._repository);
  Future<Message> execute(Message item) => _repository.create(item);
}

class UpdateMessageUseCase {
  final MessageRepository _repository;
  UpdateMessageUseCase(this._repository);
  Future<Message> execute(String id, Message item) => _repository.update(id, item);
}

class DeleteMessageUseCase {
  final MessageRepository _repository;
  DeleteMessageUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
