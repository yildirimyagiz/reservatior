import 'package:reservatior/shared/repositories/ambassador_campaign_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAmbassadorCampaignByIdUseCase {
  final AmbassadorCampaignRepository _repository;
  GetAmbassadorCampaignByIdUseCase(this._repository);
  Future<AmbassadorCampaign> execute(String id) => _repository.getById(id);
}

class GetAmbassadorCampaignsUseCase {
  final AmbassadorCampaignRepository _repository;
  GetAmbassadorCampaignsUseCase(this._repository);
  Future<List<AmbassadorCampaign>> execute({
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

class CreateAmbassadorCampaignUseCase {
  final AmbassadorCampaignRepository _repository;
  CreateAmbassadorCampaignUseCase(this._repository);
  Future<AmbassadorCampaign> execute(AmbassadorCampaign item) => _repository.create(item);
}

class UpdateAmbassadorCampaignUseCase {
  final AmbassadorCampaignRepository _repository;
  UpdateAmbassadorCampaignUseCase(this._repository);
  Future<AmbassadorCampaign> execute(String id, AmbassadorCampaign item) => _repository.update(id, item);
}

class DeleteAmbassadorCampaignUseCase {
  final AmbassadorCampaignRepository _repository;
  DeleteAmbassadorCampaignUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
