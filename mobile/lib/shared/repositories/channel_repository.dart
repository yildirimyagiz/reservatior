import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/channel_service.dart';

abstract class ChannelRepository {
  Future<Channel> getById(String id);
  Future<List<Channel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Channel> create(Channel item);
  Future<Channel> update(String id, Channel item);
  Future<void> delete(String id);
}

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelService _service;
  ChannelRepositoryImpl(this._service);

  @override
  Future<Channel> getById(String id) => _service.getChannelById(id);

  @override
  Future<List<Channel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getChannels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Channel> create(Channel item) => _service.createChannel(item);

  @override
  Future<Channel> update(String id, Channel item) => _service.updateChannel(id, item);

  @override
  Future<void> delete(String id) => _service.deleteChannel(id);
}
