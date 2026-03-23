import '../../features/shared/services/referral_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Referral

class GetReferralByIdUseCase {
  final ReferralService _service;
  
  GetReferralByIdUseCase(this._service);
  
  Future<Referral> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReferralsUseCase {
  final ReferralService _service;
  
  GetReferralsUseCase(this._service);
  
  Future<List<Referral>> execute({
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

class CreateReferralUseCase {
  final ReferralService _service;
  
  CreateReferralUseCase(this._service);
  
  Future<Referral> execute(Referral referral) async {
    // Add validation logic here
    return await _service.create(referral);
  }
}

class UpdateReferralUseCase {
  final ReferralService _service;
  
  UpdateReferralUseCase(this._service);
  
  Future<Referral> execute(String id, Referral referral) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, referral);
  }
}

class DeleteReferralUseCase {
  final ReferralService _service;
  
  DeleteReferralUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Referral Use Case Container
class ReferralUseCases {
  final GetReferralByIdUseCase getById;
  final GetReferralsUseCase getAll;
  final CreateReferralUseCase create;
  final UpdateReferralUseCase update;
  final DeleteReferralUseCase delete;
  
  ReferralUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReferralUseCases.create(ReferralService service) {
    return ReferralUseCases(
      getById: GetReferralByIdUseCase(service),
      getAll: GetReferralsUseCase(service),
      create: CreateReferralUseCase(service),
      update: UpdateReferralUseCase(service),
      delete: DeleteReferralUseCase(service),
    );
  }
}
