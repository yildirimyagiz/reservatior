import '../../features/shared/services/channel_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Channel

class GetChannelByIdUseCase {
  final ChannelService _service;
  
  GetChannelByIdUseCase(this._service);
  
  Future<Channel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetChannelsUseCase {
  final ChannelService _service;
  
  GetChannelsUseCase(this._service);
  
  Future<List<Channel>> execute({
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

class CreateChannelUseCase {
  final ChannelService _service;
  
  CreateChannelUseCase(this._service);
  
  Future<Channel> execute(Channel channel) async {
    // Add validation logic here
    return await _service.create(channel);
  }
}

class UpdateChannelUseCase {
  final ChannelService _service;
  
  UpdateChannelUseCase(this._service);
  
  Future<Channel> execute(String id, Channel channel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, channel);
  }
}

class DeleteChannelUseCase {
  final ChannelService _service;
  
  DeleteChannelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Channel Use Case Container
class ChannelUseCases {
  final GetChannelByIdUseCase getById;
  final GetChannelsUseCase getAll;
  final CreateChannelUseCase create;
  final UpdateChannelUseCase update;
  final DeleteChannelUseCase delete;
  
  ChannelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ChannelUseCases.create(ChannelService service) {
    return ChannelUseCases(
      getById: GetChannelByIdUseCase(service),
      getAll: GetChannelsUseCase(service),
      create: CreateChannelUseCase(service),
      update: UpdateChannelUseCase(service),
      delete: DeleteChannelUseCase(service),
    );
  }
}
