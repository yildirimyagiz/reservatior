import 'package:reservatior/shared/repositories/negotiation_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetNegotiationOfferByIdUseCase {
  final NegotiationOfferRepository _repository;
  GetNegotiationOfferByIdUseCase(this._repository);
  Future<NegotiationOffer> execute(String id) => _repository.getById(id);
}

class GetNegotiationOffersUseCase {
  final NegotiationOfferRepository _repository;
  GetNegotiationOffersUseCase(this._repository);
  Future<List<NegotiationOffer>> execute({
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

class CreateNegotiationOfferUseCase {
  final NegotiationOfferRepository _repository;
  CreateNegotiationOfferUseCase(this._repository);
  Future<NegotiationOffer> execute(NegotiationOffer item) => _repository.create(item);
}

class UpdateNegotiationOfferUseCase {
  final NegotiationOfferRepository _repository;
  UpdateNegotiationOfferUseCase(this._repository);
  Future<NegotiationOffer> execute(String id, NegotiationOffer item) => _repository.update(id, item);
}

class DeleteNegotiationOfferUseCase {
  final NegotiationOfferRepository _repository;
  DeleteNegotiationOfferUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
