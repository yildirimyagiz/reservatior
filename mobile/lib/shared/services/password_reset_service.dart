import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class PasswordResetService {
  final DioClient _dioClient;
  
  PasswordResetService(this._dioClient);

  // Send password reset email
  Future<Map<String, dynamic>> sendPasswordResetEmail(String email) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/password-reset',
        data: {
          'email': email,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.password_reset_email_sent_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_send_password_reset_email'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Verify password reset token
  Future<Map<String, dynamic>> verifyResetToken(String token) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/verify-reset-token',
        data: {
          'token': token,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.token_verified_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.invalid_or_expired_token'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Reset password with token
  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/reset-password',
        data: {
          'token': token,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.password_reset_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_reset_password'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Change password (authenticated user)
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.password_changed_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_change_password'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Check if email exists
  Future<Map<String, dynamic>> checkEmailExists(String email) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/check-email',
        data: {
          'email': email,
        },
      );
      
      return {
        'success': true,
        'exists': response.data['exists'] ?? false,
        'message': response.data['message'] ?? 'mobile.leftovers.email_check_completed'.tr(),
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_check_email'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Request email verification
  Future<Map<String, dynamic>> requestEmailVerification(String email) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/request-verification',
        data: {
          'email': email,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.verification_email_sent_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_send_verification_email'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Verify email with token
  Future<Map<String, dynamic>> verifyEmail(String token) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/verify-email',
        data: {
          'token': token,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.email_verified_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_verify_email'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Resend verification email
  Future<Map<String, dynamic>> resendVerificationEmail(String email) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/resend-verification',
        data: {
          'email': email,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.verification_email_resent_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_resend_verification_email'.tr(),
        'error': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'mobile.leftovers.an_unexpected_error_occurred'.tr(),
        'error': e.toString(),
      };
    }
  }

  // Check password strength
  Map<String, dynamic> checkPasswordStrength(String password) {
    final List<String> feedback = [];
    int score = 0;

    // Length check
    if (password.length >= 8) {
      score += 1;
    } else {
      feedback.add('mobile.leftovers.password_should_be_at_least_8_characters'.tr());
    }

    // Uppercase check
    if (password.contains(RegExp(r'[A-Z]'))) {
      score += 1;
    } else {
      feedback.add('mobile.leftovers.password_should_contain_at_least_one_upp'.tr());
    }

    // Lowercase check
    if (password.contains(RegExp(r'[a-z]'))) {
      score += 1;
    } else {
      feedback.add('mobile.leftovers.password_should_contain_at_least_one_low'.tr());
    }

    // Number check
    if (password.contains(RegExp(r'[0-9]'))) {
      score += 1;
    } else {
      feedback.add('mobile.leftovers.password_should_contain_at_least_one_num'.tr());
    }

    // Special character check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      score += 1;
    } else {
      feedback.add('mobile.leftovers.password_should_contain_at_least_one_spe'.tr());
    }

    String strength;
    Color strengthColor;

    switch (score) {
      case 0:
      case 1:
        strength = 'mobile.leftovers.very_weak'.tr();
        strengthColor = const Color(0xFFFF4757);
        break;
      case 2:
        strength = 'Weak';
        strengthColor = const Color(0xFFFFA502);
        break;
      case 3:
        strength = 'Fair';
        strengthColor = const Color(0xFFFFD93D);
        break;
      case 4:
        strength = 'Good';
        strengthColor = const Color(0xFF6BCF7F);
        break;
      case 5:
        strength = 'Strong';
        strengthColor = const Color(0xFF2ECC71);
        break;
      default:
        strength = 'Unknown';
        strengthColor = const Color(0xFF95A5A6);
    }

    return {
      'score': score,
      'strength': strength,
      'strengthColor': strengthColor,
      'feedback': feedback,
      'isValid': score >= 3,
    };
  }

  // Validate password format
  bool isValidPasswordFormat(String password) {
    // At least 8 characters, one uppercase, one lowercase, one number, one special character
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

  // Generate secure password
  String generateSecurePassword({
    int length = 12,
    bool includeUppercase = true,
    bool includeLowercase = true,
    bool includeNumbers = true,
    bool includeSpecialChars = true,
  }) {
    final String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';

    if (chars.isEmpty) return '';

    String password = '';
    final random = DateTime.now().millisecond;
    for (int i = 0; i < length; i++) {
      password += chars[(random + i) % chars.length];
    }

    return password;
  }

  // Save reset request timestamp
  Future<void> saveResetRequestTimestamp(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_reset_request_$email', DateTime.now().toIso8601String());
    } catch (e) {
      // Continue even if saving fails
    }
  }

  // Check if user can request reset (rate limiting)
  Future<bool> canRequestReset(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRequest = prefs.getString('last_reset_request_$email');
      
      if (lastRequest == null) return true;
      
      final lastRequestTime = DateTime.parse(lastRequest);
      final now = DateTime.now();
      final difference = now.difference(lastRequestTime);
      
      // Allow reset request after 5 minutes
      return difference.inMinutes >= 5;
    } catch (e) {
      return true; // Allow if there's an error
    }
  }
}
