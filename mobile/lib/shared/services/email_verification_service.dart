import 'package:dio/dio.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class EmailVerificationService {
  final DioClient _dioClient;
  
  EmailVerificationService(this._dioClient);

  // Send verification email
  Future<Map<String, dynamic>> sendVerificationEmail(String email) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/send-verification',
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
        '${ApiEndpoints.auth}/verify-email-token',
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
        'message': e.response?.data['message'] ?? 'mobile.leftovers.invalid_or_expired_verification_token'.tr(),
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

  // Check email verification status
  Future<Map<String, dynamic>> checkVerificationStatus(String email) async {
    try {
      final response = await _dioClient.get(
        '${ApiEndpoints.auth}/verification-status',
        queryParameters: {
          'email': email,
        },
      );
      
      return {
        'success': true,
        'isVerified': response.data['isVerified'] ?? false,
        'message': response.data['message'] ?? 'mobile.leftovers.status_checked_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_check_verification_status'.tr(),
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

  // Request email change verification
  Future<Map<String, dynamic>> requestEmailChange({
    required String currentEmail,
    required String newEmail,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/request-email-change',
        data: {
          'currentEmail': currentEmail,
          'newEmail': newEmail,
          'password': password,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.email_change_request_sent_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_request_email_change'.tr(),
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

  // Confirm email change
  Future<Map<String, dynamic>> confirmEmailChange({
    required String token,
    required String newEmail,
  }) async {
    try {
      final response = await _dioClient.post(
        '${ApiEndpoints.auth}/confirm-email-change',
        data: {
          'token': token,
          'newEmail': newEmail,
        },
      );
      
      return {
        'success': true,
        'message': response.data['message'] ?? 'mobile.leftovers.email_changed_successfully'.tr(),
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'mobile.leftovers.failed_to_confirm_email_change'.tr(),
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

  // Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Extract domain from email
  String getEmailDomain(String email) {
    try {
      return email.split('@')[1];
    } catch (e) {
      return '';
    }
  }

  // Check if email is from trusted domain
  bool isTrustedDomain(String email) {
    final domain = getEmailDomain(email);
    final trustedDomains = [
      'gmail.com',
      'yahoo.com',
      'outlook.com',
      'hotmail.com',
      'icloud.com',
      'protonmail.com',
      'aol.com',
      'mail.com',
    ];
    
    return trustedDomains.contains(domain.toLowerCase());
  }

  // Generate verification token (for testing)
  String generateVerificationToken() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    String token = '';
    
    for (int i = 0; i < 32; i++) {
      token += chars[(random + i) % chars.length];
    }
    
    return token;
  }

  // Save verification request timestamp
  Future<void> saveVerificationRequestTimestamp(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_verification_request_$email', DateTime.now().toIso8601String());
    } catch (e) {
      // Continue even if saving fails
    }
  }

  // Check if user can request verification (rate limiting)
  Future<bool> canRequestVerification(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRequest = prefs.getString('last_verification_request_$email');
      
      if (lastRequest == null) return true;
      
      final lastRequestTime = DateTime.parse(lastRequest);
      final now = DateTime.now();
      final difference = now.difference(lastRequestTime);
      
      // Allow verification request after 2 minutes
      return difference.inMinutes >= 2;
    } catch (e) {
      return true; // Allow if there's an error
    }
  }

  // Get verification email template
  Map<String, String> getVerificationEmailTemplate({
    required String userName,
    required String verificationLink,
    required String companyName,
  }) {
    return {
      'subject': 'mobile.leftovers.verify_your_email_address'.tr(),
      'htmlBody': '''
        <div style='mobile.leftovers.font_family_arial_sans_serif_max_width_6'.tr()>
          <div style='mobile.leftovers.background_color_f8f9fa_padding_30px_bor'.tr()>
            <h1 style='mobile.leftovers.color_333_text_align_center'.tr()>Welcome to $companyName!</h1>
            <p style='mobile.leftovers.color_666_font_size_16px_line_height_1_5'.tr()>
              Hi $userName,<br><br>
              Thank you for signing up! To complete your registration, please verify your email address by clicking the button below:
            </p>
            <div style='mobile.leftovers.text_align_center_margin_30px_0'.tr()>
              <a href="$verificationLink" style="
                background-color: #007bff;
                color: white;
                padding: 12px 30px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                display: inline-block;
              ">Verify Email</a>
            </div>
            <p style='mobile.leftovers.color_666_font_size_14px_line_height_1_5'.tr()>
              If the button above doesn't work, you can copy and paste this link into your browser:<br>
              <a href="$verificationLink" style='mobile.leftovers.color_007bff'.tr()>$verificationLink</a>
            </p>
            <p style='mobile.leftovers.color_999_font_size_12px_margin_top_30px'.tr()>
              This link will expire in 24 hours. If you didn't request this verification, please ignore this email.
            </p>
          </div>
        </div>
      ''',
      'textBody': '''
        Welcome to $companyName!
        
        Hi $userName,
        
        Thank you for signing up! To complete your registration, please verify your email address by visiting this link:
        $verificationLink
        
        This link will expire in 24 hours. If you didn't request this verification, please ignore this email.
      ''',
    };
  }

  // Get password reset email template
  Map<String, String> getPasswordResetEmailTemplate({
    required String userName,
    required String resetLink,
    required String companyName,
  }) {
    return {
      'subject': 'mobile.leftovers.reset_your_password'.tr(),
      'htmlBody': '''
        <div style='mobile.leftovers.font_family_arial_sans_serif_max_width_6'.tr()>
          <div style='mobile.leftovers.background_color_f8f9fa_padding_30px_bor'.tr()>
            <h1 style='mobile.leftovers.color_333_text_align_center'.tr()>Password Reset Request</h1>
            <p style='mobile.leftovers.color_666_font_size_16px_line_height_1_5'.tr()>
              Hi $userName,<br><br>
              We received a request to reset your password for your $companyName account. Click the button below to reset your password:
            </p>
            <div style='mobile.leftovers.text_align_center_margin_30px_0'.tr()>
              <a href="$resetLink" style="
                background-color: #dc3545;
                color: white;
                padding: 12px 30px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                display: inline-block;
              ">Reset Password</a>
            </div>
            <p style='mobile.leftovers.color_666_font_size_14px_line_height_1_5'.tr()>
              If the button above doesn't work, you can copy and paste this link into your browser:<br>
              <a href="$resetLink" style='mobile.leftovers.color_dc3545'.tr()>$resetLink</a>
            </p>
            <p style='mobile.leftovers.color_999_font_size_12px_margin_top_30px'.tr()>
              This link will expire in 1 hour. If you didn't request this password reset, please ignore this email.
            </p>
          </div>
        </div>
      ''',
      'textBody': '''
        Password Reset Request
        
        Hi $userName,
        
        We received a request to reset your password for your $companyName account. Reset your password by visiting this link:
        $resetLink
        
        This link will expire in 1 hour. If you didn't request this password reset, please ignore this email.
      ''',
    };
  }

  // Track verification email metrics
  Future<void> trackVerificationEmail({
    required String email,
    required String action, // 'sent', 'opened', 'clicked', 'verified'
    Map<String, dynamic>? metadata,
  }) async {
    try {
      await _dioClient.post(
        '${ApiEndpoints.analytics}/email-tracking',
        data: {
          'email': email,
          'action': action,
          'timestamp': DateTime.now().toIso8601String(),
          'metadata': metadata ?? {},
        },
      );
    } catch (e) {
      // Continue even if tracking fails
    }
  }
}
