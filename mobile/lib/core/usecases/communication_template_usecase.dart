import 'package:reservatior/shared/repositories/communication_template_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCommunicationTemplateByIdUseCase {
  final CommunicationTemplateRepository _repository;
  GetCommunicationTemplateByIdUseCase(this._repository);
  Future<CommunicationTemplate> execute(String id) => _repository.getById(id);
}

class GetCommunicationTemplatesUseCase {
  final CommunicationTemplateRepository _repository;
  GetCommunicationTemplatesUseCase(this._repository);
  Future<List<CommunicationTemplate>> execute({
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

class CreateCommunicationTemplateUseCase {
  final CommunicationTemplateRepository _repository;
  CreateCommunicationTemplateUseCase(this._repository);
  Future<CommunicationTemplate> execute(CommunicationTemplate item) => _repository.create(item);
}

class UpdateCommunicationTemplateUseCase {
  final CommunicationTemplateRepository _repository;
  UpdateCommunicationTemplateUseCase(this._repository);
  Future<CommunicationTemplate> execute(String id, CommunicationTemplate item) => _repository.update(id, item);
}

class DeleteCommunicationTemplateUseCase {
  final CommunicationTemplateRepository _repository;
  DeleteCommunicationTemplateUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
