import 'package:reservatior/shared/repositories/org_subscription_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetOrgSubscriptionByIdUseCase {
  final OrgSubscriptionRepository _repository;
  GetOrgSubscriptionByIdUseCase(this._repository);
  Future<OrgSubscription> execute(String id) => _repository.getById(id);
}

class GetOrgSubscriptionsUseCase {
  final OrgSubscriptionRepository _repository;
  GetOrgSubscriptionsUseCase(this._repository);
  Future<List<OrgSubscription>> execute({
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

class CreateOrgSubscriptionUseCase {
  final OrgSubscriptionRepository _repository;
  CreateOrgSubscriptionUseCase(this._repository);
  Future<OrgSubscription> execute(OrgSubscription item) => _repository.create(item);
}

class UpdateOrgSubscriptionUseCase {
  final OrgSubscriptionRepository _repository;
  UpdateOrgSubscriptionUseCase(this._repository);
  Future<OrgSubscription> execute(String id, OrgSubscription item) => _repository.update(id, item);
}

class DeleteOrgSubscriptionUseCase {
  final OrgSubscriptionRepository _repository;
  DeleteOrgSubscriptionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
