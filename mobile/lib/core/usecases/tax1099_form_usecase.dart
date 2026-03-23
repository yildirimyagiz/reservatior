import '../../features/shared/services/tax1099_form_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Tax1099Form

class GetTax1099FormByIdUseCase {
  final Tax1099FormService _service;
  
  GetTax1099FormByIdUseCase(this._service);
  
  Future<Tax1099Form> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTax1099FormsUseCase {
  final Tax1099FormService _service;
  
  GetTax1099FormsUseCase(this._service);
  
  Future<List<Tax1099Form>> execute({
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

class CreateTax1099FormUseCase {
  final Tax1099FormService _service;
  
  CreateTax1099FormUseCase(this._service);
  
  Future<Tax1099Form> execute(Tax1099Form tax1099Form) async {
    // Add validation logic here
    return await _service.create(tax1099Form);
  }
}

class UpdateTax1099FormUseCase {
  final Tax1099FormService _service;
  
  UpdateTax1099FormUseCase(this._service);
  
  Future<Tax1099Form> execute(String id, Tax1099Form tax1099Form) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, tax1099Form);
  }
}

class DeleteTax1099FormUseCase {
  final Tax1099FormService _service;
  
  DeleteTax1099FormUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Tax1099Form Use Case Container
class Tax1099FormUseCases {
  final GetTax1099FormByIdUseCase getById;
  final GetTax1099FormsUseCase getAll;
  final CreateTax1099FormUseCase create;
  final UpdateTax1099FormUseCase update;
  final DeleteTax1099FormUseCase delete;
  
  Tax1099FormUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory Tax1099FormUseCases.create(Tax1099FormService service) {
    return Tax1099FormUseCases(
      getById: GetTax1099FormByIdUseCase(service),
      getAll: GetTax1099FormsUseCase(service),
      create: CreateTax1099FormUseCase(service),
      update: UpdateTax1099FormUseCase(service),
      delete: DeleteTax1099FormUseCase(service),
    );
  }
}
