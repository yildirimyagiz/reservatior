import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();
  final Logger _logger = Logger();

  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      _logger.e('Error checking biometric availability: $e');
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      _logger.e('Error getting available biometrics: $e');
      return [];
    }
  }

  Future<bool> authenticate({
    required String reason,
    bool stickyAuth = true,
    bool biometricOnly = false,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        
      );
    } catch (e) {
      _logger.e('Error during biometric authentication: $e');
      return false;
    }
  }
}
