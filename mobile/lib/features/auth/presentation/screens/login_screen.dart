import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/google_auth_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/services/local_auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'info@reservatior.com');
    _passwordController = TextEditingController(text: 'Parola341');
    _loadSavedCredentials();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final localAuth = ref.read(localAuthProvider);
    final isAvailable = await localAuth.isBiometricAvailable();
    if (mounted) {
      setState(() {
        _canUseBiometrics = isAvailable;
      });
    }
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('saved_email');
      final password = prefs.getString('saved_password');
      final remember = prefs.getBool('remember_me') ?? false;

      if (remember && email != null && password != null) {
        setState(() {
          _emailController.text = email;
          _passwordController.text = password;
          _rememberMe = true;
        });
      }
    } catch (e) {
      // Ignore errors reading shared prefs
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setString('saved_email', _emailController.text.trim());
        await prefs.setString('saved_password', _passwordController.text.trim());
        await prefs.setBool('remember_me', true);
      } else {
        await prefs.remove('saved_email');
        await prefs.remove('saved_password');
        await prefs.setBool('remember_me', false);
      }
    } catch (e) {
      // Ignore errors saving shared prefs
    }
    
    await ref
        .read(authProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text.trim());
  }

  Future<void> _handleBiometricLogin() async {
    final localAuth = ref.read(localAuthProvider);
    final authenticated = await localAuth.authenticate();
    
    if (authenticated && mounted) {
      // For now, if authenticated via biometrics, we trigger standard login with the saved credentials.
      // In a real production scenario, you would swap a secure biometric token for an access token.
      if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        await ref
            .read(authProvider.notifier)
            .login(_emailController.text.trim(), _passwordController.text.trim());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No saved credentials found for biometric login.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/home');
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? 'mobile.auth.authFailed'.tr()),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    final colors = ref.watch(themeAwareColorsProvider);
    final combinedState = ref.watch(combinedAuthProvider);
    final isGoogleAvailable = ref.watch(googleSignInAvailableProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Background Aesthetic Decor
          Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        colors.gold.withOpacity(0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                duration: 5.seconds,
                curve: Curves.easeInOut,
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
              ),

          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.aiAccent.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 40,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Brand Logo/Name
                      Center(
                        child: Column(
                          children: [
                            Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.surface,
                                    border: Border.all(
                                      color: colors.gold.withOpacity(0.2),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.gold.withOpacity(0.1),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.auto_awesome_rounded,
                                    size: 48,
                                    color: colors.gold,
                                  ),
                                )
                                .animate()
                                .fadeIn(duration: 800.ms)
                                .scale(
                                  delay: 200.ms,
                                  begin: const Offset(0.9, 0.9),
                                  end: const Offset(1.0, 1.0),
                                ),
                            SizedBox(height: 24),
                            Text(
                                  'mobile.welcome.brand'.tr(),
                                  style: GoogleFonts.playfairDisplay(
                                    color: colors.gold,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 4,
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .slideY(begin: 0.2, end: 0),
                          ],
                        ),
                      ),

                      SizedBox(height: 60),

                      Text(
                            'mobile.auth.welcomeBack'.tr(),
                            style: GoogleFonts.outfit(
                              color: colors.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 600.ms)
                          .slideX(begin: -0.1, end: 0),
                      Text(
                            'mobile.auth.signInDesc'.tr(),
                            style: GoogleFonts.outfit(
                              color: colors.textSecondary,
                              fontSize: 15,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 700.ms)
                          .slideX(begin: -0.1, end: 0),

                      const SizedBox(height: 40),

                      // Input Fields Group
                      _buildTextField(
                            controller: _emailController,
                            label: 'email'.tr(),
                            hint: 'mobile.auth.emailHint'.tr(),
                            icon: Icons.alternate_email_rounded,
                            colors: colors,
                            validator: (v) => v != null && v.contains('@')
                                ? null
                                : 'mobile.auth.invalidEmail'.tr(),
                          )
                          .animate()
                          .fadeIn(delay: 800.ms)
                          .slideY(begin: 0.1, end: 0),

                      SizedBox(height: 20),

                      _buildTextField(
                            controller: _passwordController,
                            label: 'password'.tr(),
                            hint: '••••••••',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            obscurePassword: _obscurePassword,
                            onVisibilityToggle: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            colors: colors,
                            validator: (v) => v != null && v.length >= 6
                                ? null
                                : 'mobile.auth.passwordShort'.tr(),
                          )
                          .animate()
                          .fadeIn(delay: 900.ms)
                          .slideY(begin: 0.1, end: 0),

                      const SizedBox(height: 12),

                      // Remember Me Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: colors.primary,
                            checkColor: Colors.white,
                          ),
                          Text(
                            'mobile.auth.rememberMe'.tr(),
                            style: GoogleFonts.outfit(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () =>
                                context.push('/auth/forgot-password'),
                            child: Text(
                              'mobile.auth.forgotPassword'.tr(),
                              style: GoogleFonts.outfit(
                                color: colors.primary.withOpacity(0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 1.seconds),

                      const SizedBox(height: 32),

                      // CTA Button
                      SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: combinedState.isLoading
                                  ? null
                                  : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 8,
                                shadowColor: colors.primary.withOpacity(0.3),
                              ),
                              child: combinedState.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'mobile.auth.continue'.tr(),
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 2,
                                      ),
                                    ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 1.1.seconds)
                          .scale(
                            delay: 1.1.seconds,
                            begin: const Offset(0.95, 0.95),
                            end: const Offset(1.0, 1.0),
                          ),

                      if (_canUseBiometrics) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: OutlinedButton.icon(
                            onPressed: _handleBiometricLogin,
                            icon: Icon(Icons.fingerprint, size: 28, color: colors.primary),
                            label: Text(
                              'Login with Face ID / Touch ID',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: colors.primary,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: colors.primary.withOpacity(0.5), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 1.2.seconds),
                      ],

                      const SizedBox(height: 32),

                      // Social Login
                      if (isGoogleAvailable) ...[
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(indent: 20, endIndent: 20),
                            ),
                            Text(
                              'mobile.auth.orContinueWith'.tr(),
                              style: GoogleFonts.outfit(
                                color: colors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            const Expanded(
                              child: Divider(indent: 20, endIndent: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: () => ref
                                .read(googleAuthProvider.notifier)
                                .signInWithGoogle(),
                            icon: const Icon(
                              Icons.g_mobiledata_outlined,
                              size: 28,
                            ),
                            label: Text(
                              'mobile.auth.google'.tr(),
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.textPrimary,
                              side: BorderSide(color: colors.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 1.2.seconds),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: () => ref
                                .read(authProvider.notifier)
                                .loginWithFacebook(),
                            icon: const Icon(
                              Icons.facebook,
                              size: 28,
                              color: Colors.blue,
                            ),
                            label: Text(
                              'Facebook',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.textPrimary,
                              side: BorderSide(color: colors.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 1.3.seconds),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: () => ref
                                .read(authProvider.notifier)
                                .loginWithTwitter(),
                            icon: const Icon(
                              Icons.alternate_email_rounded,
                              size: 28,
                              color: Colors.lightBlue,
                            ),
                            label: Text(
                              'Twitter / X',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.textPrimary,
                              side: BorderSide(color: colors.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 1.4.seconds),
                      ],

                      const SizedBox(height: 40),

                      // Footer
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'mobile.auth.notJoined'.tr(),
                              style: GoogleFonts.outfit(
                                color: colors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.push('/auth/register'),
                              child: Text(
                                'mobile.auth.becomeMember'.tr(),
                                style: GoogleFonts.outfit(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 1.4.seconds),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscurePassword = true,
    VoidCallback? onVisibilityToggle,
    required dynamic colors,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.outfit(
              color: colors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? obscurePassword : false,
          style: GoogleFonts.outfit(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              color: colors.textSecondary.withOpacity(0.4),
            ),
            prefixIcon: Icon(
              icon,
              color: colors.primary.withOpacity(0.7),
              size: 20,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: colors.primary.withOpacity(0.7),
                      size: 20,
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : null,
            filled: true,
            fillColor: colors.surface.withOpacity(0.5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
