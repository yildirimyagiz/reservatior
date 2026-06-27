import 'package:reservatior/shared/repositories/referral_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReferralByIdUseCase {
  final ReferralRepository _repository;
  GetReferralByIdUseCase(this._repository);
  Future<Referral> execute(String id) => _repository.getById(id);
}

class GetReferralsUseCase {
  final ReferralRepository _repository;
  GetReferralsUseCase(this._repository);
  Future<List<Referral>> execute({
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

class CreateReferralUseCase {
  final ReferralRepository _repository;
  CreateReferralUseCase(this._repository);
  Future<Referral> execute(Referral item) => _repository.create(item);
}

class UpdateReferralUseCase {
  final ReferralRepository _repository;
  UpdateReferralUseCase(this._repository);
  Future<Referral> execute(String id, Referral item) => _repository.update(id, item);
}

class DeleteReferralUseCase {
  final ReferralRepository _repository;
  DeleteReferralUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
