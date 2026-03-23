import '../../features/shared/services/gift_card_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for GiftCard

class GetGiftCardByIdUseCase {
  final GiftCardService _service;
  
  GetGiftCardByIdUseCase(this._service);
  
  Future<GiftCard> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetGiftCardsUseCase {
  final GiftCardService _service;
  
  GetGiftCardsUseCase(this._service);
  
  Future<List<GiftCard>> execute({
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

class CreateGiftCardUseCase {
  final GiftCardService _service;
  
  CreateGiftCardUseCase(this._service);
  
  Future<GiftCard> execute(GiftCard giftCard) async {
    // Add validation logic here
    return await _service.create(giftCard);
  }
}

class UpdateGiftCardUseCase {
  final GiftCardService _service;
  
  UpdateGiftCardUseCase(this._service);
  
  Future<GiftCard> execute(String id, GiftCard giftCard) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, giftCard);
  }
}

class DeleteGiftCardUseCase {
  final GiftCardService _service;
  
  DeleteGiftCardUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// GiftCard Use Case Container
class GiftCardUseCases {
  final GetGiftCardByIdUseCase getById;
  final GetGiftCardsUseCase getAll;
  final CreateGiftCardUseCase create;
  final UpdateGiftCardUseCase update;
  final DeleteGiftCardUseCase delete;
  
  GiftCardUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory GiftCardUseCases.create(GiftCardService service) {
    return GiftCardUseCases(
      getById: GetGiftCardByIdUseCase(service),
      getAll: GetGiftCardsUseCase(service),
      create: CreateGiftCardUseCase(service),
      update: UpdateGiftCardUseCase(service),
      delete: DeleteGiftCardUseCase(service),
    );
  }
}
