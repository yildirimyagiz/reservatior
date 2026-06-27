import 'package:reservatior/shared/repositories/mortgage_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMortgageOfferByIdUseCase {
  final MortgageOfferRepository _repository;
  GetMortgageOfferByIdUseCase(this._repository);
  Future<MortgageOffer> execute(String id) => _repository.getById(id);
}

class GetMortgageOffersUseCase {
  final MortgageOfferRepository _repository;
  GetMortgageOffersUseCase(this._repository);
  Future<List<MortgageOffer>> execute({
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

class CreateMortgageOfferUseCase {
  final MortgageOfferRepository _repository;
  CreateMortgageOfferUseCase(this._repository);
  Future<MortgageOffer> execute(MortgageOffer item) => _repository.create(item);
}

class UpdateMortgageOfferUseCase {
  final MortgageOfferRepository _repository;
  UpdateMortgageOfferUseCase(this._repository);
  Future<MortgageOffer> execute(String id, MortgageOffer item) => _repository.update(id, item);
}

class DeleteMortgageOfferUseCase {
  final MortgageOfferRepository _repository;
  DeleteMortgageOfferUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
