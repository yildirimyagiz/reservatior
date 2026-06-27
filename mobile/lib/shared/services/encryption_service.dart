import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:typed_data';

class EncryptionService {
  final String _keyString; // User-specific key derived from password/device
  late final encrypt.Key _key;
  late final encrypt.IV _iv;

  EncryptionService(this._keyString) {
    // Derive a 32-byte key from the provided string
    final keyHash = sha256.convert(utf8.encode(_keyString)).bytes;
    _key = encrypt.Key(Uint8List.fromList(keyHash));
    // Fixed IV for this example, but should be unique per message in real E2EE
    _iv = encrypt.IV.fromLength(16);
  }

  String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decryptData(String encryptedBase64) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = encrypter.decrypt64(encryptedBase64, iv: _iv);
    return decrypted;
  }

  // Helper for generating deterministic keys
  static String generateKeyFromPassword(String email, String password) {
    final bytes = utf8.encode('$email:$password');
    final digest = sha512.convert(bytes);
    return digest.toString();
  }
}
