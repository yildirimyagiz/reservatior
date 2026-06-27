import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class FacebookAuthService {
  final DioClient _dioClient;
  
  FacebookAuthService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        
        final response = await _dioClient.post(
          '/auth/facebook/native', // Or the correct endpoint
          data: {
            'accessToken': accessToken.token,
          },
        );

        return response.data;
      } else {
        debugPrint('Facebook Sign-In failed: ${result.message}');
        return null;
      }
    } catch (e) {
      debugPrint('Facebook Sign-In error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      debugPrint('Facebook sign out error: $e');
    }
  }
}
