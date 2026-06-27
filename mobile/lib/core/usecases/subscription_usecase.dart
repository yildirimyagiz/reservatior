import 'package:reservatior/shared/repositories/subscription_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSubscriptionByIdUseCase {
  final SubscriptionRepository _repository;
  GetSubscriptionByIdUseCase(this._repository);
  Future<Subscription> execute(String id) => _repository.getById(id);
}

class GetSubscriptionsUseCase {
  final SubscriptionRepository _repository;
  GetSubscriptionsUseCase(this._repository);
  Future<List<Subscription>> execute({
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

class CreateSubscriptionUseCase {
  final SubscriptionRepository _repository;
  CreateSubscriptionUseCase(this._repository);
  Future<Subscription> execute(Subscription item) => _repository.create(item);
}

class UpdateSubscriptionUseCase {
  final SubscriptionRepository _repository;
  UpdateSubscriptionUseCase(this._repository);
  Future<Subscription> execute(String id, Subscription item) => _repository.update(id, item);
}

class DeleteSubscriptionUseCase {
  final SubscriptionRepository _repository;
  DeleteSubscriptionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
