import '../../features/shared/services/webhook_delivery_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for WebhookDelivery

class GetWebhookDeliveryByIdUseCase {
  final WebhookDeliveryService _service;
  
  GetWebhookDeliveryByIdUseCase(this._service);
  
  Future<WebhookDelivery> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetWebhookDeliverysUseCase {
  final WebhookDeliveryService _service;
  
  GetWebhookDeliverysUseCase(this._service);
  
  Future<List<WebhookDelivery>> execute({
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

class CreateWebhookDeliveryUseCase {
  final WebhookDeliveryService _service;
  
  CreateWebhookDeliveryUseCase(this._service);
  
  Future<WebhookDelivery> execute(WebhookDelivery webhookDelivery) async {
    // Add validation logic here
    return await _service.create(webhookDelivery);
  }
}

class UpdateWebhookDeliveryUseCase {
  final WebhookDeliveryService _service;
  
  UpdateWebhookDeliveryUseCase(this._service);
  
  Future<WebhookDelivery> execute(String id, WebhookDelivery webhookDelivery) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, webhookDelivery);
  }
}

class DeleteWebhookDeliveryUseCase {
  final WebhookDeliveryService _service;
  
  DeleteWebhookDeliveryUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// WebhookDelivery Use Case Container
class WebhookDeliveryUseCases {
  final GetWebhookDeliveryByIdUseCase getById;
  final GetWebhookDeliverysUseCase getAll;
  final CreateWebhookDeliveryUseCase create;
  final UpdateWebhookDeliveryUseCase update;
  final DeleteWebhookDeliveryUseCase delete;
  
  WebhookDeliveryUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory WebhookDeliveryUseCases.create(WebhookDeliveryService service) {
    return WebhookDeliveryUseCases(
      getById: GetWebhookDeliveryByIdUseCase(service),
      getAll: GetWebhookDeliverysUseCase(service),
      create: CreateWebhookDeliveryUseCase(service),
      update: UpdateWebhookDeliveryUseCase(service),
      delete: DeleteWebhookDeliveryUseCase(service),
    );
  }
}
