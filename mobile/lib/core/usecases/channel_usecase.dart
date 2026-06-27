import 'package:reservatior/shared/repositories/channel_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetChannelByIdUseCase {
  final ChannelRepository _repository;
  GetChannelByIdUseCase(this._repository);
  Future<Channel> execute(String id) => _repository.getById(id);
}

class GetChannelsUseCase {
  final ChannelRepository _repository;
  GetChannelsUseCase(this._repository);
  Future<List<Channel>> execute({
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

class CreateChannelUseCase {
  final ChannelRepository _repository;
  CreateChannelUseCase(this._repository);
  Future<Channel> execute(Channel item) => _repository.create(item);
}

class UpdateChannelUseCase {
  final ChannelRepository _repository;
  UpdateChannelUseCase(this._repository);
  Future<Channel> execute(String id, Channel item) => _repository.update(id, item);
}

class DeleteChannelUseCase {
  final ChannelRepository _repository;
  DeleteChannelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
