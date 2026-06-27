import 'package:reservatior/shared/repositories/offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetOfferByIdUseCase {
  final OfferRepository _repository;
  GetOfferByIdUseCase(this._repository);
  Future<Offer> execute(String id) => _repository.getById(id);
}

class GetOffersUseCase {
  final OfferRepository _repository;
  GetOffersUseCase(this._repository);
  Future<List<Offer>> execute({
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

class CreateOfferUseCase {
  final OfferRepository _repository;
  CreateOfferUseCase(this._repository);
  Future<Offer> execute(Offer item) => _repository.create(item);
}

class UpdateOfferUseCase {
  final OfferRepository _repository;
  UpdateOfferUseCase(this._repository);
  Future<Offer> execute(String id, Offer item) => _repository.update(id, item);
}

class DeleteOfferUseCase {
  final OfferRepository _repository;
  DeleteOfferUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
