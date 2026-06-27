import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:reservatior/shared/services/google_auth_service.dart';
import 'package:reservatior/shared/services/auth_service.dart';
import 'package:reservatior/shared/models/models.dart' as models;
import 'dio_client_provider.dart';
import 'auth_provider.dart';

// Google Auth Service Provider
final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GoogleAuthService(dioClient: dioClient);
});

// Google Auth State
class GoogleAuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final GoogleSignInAccount? googleUser;

  const GoogleAuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.googleUser,
  });

  GoogleAuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    GoogleSignInAccount? googleUser,
  }) {
    return GoogleAuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      googleUser: googleUser ?? this.googleUser,
    );
  }
}

// Google Auth Provider
class GoogleAuthNotifier extends StateNotifier<GoogleAuthState> {
  final GoogleAuthService _googleAuthService;
  final AuthService _authService;

  GoogleAuthNotifier(this._googleAuthService, this._authService)
      : super(const GoogleAuthState());

  // Initialize Google Sign-In
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _googleAuthService.initialize();
      
      // Check if user is already signed in
      if (_googleAuthService.isSignedIn) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          googleUser: _googleAuthService.currentUser,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Complete Google Sign-In flow
      final result = await _googleAuthService.completeGoogleSignIn();
      
      if (result != null && result['success'] == true) {
        // Update user data in auth service
        final userData = result['user'];
        if (userData != null) {
          await _authService.updateUserProfile(userData);
        }
        
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          googleUser: _googleAuthService.currentUser,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result?['error'] ?? 'mobile.leftovers.google_sign_in_failed'.tr(),
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _googleAuthService.signOut();
      await _authService.logout();
      
      state = const GoogleAuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Disconnect (revoke access)
  Future<void> disconnect() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _googleAuthService.disconnect();
      await _authService.logout();
      
      state = const GoogleAuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Refresh authentication
  Future<void> refreshAuth() async {
    try {
      final refreshedUser = await _googleAuthService.refreshAuth();
      
      if (refreshedUser != null) {
        state = state.copyWith(
          googleUser: refreshedUser,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Get user profile data
  Map<String, dynamic> get userProfile {
    return {
      'displayName': _googleAuthService.displayName,
      'email': _googleAuthService.email,
      'photoUrl': _googleAuthService.profilePhotoUrl,
      'isGoogleUser': true,
    };
  }
}

// Google Auth Provider
final googleAuthProvider = StateNotifierProvider<GoogleAuthNotifier, GoogleAuthState>((ref) {
  final googleAuthService = ref.watch(googleAuthServiceProvider);
  final authService = ref.watch(authServiceProvider);
  return GoogleAuthNotifier(googleAuthService, authService);
});

// Combined Auth State Provider (for both regular and Google auth)
class CombinedAuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final models.User? user;
  final bool isGoogleUser;

  const CombinedAuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.user,
    this.isGoogleUser = false,
  });

  CombinedAuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    models.User? user,
    bool? isGoogleUser,
  }) {
    return CombinedAuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      user: user ?? this.user,
      isGoogleUser: isGoogleUser ?? this.isGoogleUser,
    );
  }
}

// Combined Auth Provider
final combinedAuthProvider = Provider<CombinedAuthState>((ref) {
  final authState = ref.watch(authProvider);
  final googleState = ref.watch(googleAuthProvider);
  
  final isLoading = authState.status == AuthStatus.loading || googleState.isLoading;
  final isAuthenticated = authState.status == AuthStatus.authenticated || googleState.isAuthenticated;
  final error = authState.errorMessage ?? googleState.error;
  final user = authState.user;
  final isGoogleUser = googleState.isAuthenticated;
  
  return CombinedAuthState(
    isLoading: isLoading,
    isAuthenticated: isAuthenticated,
    error: error,
    user: user,
    isGoogleUser: isGoogleUser,
  );
});

// Google Auth Stream Provider
final googleAuthStreamProvider = StreamProvider<GoogleSignInAccount?>((ref) {
  final googleAuthService = ref.watch(googleAuthServiceProvider);
  // Since we removed Firebase, we'll return a stream that emits current user or null
  return Stream.value(googleAuthService.currentUser);
});

// Google User Info Provider
final googleUserInfoProvider = Provider<Map<String, dynamic>?>((ref) {
  final googleState = ref.watch(googleAuthProvider);
  
  if (!googleState.isAuthenticated) return null;
  
  return {
    'displayName': googleState.googleUser?.displayName,
    'email': googleState.googleUser?.email,
    'photoUrl': googleState.googleUser?.photoUrl,
    'id': googleState.googleUser?.id,
  };
});

// Google Sign-In Availability Provider
final googleSignInAvailableProvider = Provider<bool>((ref) {
  // Check if Google Sign-In is available on this platform
  try {
    return true; // For now, assume it's available
  } catch (e) {
    return false;
  }
});
