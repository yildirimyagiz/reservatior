import 'package:flutter/foundation.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/auth_service.dart';
import 'package:reservatior/shared/services/facebook_auth_service.dart';
import 'package:reservatior/shared/services/twitter_auth_service.dart';
import 'package:reservatior/shared/repositories/auth_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthService(dio);
});

final facebookAuthServiceProvider = Provider<FacebookAuthService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return FacebookAuthService(dioClient: dio);
});

final twitterAuthServiceProvider = Provider<TwitterAuthService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return TwitterAuthService(dioClient: dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  final facebookService = ref.watch(facebookAuthServiceProvider);
  final twitterService = ref.watch(twitterAuthServiceProvider);
  return AuthRepositoryImpl(service, facebookService, twitterService);
});

enum AuthStatus { initial, authenticated, unauthenticated, loading, error }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated(User user) => AuthState(status: AuthStatus.authenticated, user: user);
  factory AuthState.unauthenticated() => AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.error(String message) => AuthState(status: AuthStatus.error, errorMessage: message);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      final isAuthed = await _authRepository.isAuthenticated();
      if (!isAuthed) {
        state = AuthState.unauthenticated();
        return;
      }
      
      final user = await _authRepository.getMe().timeout(const Duration(seconds: 10));
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      debugPrint('Auth check failed: $e');
      state = AuthState.unauthenticated();
    }
  }

  Future<void> checkAuth() => checkAuthStatus();

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.error('mobile.leftovers.login_failed'.tr());
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> loginWithFacebook() async {
    state = AuthState.loading();
    try {
      final user = await _authRepository.loginWithFacebook();
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> loginWithTwitter() async {
    state = AuthState.loading();
    try {
      final user = await _authRepository.loginWithTwitter();
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    state = AuthState.loading();
    try {
      final user = await _authRepository.register(data);
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.error('mobile.leftovers.registration_failed'.tr());
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = AuthState.unauthenticated();
  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
