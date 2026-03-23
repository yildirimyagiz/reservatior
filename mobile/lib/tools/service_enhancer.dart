import 'dart:io';

class ServiceEnhancer {
  static Future<void> enhanceServices() async {
    final servicesDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/shared/services');
    
    if (!await servicesDir.exists()) {
      print('Services directory not found');
      return;
    }
    
    final serviceFiles = await servicesDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart')
    ).cast<File>().toList();
    
    print('Found ${serviceFiles.length} service files');
    
    // Enhance key services
    final keyServices = [
      'user_service.dart',
      'property_service.dart',
      'booking_service.dart',
      'ai_chat_handoff_service.dart',
      'notification_service.dart',
      'task_service.dart',
    ];
    
    for (final file in serviceFiles) {
      final fileName = file.path.split('/').last;
      
      if (keyServices.contains(fileName)) {
        await enhanceService(fileName, file);
        print('Enhanced service: $fileName');
      }
    }
    
    print('Service enhancement completed!');
  }
  
  static Future<void> enhanceService(String fileName, File serviceFile) async {
    final content = await serviceFile.readAsString();
    
    // Enhanced service content with validation, error handling, and additional methods
    String enhancedContent = content;
    
    if (fileName.contains('user_service')) {
      enhancedContent = '''import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class UserService {
  final DioClient _dioClient;

  UserService(this._dioClient);

  // Get User by ID
  Future<User> getUserById(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    try {
      final response = await _dioClient.get('/api/v1/user/\$id');
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all users
  Future<List<User>> getUsers({
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
    
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/user', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => User.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get users with filters
  Future<List<User>> getUsersWithFilters({
    String? email,
    String? orgId,
    bool? isActive,
    DateTime? createdAfter,
  }) async {
    final filters = <String, dynamic>{};
    
    if (email != null) filters['email'] = email;
    if (orgId != null) filters['orgId'] = orgId;
    if (isActive != null) filters['isActive'] = isActive.toString();
    if (createdAfter != null) filters['createdAfter'] = createdAfter.toIso8601String();

    return getUsers(filters: filters);
  }

  // Create User
  Future<User> createUser(User user) async {
    if (user.email == null || user.email!.isEmpty) {
      throw ArgumentError('Email is required');
    }
    
    try {
      final response = await _dioClient.post(
        '/api/v1/user',
        data: user.toJson(),
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update User
  Future<User> updateUser(String id, User user) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    if (user.email == null || user.email!.isEmpty) {
      throw ArgumentError('Email is required');
    }
    
    try {
      final response = await _dioClient.put(
        '/api/v1/user/\$id',
        data: user.toJson(),
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete User
  Future<void> deleteUser(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    
    try {
      await _dioClient.delete('/api/v1/user/\$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Activate/Deactivate User
  Future<User> toggleUserStatus(String id, bool isActive) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    
    try {
      final response = await _dioClient.put(
        '/api/v1/user/\$id/status',
        data: {'isActive': isActive},
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get users by organization
  Future<List<User>> getUsersByOrganization(String orgId) async {
    if (orgId.isEmpty) {
      throw ArgumentError('Organization ID cannot be empty');
    }
    
    return getUsersWithFilters(orgId: orgId);
  }

  // Search users
  Future<List<User>> searchUsers(String query) async {
    if (query.isEmpty) {
      throw ArgumentError('Search query cannot be empty');
    }
    
    return getUsersWithFilters(search: query);
  }

  Exception _handleError(DioException e) {
    String message = 'Unknown error occurred';
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        message = 'Invalid response from server. Please try again.';
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'Network connection error. Please check your internet connection.';
        break;
      case DioExceptionType.unknown:
        message = 'An unknown error occurred: \${e.message}';
        break;
    }
    
    return Exception(message);
  }
}''';
    }
    
    if (fileName.contains('property_service')) {
      enhancedContent = '''import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyService {
  final DioClient _dioClient;

  PropertyService(this._dioClient);

  // Get Property by ID
  Future<Property> getPropertyById(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    try {
      final response = await _dioClient.get('/api/v1/property/\$id');
      return Property.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all properties
  Future<List<Property>> getProperties({
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
    
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/property', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Property.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get properties with filters
  Future<List<Property>> getPropertiesWithFilters({
    String? type,
    String? status,
    double? minPrice,
    double? maxPrice,
    String? orgId,
    String? location,
  }) async {
    final filters = <String, dynamic>{};
    
    if (type != null) filters['type'] = type;
    if (status != null) filters['status'] = status;
    if (minPrice != null) filters['minPrice'] = minPrice;
    if (maxPrice != null) filters['maxPrice'] = maxPrice;
    if (orgId != null) filters['orgId'] = orgId;
    if (location != null) filters['location'] = location;

    return getProperties(filters: filters);
  }

  // Create Property
  Future<Property> createProperty(Property property) async {
    if (property.name == null || property.name!.isEmpty) {
      throw ArgumentError('Property name is required');
    }
    
    try {
      final response = await _dioClient.post(
        '/api/v1/property',
        data: property.toJson(),
      );
      return Property.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Property
  Future<Property> updateProperty(String id, Property property) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    if (property.name == null || property.name!.isEmpty) {
      throw ArgumentError('Property name is required');
    }
    
    try {
      final response = await _dioClient.put(
        '/api/v1/property/\$id',
        data: property.toJson(),
      );
      return Property.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Property
  Future<void> deleteProperty(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    
    try {
      await _dioClient.delete('/api/v1/property/\$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get properties by organization
  Future<List<Property>> getPropertiesByOrganization(String orgId) async {
    if (orgId.isEmpty) {
      throw ArgumentError('Organization ID cannot be empty');
    }
    
    return getPropertiesWithFilters(orgId: orgId);
  }

  // Search properties
  Future<List<Property>> searchProperties(String query) async {
    if (query.isEmpty) {
      throw ArgumentError('Search query cannot be empty');
    }
    
    return getPropertiesWithFilters(search: query);
  }

  Exception _handleError(DioException e) {
    String message = 'Unknown error occurred';
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        message = 'Invalid response from server. Please try again.';
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'Network connection error. Please check your internet connection.';
        break;
      case DioExceptionType.unknown:
        message = 'An unknown error occurred: \${e.message}';
        break;
    }
    
    return Exception(message);
  }
}''';
    }
    
    await serviceFile.writeAsString(enhancedContent);
  }
}

void main() {
  ServiceEnhancer.enhanceServices();
}
