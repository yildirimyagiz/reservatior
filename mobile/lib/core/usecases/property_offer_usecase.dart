import 'package:reservatior/shared/repositories/property_offer_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyOfferByIdUseCase {
  final PropertyOfferRepository _repository;
  GetPropertyOfferByIdUseCase(this._repository);
  Future<PropertyOffer> execute(String id) => _repository.getById(id);
}

class GetPropertyOffersUseCase {
  final PropertyOfferRepository _repository;
  GetPropertyOffersUseCase(this._repository);
  Future<List<PropertyOffer>> execute({
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

class CreatePropertyOfferUseCase {
  final PropertyOfferRepository _repository;
  CreatePropertyOfferUseCase(this._repository);
  Future<PropertyOffer> execute(PropertyOffer item) => _repository.create(item);
}

class UpdatePropertyOfferUseCase {
  final PropertyOfferRepository _repository;
  UpdatePropertyOfferUseCase(this._repository);
  Future<PropertyOffer> execute(String id, PropertyOffer item) => _repository.update(id, item);
}

class DeletePropertyOfferUseCase {
  final PropertyOfferRepository _repository;
  DeletePropertyOfferUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
