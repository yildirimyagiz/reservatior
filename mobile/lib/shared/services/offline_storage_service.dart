import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class OfflineStorageService {
  late Box _offlineActionsBox;
  final Logger _logger = Logger();

  Future<void> init() async {
    await Hive.initFlutter();
    _offlineActionsBox = await Hive.openBox('offline_actions');
  }

  Future<void> queueAction(Map<String, dynamic> action) async {
    await _offlineActionsBox.add(action);
    _logger.i('Action queued offline: ${action['type']}');
  }

  List<Map<String, dynamic>> getQueuedActions() {
    return _offlineActionsBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> clearAction(int index) async {
    await _offlineActionsBox.deleteAt(index);
  }

  Future<void> clearAll() async {
    await _offlineActionsBox.clear();
  }
}
