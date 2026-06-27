import 'dart:io'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn;
  final DioClient _dioClient;
  
  GoogleAuthService({
    GoogleSignIn? googleSignIn,
    required DioClient dioClient,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(clientId: '851507782363-4favlf24174r6572rdc158ochos8t4f8.apps.googleusercontent.com'),
        _dioClient = dioClient;

  // Initialize Google Sign-In
  Future<void> initialize() async {
    try {
      await _googleSignIn.signInSilently();
    } catch (e) {
      debugPrint('Google Sign-In initialization failed: $e');
    }
  }

  // Sign in with Google
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
        // For web and iOS
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        return googleUser;
      } else {
        // For Android with server client ID
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        return googleUser;
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      return null;
    }
  }

  // Complete Google Sign-In flow
  Future<Map<String, dynamic>?> completeGoogleSignIn() async {
    try {
      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await signInWithGoogle();
      if (googleUser == null) {
        throw Exception('Google Sign-In was cancelled');
      }

      // Step 2: Get authentication tokens
      final auth = await googleUser.authentication;
      
      // Step 3: Send to backend for authentication
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/google',
        data: {
          'accessToken': auth.accessToken,
          'idToken': auth.idToken,
          'email': googleUser.email,
          'displayName': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
        },
      );

      return response.data;
    } catch (e) {
      debugPrint('Complete Google Sign-In error: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();
      
      debugPrint('mobile.leftovers.successfully_signed_out_from_google'.tr());
    } catch (e) {
      debugPrint('Sign out error: $e');
    }
  }

  // Get current user
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  // Check if user is signed in
  bool get isSignedIn => _googleSignIn.currentUser != null;

  // Get user profile photo
  String? get profilePhotoUrl => _googleSignIn.currentUser?.photoUrl;

  // Get user display name
  String? get displayName => _googleSignIn.currentUser?.displayName;

  // Get user email
  String? get email => _googleSignIn.currentUser?.email;

  // Refresh Google Sign-In token
  Future<GoogleSignInAccount?> refreshAuth() async {
    try {
      await _googleSignIn.signOut();
      return await _googleSignIn.signInSilently();
    } catch (e) {
      debugPrint('Refresh auth error: $e');
      return null;
    }
  }

  // Handle Google Sign-In for web
  Future<GoogleSignInAccount?> signInWithGoogleWeb() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      return googleUser;
    } catch (e) {
      debugPrint('Web Google Sign-In error: $e');
      return null;
    }
  }

  // Handle Google Sign-In for mobile
  Future<GoogleSignInAccount?> signInWithGoogleMobile() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      return googleUser;
    } catch (e) {
      debugPrint('Mobile Google Sign-In error: $e');
      return null;
    }
  }

  // Disconnect from Google (revokes access)
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      debugPrint('mobile.leftovers.successfully_disconnected_from_google'.tr());
    } catch (e) {
      debugPrint('Disconnect error: $e');
    }
  }
}
