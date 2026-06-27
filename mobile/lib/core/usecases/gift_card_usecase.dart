import 'package:reservatior/shared/repositories/gift_card_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetGiftCardByIdUseCase {
  final GiftCardRepository _repository;
  GetGiftCardByIdUseCase(this._repository);
  Future<GiftCard> execute(String id) => _repository.getById(id);
}

class GetGiftCardsUseCase {
  final GiftCardRepository _repository;
  GetGiftCardsUseCase(this._repository);
  Future<List<GiftCard>> execute({
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

class CreateGiftCardUseCase {
  final GiftCardRepository _repository;
  CreateGiftCardUseCase(this._repository);
  Future<GiftCard> execute(GiftCard item) => _repository.create(item);
}

class UpdateGiftCardUseCase {
  final GiftCardRepository _repository;
  UpdateGiftCardUseCase(this._repository);
  Future<GiftCard> execute(String id, GiftCard item) => _repository.update(id, item);
}

class DeleteGiftCardUseCase {
  final GiftCardRepository _repository;
  DeleteGiftCardUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
