import 'package:reservatior/shared/repositories/webhook_delivery_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetWebhookDeliveryByIdUseCase {
  final WebhookDeliveryRepository _repository;
  GetWebhookDeliveryByIdUseCase(this._repository);
  Future<WebhookDelivery> execute(String id) => _repository.getById(id);
}

class GetWebhookDeliverysUseCase {
  final WebhookDeliveryRepository _repository;
  GetWebhookDeliverysUseCase(this._repository);
  Future<List<WebhookDelivery>> execute({
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

class CreateWebhookDeliveryUseCase {
  final WebhookDeliveryRepository _repository;
  CreateWebhookDeliveryUseCase(this._repository);
  Future<WebhookDelivery> execute(WebhookDelivery item) => _repository.create(item);
}

class UpdateWebhookDeliveryUseCase {
  final WebhookDeliveryRepository _repository;
  UpdateWebhookDeliveryUseCase(this._repository);
  Future<WebhookDelivery> execute(String id, WebhookDelivery item) => _repository.update(id, item);
}

class DeleteWebhookDeliveryUseCase {
  final WebhookDeliveryRepository _repository;
  DeleteWebhookDeliveryUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
