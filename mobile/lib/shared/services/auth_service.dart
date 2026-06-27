import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final DioClient _dioClient;
  final _storage = const FlutterSecureStorage();
  
  AuthService(this._dioClient);

  Future<User?> login(String email, String password) async {
    print('Attempting login to: ${ApiEndpoints.login}');
    print('Email: $email, Password: ${password.length > 0 ? "***" : "empty"}');
    
    try {
      final response = await _dioClient.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });
      
      // Debug: Print response structure
      print('Login response status: ${response.statusCode}');
      print('Login response: ${response.data}');
      
      // Extract and save token
      final token = response.data['token'] ?? response.data['data']?['token'] ?? response.data['user']?['token'];
      if (token != null) {
        await _storage.write(key: 'access_token', value: token);
        print('Token saved to storage: ${token.substring(0, 20)}...');
      } else {
        print('No token found in response');
      }
      
      // Handle different response structures
      dynamic userData;
      if (response.data['data'] != null) {
        userData = response.data['data'];
      } else if (response.data['user'] != null) {
        userData = response.data['user'];
      } else if (response.data is Map<String, dynamic>) {
        userData = response.data;
      } else {
        print('No valid user data found in response');
        return null;
      }
      
      print('User data parsed successfully');
      return User.fromJson(userData as Map<String, dynamic>);
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<User?> register(Map<String, dynamic> data) async {
    final response = await _dioClient.post(ApiEndpoints.register, data: data);
    
    // Debug: Print response structure
    print('Register response: ${response.data}');
    
    // Handle different response structures
    dynamic userData;
    if (response.data['data'] != null) {
      userData = response.data['data'];
    } else if (response.data['user'] != null) {
      userData = response.data['user'];
    } else if (response.data is Map<String, dynamic>) {
      userData = response.data;
    } else {
      return null;
    }
    
    return User.fromJson(userData as Map<String, dynamic>);
  }

  Future<void> logout() async {
    await _dioClient.post(ApiEndpoints.logout);
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    await _dioClient.post(ApiEndpoints.changePassword, data: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }

  Future<bool> isAuthenticated() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.me);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<User?> getMe() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.me);
      
      // Debug: Print response structure
      print('GetMe response: ${response.data}');
      
      // Handle different response structures
      dynamic userData;
      if (response.data['data'] != null) {
        userData = response.data['data'];
      } else if (response.data['user'] != null) {
        userData = response.data['user'];
      } else if (response.data is Map<String, dynamic>) {
        userData = response.data;
      } else {
        return null;
      }
      
      return User.fromJson(userData as Map<String, dynamic>);
    } catch (e) {
      print('GetMe error: $e');
      return null;
    }
  }

  Future<User?> updateUserProfile(Map<String, dynamic> data) async {
    final response = await _dioClient.patch(ApiEndpoints.me, data: data);
    return User.fromJson(response.data['data']);
  }
}
