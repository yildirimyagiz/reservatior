import '../../features/shared/services/communication_template_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for CommunicationTemplate

class GetCommunicationTemplateByIdUseCase {
  final CommunicationTemplateService _service;
  
  GetCommunicationTemplateByIdUseCase(this._service);
  
  Future<CommunicationTemplate> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCommunicationTemplatesUseCase {
  final CommunicationTemplateService _service;
  
  GetCommunicationTemplatesUseCase(this._service);
  
  Future<List<CommunicationTemplate>> execute({
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

class CreateCommunicationTemplateUseCase {
  final CommunicationTemplateService _service;
  
  CreateCommunicationTemplateUseCase(this._service);
  
  Future<CommunicationTemplate> execute(CommunicationTemplate communicationTemplate) async {
    // Add validation logic here
    return await _service.create(communicationTemplate);
  }
}

class UpdateCommunicationTemplateUseCase {
  final CommunicationTemplateService _service;
  
  UpdateCommunicationTemplateUseCase(this._service);
  
  Future<CommunicationTemplate> execute(String id, CommunicationTemplate communicationTemplate) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, communicationTemplate);
  }
}

class DeleteCommunicationTemplateUseCase {
  final CommunicationTemplateService _service;
  
  DeleteCommunicationTemplateUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// CommunicationTemplate Use Case Container
class CommunicationTemplateUseCases {
  final GetCommunicationTemplateByIdUseCase getById;
  final GetCommunicationTemplatesUseCase getAll;
  final CreateCommunicationTemplateUseCase create;
  final UpdateCommunicationTemplateUseCase update;
  final DeleteCommunicationTemplateUseCase delete;
  
  CommunicationTemplateUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CommunicationTemplateUseCases.create(CommunicationTemplateService service) {
    return CommunicationTemplateUseCases(
      getById: GetCommunicationTemplateByIdUseCase(service),
      getAll: GetCommunicationTemplatesUseCase(service),
      create: CreateCommunicationTemplateUseCase(service),
      update: UpdateCommunicationTemplateUseCase(service),
      delete: DeleteCommunicationTemplateUseCase(service),
    );
  }
}
