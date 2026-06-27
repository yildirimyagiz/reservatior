import 'package:reservatior/shared/repositories/contact_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetContactByIdUseCase {
  final ContactRepository _repository;
  GetContactByIdUseCase(this._repository);
  Future<Contact> execute(String id) => _repository.getById(id);
}

class GetContactsUseCase {
  final ContactRepository _repository;
  GetContactsUseCase(this._repository);
  Future<List<Contact>> execute({
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

class CreateContactUseCase {
  final ContactRepository _repository;
  CreateContactUseCase(this._repository);
  Future<Contact> execute(Contact item) => _repository.create(item);
}

class UpdateContactUseCase {
  final ContactRepository _repository;
  UpdateContactUseCase(this._repository);
  Future<Contact> execute(String id, Contact item) => _repository.update(id, item);
}

class DeleteContactUseCase {
  final ContactRepository _repository;
  DeleteContactUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
