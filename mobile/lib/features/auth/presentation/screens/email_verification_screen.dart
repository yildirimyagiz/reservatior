import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/services/email_verification_service.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String? token; // Optional token for direct verification

  const EmailVerificationScreen({super.key, required this.email, this.token});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  bool _isLoading = false;
  bool _isVerified = false;
  bool _emailSent = false;
  String? _errorMessage;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      _verifyEmailWithToken(widget.token!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _verifyEmailWithToken(String token) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final emailService = EmailVerificationService(
        ref.read(dioClientProvider),
      );
      final result = await emailService.verifyEmail(token);

      if (result['success']) {
        setState(() {
          _isVerified = true;
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
        _errorMessage = 'mobile.emailVerify.unexpError'.tr();
        _isLoading = false;
      });
    }
  }

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final emailService = EmailVerificationService(
        ref.read(dioClientProvider),
      );

      // Check if user can request verification (rate limiting)
      final canRequest = await emailService.canRequestVerification(
        widget.email,
      );
      if (!canRequest) {
        setState(() {
          _errorMessage = 'mobile.emailVerify.waitRate'.tr();
          _isLoading = false;
        });
        return;
      }

      final result = await emailService.sendVerificationEmail(widget.email);

      if (result['success']) {
        // Save request timestamp
        await emailService.saveVerificationRequestTimestamp(widget.email);

        setState(() {
          _emailSent = true;
          _isLoading = false;
          _resendCooldown = 120; // 2 minutes cooldown
        });

        // Start countdown timer
        _startCooldownTimer();
      } else {
        setState(() {
          _errorMessage = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'mobile.emailVerify.unexpError'.tr();
        _isLoading = false;
      });
    }
  }

  void _startCooldownTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
        return true;
      }
      return false;
    });
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
        leading: widget.token == null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text(
          'mobile.emailVerify.appBar'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                children: [
                  Icon(
                    _isVerified
                        ? Icons.verified_user_outlined
                        : Icons.email_outlined,
                    size: 80,
                    color: _isVerified ? colors.success : colors.gold,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _isVerified ? 'mobile.emailVerify.verifiedTitle'.tr() : 'mobile.emailVerify.verifyTitle'.tr(),
                    style: GoogleFonts.outfit(
                      color: colors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    _isVerified
                        ? 'mobile.emailVerify.verifiedDesc'.tr()
                        : 'mobile.emailVerify.verifyDesc'.tr(namedArgs: {'email': widget.email}),
                    style: GoogleFonts.outfit(
                      color: colors.textSecondary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            if (_isLoading)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.token != null ? 'mobile.emailVerify.verifying'.tr() : 'mobile.emailVerify.sending'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            else if (_isVerified) ...[
              // Success State
              Container(
                padding: const EdgeInsets.all(20),
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
                      'mobile.emailVerify.completeTitle'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.success,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'mobile.emailVerify.completeDesc'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => context.go('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.gold,
                    foregroundColor: colors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'mobile.emailVerify.continueBtn'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Verification State
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: colors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: colors.error, size: 20),
                      const SizedBox(width: 8),
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

              if (_emailSent) ...[
                // Email Sent State
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.info.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.mark_email_read_outlined,
                        color: colors.info,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'mobile.emailVerify.sentTitle'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.info,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'mobile.emailVerify.sentDesc'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.textSecondary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Resend Button
                SizedBox(
                  height: 56,
                  child: OutlinedButton(
                    onPressed: _resendCooldown > 0
                        ? null
                        : _sendVerificationEmail,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.gold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _resendCooldown > 0
                          ? 'mobile.emailVerify.resendIn'.tr(namedArgs: {'seconds': _resendCooldown.toString()})
                          : 'mobile.emailVerify.resendBtn'.tr(),
                      style: GoogleFonts.outfit(
                        color: _resendCooldown > 0
                            ? colors.textSecondary
                            : colors.gold,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                // Initial State
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.border),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.info_outline, color: colors.info, size: 48),
                      SizedBox(height: 16),
                      Text(
                        'mobile.emailVerify.checkTitle'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'mobile.emailVerify.checkDesc'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.textSecondary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Send Verification Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _sendVerificationEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.gold,
                      foregroundColor: colors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'mobile.emailVerify.sendBtn'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ],

            SizedBox(height: 32),

            // Help Text
            Text(
              'mobile.emailVerify.helpText'.tr(),
              style: GoogleFonts.outfit(
                color: colors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
