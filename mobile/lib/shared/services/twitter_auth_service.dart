import 'package:flutter/foundation.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:reservatior/core/network/dio_client.dart';

class TwitterAuthService {
  final DioClient _dioClient;
  
  TwitterAuthService({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Map<String, dynamic>?> signInWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: 'Tlc3dFdna1JPT3QzVngyX0ZXQjY6MTpjaQ', // Fallback, normally from env
        apiSecretKey: 'h0ZSXydInJN0Aqs6SgPE6fYRcv1FLvArGAOSYXqapICEdP_T7z',
        redirectURI: 'twitterkit-Tlc3dFdna1JPT3QzVngyX0ZXQjY6MTpjaQ://',
      );

      final authResult = await twitterLogin.loginV2();

      if (authResult.status == TwitterLoginStatus.loggedIn) {
        final user = authResult.user;
        
        final response = await _dioClient.post(
          '/auth/twitter/native',
          data: {
            'accessToken': authResult.authToken,
            'twitterId': user?.id.toString(),
            'name': user?.name,
            'email': user?.email,
            'photoUrl': user?.thumbnailImage,
          },
        );

        return response.data;
      } else {
        debugPrint('Twitter Sign-In failed: ${authResult.status}');
        return null;
      }
    } catch (e) {
      debugPrint('Twitter Sign-In error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    // Twitter login doesn't have a specific sign out, it clears when app is uninstalled or cookie expires.
  }
}
