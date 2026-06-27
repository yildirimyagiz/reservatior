import 'package:reservatior/shared/repositories/webhook_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetWebhookByIdUseCase {
  final WebhookRepository _repository;
  GetWebhookByIdUseCase(this._repository);
  Future<Webhook> execute(String id) => _repository.getById(id);
}

class GetWebhooksUseCase {
  final WebhookRepository _repository;
  GetWebhooksUseCase(this._repository);
  Future<List<Webhook>> execute({
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

class CreateWebhookUseCase {
  final WebhookRepository _repository;
  CreateWebhookUseCase(this._repository);
  Future<Webhook> execute(Webhook item) => _repository.create(item);
}

class UpdateWebhookUseCase {
  final WebhookRepository _repository;
  UpdateWebhookUseCase(this._repository);
  Future<Webhook> execute(String id, Webhook item) => _repository.update(id, item);
}

class DeleteWebhookUseCase {
  final WebhookRepository _repository;
  DeleteWebhookUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
