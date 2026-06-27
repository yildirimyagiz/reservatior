import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).register({
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/home');
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? 'mobile.register.fail'.tr()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Background Gradient Spheres
          Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        colors.gold.withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 4.seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.3, 1.3),
                curve: Curves.easeInOut,
              )
              .then()
              .scale(begin: const Offset(1.3, 1.3), end: const Offset(1, 1)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: colors.gold,
                        size: 22,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: colors.surface.withOpacity(0.5),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),

                    SizedBox(height: 32),

                    Text(
                      'mobile.register.title'.tr(),
                      style: GoogleFonts.playfairDisplay(
                        color: colors.textPrimary,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

                    Text(
                      'mobile.register.subtitle'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textSecondary,
                        fontSize: 16,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),

                    const SizedBox(height: 48),

                    // Fields
                    _buildField(
                      controller: _nameController,
                      label: 'mobile.register.nameLabel'.tr(),
                      hint: 'mobile.register.nameHint'.tr(),
                      icon: Icons.person_outline_rounded,
                      colors: colors,
                      validator: (v) => v != null && v.length >= 3
                          ? null
                          : 'mobile.register.nameError'.tr(),
                    ).animate().fadeIn(delay: 300.ms),

                    SizedBox(height: 24),

                    _buildField(
                      controller: _emailController,
                      label: 'mobile.register.emailLabel'.tr(),
                      hint: 'mobile.register.emailHint'.tr(),
                      icon: Icons.alternate_email_rounded,
                      colors: colors,
                      validator: (v) =>
                          v != null && v.contains('@') ? null : 'mobile.register.emailError'.tr(),
                    ).animate().fadeIn(delay: 400.ms),

                    SizedBox(height: 24),

                    _buildField(
                      controller: _passwordController,
                      label: 'mobile.register.passLabel'.tr(),
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      colors: colors,
                      validator: (v) => v != null && v.length >= 8
                          ? null
                          : 'mobile.register.passError'.tr(),
                    ).animate().fadeIn(delay: 500.ms),

                    const SizedBox(height: 40),

                    // CTA
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: authState.status == AuthStatus.loading
                            ? null
                            : _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.gold,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 10,
                          shadowColor: colors.gold.withOpacity(0.3),
                        ),
                        child: authState.status == AuthStatus.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'mobile.register.button'.tr(),
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ).animate(delay: 600.ms).fadeIn().scale(),

                    const SizedBox(height: 32),

                    // Terms
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.outfit(
                              color: colors.textSecondary,
                              fontSize: 12,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'mobile.register.termsText1'.tr(),
                              ),
                              TextSpan(
                                text: 'mobile.register.termsLink1'.tr(),
                                style: TextStyle(
                                  color: colors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: 'mobile.register.termsText2'.tr()),
                              TextSpan(
                                text: 'mobile.register.termsLink2'.tr(),
                                style: TextStyle(
                                  color: colors.gold,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 1.seconds),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
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
              color: colors.gold.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: GoogleFonts.outfit(color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: colors.gold.withOpacity(0.6),
              size: 20,
            ),
            filled: true,
            fillColor: colors.surface.withOpacity(0.6),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.gold, width: 2),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
