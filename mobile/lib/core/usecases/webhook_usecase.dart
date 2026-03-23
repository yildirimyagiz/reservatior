import '../../features/shared/services/webhook_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Webhook

class GetWebhookByIdUseCase {
  final WebhookService _service;
  
  GetWebhookByIdUseCase(this._service);
  
  Future<Webhook> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetWebhooksUseCase {
  final WebhookService _service;
  
  GetWebhooksUseCase(this._service);
  
  Future<List<Webhook>> execute({
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

class CreateWebhookUseCase {
  final WebhookService _service;
  
  CreateWebhookUseCase(this._service);
  
  Future<Webhook> execute(Webhook webhook) async {
    // Add validation logic here
    return await _service.create(webhook);
  }
}

class UpdateWebhookUseCase {
  final WebhookService _service;
  
  UpdateWebhookUseCase(this._service);
  
  Future<Webhook> execute(String id, Webhook webhook) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, webhook);
  }
}

class DeleteWebhookUseCase {
  final WebhookService _service;
  
  DeleteWebhookUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Webhook Use Case Container
class WebhookUseCases {
  final GetWebhookByIdUseCase getById;
  final GetWebhooksUseCase getAll;
  final CreateWebhookUseCase create;
  final UpdateWebhookUseCase update;
  final DeleteWebhookUseCase delete;
  
  WebhookUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory WebhookUseCases.create(WebhookService service) {
    return WebhookUseCases(
      getById: GetWebhookByIdUseCase(service),
      getAll: GetWebhooksUseCase(service),
      create: CreateWebhookUseCase(service),
      update: UpdateWebhookUseCase(service),
      delete: DeleteWebhookUseCase(service),
    );
  }
}
