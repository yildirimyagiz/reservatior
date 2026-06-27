import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/auth_service.dart';
import 'package:reservatior/shared/services/facebook_auth_service.dart';
import 'package:reservatior/shared/services/twitter_auth_service.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> register(Map<String, dynamic> data);
  Future<User?> loginWithFacebook();
  Future<User?> loginWithTwitter();
  Future<void> logout();
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<bool> isAuthenticated();
  Future<User?> getMe();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;
  final FacebookAuthService _facebookService;
  final TwitterAuthService _twitterService;

  AuthRepositoryImpl(this._service, this._facebookService, this._twitterService);

  @override
  Future<User?> login(String email, String password) => _service.login(email, password);

  @override
  Future<User?> register(Map<String, dynamic> data) => _service.register(data);

  @override
  Future<User?> loginWithFacebook() async {
    final res = await _facebookService.signInWithFacebook();
    if (res != null && res['accessToken'] != null) {
      await _service.saveToken(res['accessToken']);
      return await _service.getMe();
    }
    return null;
  }

  @override
  Future<User?> loginWithTwitter() async {
    final res = await _twitterService.signInWithTwitter();
    if (res != null && res['accessToken'] != null) {
      await _service.saveToken(res['accessToken']);
      return await _service.getMe();
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _service.logout();
    await _facebookService.signOut();
    await _twitterService.signOut();
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) => _service.changePassword(currentPassword, newPassword);

  @override
  Future<bool> isAuthenticated() => _service.isAuthenticated();

  @override
  Future<User?> getMe() => _service.getMe();
}
