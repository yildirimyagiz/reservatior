import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/services/password_reset_service.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final passwordResetService = PasswordResetService(
        ref.read(dioClientProvider),
      );

      // Check if user can request reset (rate limiting)
      final canRequest = await passwordResetService.canRequestReset(
        _emailController.text.trim(),
      );
      if (!canRequest) {
        setState(() {
          _errorMessage = 'mobile.forgot.waitRate'.tr();
          _isLoading = false;
        });
        return;
      }

      // Send reset email
      final result = await passwordResetService.sendPasswordResetEmail(
        _emailController.text.trim(),
      );

      if (result['success']) {
        // Save request timestamp
        await passwordResetService.saveResetRequestTimestamp(
          _emailController.text.trim(),
        );

        setState(() {
          _emailSent = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'mobile.forgot.unexpError'.tr();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'mobile.forgot.appBar'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),

              // Illustration
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_reset_outlined,
                      size: 80,
                      color: colors.gold,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'mobile.forgot.title'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'mobile.forgot.desc'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textSecondary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              if (!_emailSent) ...[
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'mobile.auto.mobile_forgot_emaillabel'.tr(),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: colors.textSecondary,
                    ),
                    filled: true,
                    fillColor: colors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.gold, width: 2),
                    ),
                    labelStyle: TextStyle(color: colors.textSecondary),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'mobile.forgot.emailReq'.tr();
                    }
                    if (!value.contains('@')) {
                      return 'mobile.forgot.emailInv'.tr();
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colors.error.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.error,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: GoogleFonts.outfit(
                              color: colors.error,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 24),

                // Send Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendResetEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.gold,
                      foregroundColor: colors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : Text(
                            'mobile.forgot.sendLink'.tr(),
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ] else ...[
                // Success Message
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.success.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: colors.success,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'mobile.forgot.sentTitle'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.success,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'mobile.forgot.sentDesc'.tr(namedArgs: {'email': _emailController.text}),
                        style: GoogleFonts.outfit(
                          color: colors.textSecondary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Back to Login Button
                SizedBox(
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.gold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'mobile.forgot.backToLogin'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.gold,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],

              SizedBox(height: 32),

              // Additional Help
              Text(
                'mobile.forgot.spamHelp'.tr(),
                style: GoogleFonts.outfit(
                  color: colors.textSecondary,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
