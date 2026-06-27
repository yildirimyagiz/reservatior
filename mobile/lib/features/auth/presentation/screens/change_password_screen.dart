import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/services/password_reset_service.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String? token; // For password reset flow
  const ChangePasswordScreen({super.key, this.token});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _passwordChanged = false;
  String? _errorMessage;
  Map<String, dynamic>? _passwordStrength;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    final passwordResetService = PasswordResetService(
      ref.read(dioClientProvider),
    );
    setState(() {
      _passwordStrength = passwordResetService.checkPasswordStrength(password);
    });
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final passwordResetService = PasswordResetService(
        ref.read(dioClientProvider),
      );

      Map<String, dynamic> result;

      if (widget.token != null) {
        // Password reset flow
        result = await passwordResetService.resetPassword(
          token: widget.token!,
          newPassword: _newPasswordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
        );
      } else {
        // Change password flow (authenticated user)
        result = await passwordResetService.changePassword(
          currentPassword: _currentPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
        );
      }

      if (result['success']) {
        setState(() {
          _passwordChanged = true;
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
        _errorMessage = 'mobile.changePwd.unexpError'.tr();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final isResetFlow = widget.token != null;

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
          isResetFlow ? 'mobile.changePwd.resetAppBar'.tr() : 'mobile.changePwd.changeAppBar'.tr(),
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
                      isResetFlow ? Icons.lock_reset : Icons.security,
                      size: 80,
                      color: colors.gold,
                    ),
                    SizedBox(height: 16),
                    Text(
                      isResetFlow
                          ? 'mobile.changePwd.createTitle'.tr()
                          : 'mobile.changePwd.updateTitle'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      isResetFlow
                          ? 'mobile.changePwd.resetDesc'.tr()
                          : 'mobile.changePwd.changeDesc'.tr(),
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

              if (!_passwordChanged) ...[
                // Current Password (only for change password flow)
                if (!isResetFlow) ...[
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: _obscureCurrentPassword,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'mobile.auto.mobile_changepwd_currentpwd'.tr(),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colors.textSecondary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureCurrentPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: colors.textSecondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureCurrentPassword = !_obscureCurrentPassword;
                          });
                        },
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
                        return 'mobile.changePwd.currentReq'.tr();
                      }
                      if (value.trim().length < 6) {
                        return 'mobile.changePwd.pwdShort6'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                ],

                // New Password
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'mobile.auto.mobile_changepwd_newpwd'.tr(),
                    prefixIcon: Icon(Icons.lock, color: colors.textSecondary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: colors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
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
                      return 'mobile.changePwd.newReq'.tr();
                    }
                    if (value.trim().length < 8) {
                      return 'mobile.changePwd.pwdShort8'.tr();
                    }
                    if (_passwordStrength != null &&
                        !_passwordStrength!['isValid']) {
                      return 'mobile.changePwd.pwdWeak'.tr();
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _checkPasswordStrength(value);
                    }
                  },
                ),

                // Password Strength Indicator
                if (_passwordStrength != null &&
                    _newPasswordController.text.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'mobile.changePwd.pwdStrength'.tr(),
                              style: GoogleFonts.outfit(
                                color: colors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _passwordStrength!['strength'],
                              style: GoogleFonts.outfit(
                                color: _passwordStrength!['strengthColor'],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: colors.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _passwordStrength!['score'] / 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _passwordStrength!['strengthColor'],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'mobile.auto.mobile_changepwd_confirmpwd'.tr(),
                    prefixIcon: Icon(
                      Icons.lock_clock,
                      color: colors.textSecondary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: colors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
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
                      return 'mobile.changePwd.confirmReq'.tr();
                    }
                    if (value.trim() != _newPasswordController.text.trim()) {
                      return 'mobile.changePwd.pwdMismatch'.tr();
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

                // Change Password Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _changePassword,
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
                            isResetFlow ? 'mobile.changePwd.resetAppBar'.tr() : 'mobile.changePwd.changeAppBar'.tr(),
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
                        isResetFlow
                            ? 'mobile.changePwd.resetSuccess'.tr()
                            : 'mobile.changePwd.changeSuccess'.tr(),
                        style: GoogleFonts.outfit(
                          color: colors.success,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        isResetFlow
                            ? 'mobile.changePwd.resetSuccessDesc'.tr()
                            : 'mobile.changePwd.changeSuccessDesc'.tr(),
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

                // Login Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isResetFlow) {
                        context.go('/login');
                      } else {
                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.gold,
                      foregroundColor: colors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isResetFlow ? 'mobile.changePwd.goToLogin'.tr() : 'mobile.changePwd.back'.tr(),
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
          ),
        ),
      ),
    );
  }
}
