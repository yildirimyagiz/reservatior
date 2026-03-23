import '../../features/shared/services/contact_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Contact

class GetContactByIdUseCase {
  final ContactService _service;
  
  GetContactByIdUseCase(this._service);
  
  Future<Contact> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetContactsUseCase {
  final ContactService _service;
  
  GetContactsUseCase(this._service);
  
  Future<List<Contact>> execute({
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

class CreateContactUseCase {
  final ContactService _service;
  
  CreateContactUseCase(this._service);
  
  Future<Contact> execute(Contact contact) async {
    // Add validation logic here
    return await _service.create(contact);
  }
}

class UpdateContactUseCase {
  final ContactService _service;
  
  UpdateContactUseCase(this._service);
  
  Future<Contact> execute(String id, Contact contact) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, contact);
  }
}

class DeleteContactUseCase {
  final ContactService _service;
  
  DeleteContactUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Contact Use Case Container
class ContactUseCases {
  final GetContactByIdUseCase getById;
  final GetContactsUseCase getAll;
  final CreateContactUseCase create;
  final UpdateContactUseCase update;
  final DeleteContactUseCase delete;
  
  ContactUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ContactUseCases.create(ContactService service) {
    return ContactUseCases(
      getById: GetContactByIdUseCase(service),
      getAll: GetContactsUseCase(service),
      create: CreateContactUseCase(service),
      update: UpdateContactUseCase(service),
      delete: DeleteContactUseCase(service),
    );
  }
}
