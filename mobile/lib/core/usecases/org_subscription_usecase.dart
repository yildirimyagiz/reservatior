import '../../features/shared/services/org_subscription_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for OrgSubscription

class GetOrgSubscriptionByIdUseCase {
  final OrgSubscriptionService _service;
  
  GetOrgSubscriptionByIdUseCase(this._service);
  
  Future<OrgSubscription> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetOrgSubscriptionsUseCase {
  final OrgSubscriptionService _service;
  
  GetOrgSubscriptionsUseCase(this._service);
  
  Future<List<OrgSubscription>> execute({
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

class CreateOrgSubscriptionUseCase {
  final OrgSubscriptionService _service;
  
  CreateOrgSubscriptionUseCase(this._service);
  
  Future<OrgSubscription> execute(OrgSubscription orgSubscription) async {
    // Add validation logic here
    return await _service.create(orgSubscription);
  }
}

class UpdateOrgSubscriptionUseCase {
  final OrgSubscriptionService _service;
  
  UpdateOrgSubscriptionUseCase(this._service);
  
  Future<OrgSubscription> execute(String id, OrgSubscription orgSubscription) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, orgSubscription);
  }
}

class DeleteOrgSubscriptionUseCase {
  final OrgSubscriptionService _service;
  
  DeleteOrgSubscriptionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// OrgSubscription Use Case Container
class OrgSubscriptionUseCases {
  final GetOrgSubscriptionByIdUseCase getById;
  final GetOrgSubscriptionsUseCase getAll;
  final CreateOrgSubscriptionUseCase create;
  final UpdateOrgSubscriptionUseCase update;
  final DeleteOrgSubscriptionUseCase delete;
  
  OrgSubscriptionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory OrgSubscriptionUseCases.create(OrgSubscriptionService service) {
    return OrgSubscriptionUseCases(
      getById: GetOrgSubscriptionByIdUseCase(service),
      getAll: GetOrgSubscriptionsUseCase(service),
      create: CreateOrgSubscriptionUseCase(service),
      update: UpdateOrgSubscriptionUseCase(service),
      delete: DeleteOrgSubscriptionUseCase(service),
    );
  }
}
