import '../../features/shared/services/subscription_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Subscription

class GetSubscriptionByIdUseCase {
  final SubscriptionService _service;
  
  GetSubscriptionByIdUseCase(this._service);
  
  Future<Subscription> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSubscriptionsUseCase {
  final SubscriptionService _service;
  
  GetSubscriptionsUseCase(this._service);
  
  Future<List<Subscription>> execute({
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

class CreateSubscriptionUseCase {
  final SubscriptionService _service;
  
  CreateSubscriptionUseCase(this._service);
  
  Future<Subscription> execute(Subscription subscription) async {
    // Add validation logic here
    return await _service.create(subscription);
  }
}

class UpdateSubscriptionUseCase {
  final SubscriptionService _service;
  
  UpdateSubscriptionUseCase(this._service);
  
  Future<Subscription> execute(String id, Subscription subscription) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, subscription);
  }
}

class DeleteSubscriptionUseCase {
  final SubscriptionService _service;
  
  DeleteSubscriptionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Subscription Use Case Container
class SubscriptionUseCases {
  final GetSubscriptionByIdUseCase getById;
  final GetSubscriptionsUseCase getAll;
  final CreateSubscriptionUseCase create;
  final UpdateSubscriptionUseCase update;
  final DeleteSubscriptionUseCase delete;
  
  SubscriptionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SubscriptionUseCases.create(SubscriptionService service) {
    return SubscriptionUseCases(
      getById: GetSubscriptionByIdUseCase(service),
      getAll: GetSubscriptionsUseCase(service),
      create: CreateSubscriptionUseCase(service),
      update: UpdateSubscriptionUseCase(service),
      delete: DeleteSubscriptionUseCase(service),
    );
  }
}
