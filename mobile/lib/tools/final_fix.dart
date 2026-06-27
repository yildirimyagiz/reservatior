import 'dart:io'; 
import 'package:easy_localization/easy_localization.dart';

class FinalRefinedGenerator {
  static Future<void> fixAccountFeature() async {
    const servicePath = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/services/account_service.dart';
    const repoPath = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/repositories/account_repository.dart';
    
    final serviceContent = '''mobile.leftovers.import'.tr()package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import 'package:reservatior/models/models.dart';

class AccountService {
  final DioClient _dioClient;
  AccountService(this._dioClient);

  Future<Account> getAccountById(String id) async {
    final response = await _dioClient.get('/api/v1/account/\$id');
    return Account.fromJson(response.data['data']);
  }

  Future<List<Account>> getAccounts({int page = 1, int limit = 20, Map<String, dynamic>? filters, String? sortBy, String? sortOrder}) async {
    final response = await _dioClient.get('/api/v1/account', queryParameters: {'page': page, 'limit': limit, 'sortBy': sortBy, 'sortOrder': sortOrder, ...?filters});
    final data = response.data['data'] as List;
    return data.map((json) => Account.fromJson(json)).toList();
  }

  Future<List<Account>> searchAccounts({required String query, int page = 1}) async {
    final response = await _dioClient.get('/api/v1/account/search', queryParameters: {'query': query, 'page': page});
    final data = response.data['data'] as List;
    return data.map((json) => Account.fromJson(json)).toList();
  }

  Future<Account> createAccount(Account item) async {
    final response = await _dioClient.post('/api/v1/account', data: item.toJson());
    return Account.fromJson(response.data['data']);
  }

  Future<Account> updateAccount(String id, Account item) async {
    final response = await _dioClient.put('/api/v1/account/\$id', data: item.toJson());
    return Account.fromJson(response.data['data']);
  }

  Future<void> deleteAccount(String id) async {
    await _dioClient.delete('/api/v1/account/\$id');
  }

  Future<Account> activateAccount(String id) async {
    final response = await _dioClient.post('/api/v1/account/\$id/activate');
    return Account.fromJson(response.data['data']);
  }

  Future<Account> deactivateAccount(String id) async {
    final response = await _dioClient.post('/api/v1/account/\$id/deactivate');
    return Account.fromJson(response.data['data']);
  }

  Future<Account> refreshToken(String id) async {
    final response = await _dioClient.post('/api/v1/account/\$id/refresh');
    return Account.fromJson(response.data['data']);
  }

  Future<Map<String, dynamic>> getAccountStats() async {
    final response = await _dioClient.get('/api/v1/account/stats');
    return response.data['data'] as Map<String, dynamic>;
  }
}
''';
    await File(servicePath).writeAsString(serviceContent);
  }

  static Future<void> fixAchievementFeature() async {
    const servicePath = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/services/achievement_service.dart';
    final serviceContent = '''mobile.leftovers.import'.tr()package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import 'package:reservatior/models/models.dart';

class AchievementService {
  final DioClient _dioClient;
  AchievementService(this._dioClient);

  Future<Achievement> getAchievementById(String id) async => 
    Achievement.fromJson((await _dioClient.get('/api/v1/achievement/\$id')).data['data']);

  Future<List<Achievement>> getAchievements({int page = 1, int limit = 20, Map<String, dynamic>? filters, String? sortBy, String? sortOrder}) async {
    final response = await _dioClient.get('/api/v1/achievement', queryParameters: {'page': page, 'limit': limit, 'sortBy': sortBy, 'sortOrder': sortOrder, ...?filters});
    return (response.data['data'] as List).map((j) => Achievement.fromJson(j)).toList();
  }

  Future<List<Achievement>> getUserAchievements(String userId) async {
    final response = await _dioClient.get('/api/v1/user/\$userId/achievements');
    return (response.data['data'] as List).map((j) => Achievement.fromJson(j)).toList();
  }

  Future<List<Achievement>> searchAchievements({required String query, int page = 1}) async {
    final response = await _dioClient.get('/api/v1/achievement/search', queryParameters: {'query': query, 'page': page});
    return (response.data['data'] as List).map((j) => Achievement.fromJson(j)).toList();
  }

  Future<Map<String, dynamic>> getUserStats(String userId) async {
    return (await _dioClient.get('/api/v1/user/\$userId/achievement-stats')).data['data'];
  }

  Future<Map<String, dynamic>> getGlobalStats() async {
    return (await _dioClient.get('/api/v1/achievement/global-stats')).data['data'];
  }

  Future<List<Map<String, dynamic>>> getLeaderboard({String? goalType, int limit = 10}) async {
    return List<Map<String, dynamic>>.from((await _dioClient.get('/api/v1/achievement/leaderboard', queryParameters: {'goalType': goalType, 'limit': limit})).data['data']);
  }
}
''';
    await File(servicePath).writeAsString(serviceContent);
  }
}

void main() async {
  await FinalRefinedGenerator.fixAccountFeature();
  await FinalRefinedGenerator.fixAchievementFeature();
  print('Final fix applied!');
}
