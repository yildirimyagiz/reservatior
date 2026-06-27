import 'package:go_router/go_router.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/dashboard');
      } else if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Error logging in')),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Background Aesthetic
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [AppColors.gold.withOpacity(0.1), AppColors.darkBg],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo / Icon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.gold.withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.home_work_outlined,
                          size: 60,
                          color: AppColors.gold,
                        ),
                      ).animate().scale(
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1.0, 1.0),
                      ),

                      SizedBox(height: 32),

                      Text('mobile.auto.reel_estate'.tr(),
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      Text('mobile.auto.elevated_living_ai_simplified'.tr(),
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: AppColors.gold.withOpacity(0.7),
                          letterSpacing: 1.5,
                        ),
                      ).animate().fadeIn(delay: 400.ms),

                      const SizedBox(height: 64),

                      // Email Field
                      _buildTextField(
                            controller: _emailController,
                            label: 'mobile.auto.email_address'.tr(),
                            icon: Icons.alternate_email,
                            validator: (v) => v?.contains('@') == true
                                ? null
                                : 'mobile.auto.enter_valid_email'.tr(),
                          )
                          .animate(delay: 600.ms)
                          .fadeIn()
                          .slideX(begin: -0.1, end: 0),

                      const SizedBox(height: 16),

                      // Password Field
                      _buildTextField(
                            controller: _passwordController,
                            label: 'mobile.auto.password'.tr(),
                            icon: Icons.lock_outline,
                            obscure: _obscurePassword,
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white30,
                              ),
                              onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),
                            validator: (v) => (v?.length ?? 0) >= 6
                                ? null
                                : 'mobile.auto.min_6_chars'.tr(),
                          )
                          .animate(delay: 700.ms)
                          .fadeIn()
                          .slideX(begin: 0.1, end: 0),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('mobile.auto.forgot_password'.tr(),
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Sign In Button
                      SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: ref.watch(authProvider).status == AuthStatus.loading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.gold,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: ref.watch(authProvider).status == AuthStatus.loading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text('mobile.auto.sign_in'.tr(),
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 2,
                                      ),
                                    ),
                            ),
                          )
                          .animate(delay: 800.ms)
                          .fadeIn()
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 48),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('mobile.auto.new_to_the_estate'.tr(),
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('mobile.auto.create_account'.tr(),
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ).animate(delay: 1000.ms).fadeIn(),
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
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: AppColors.gold, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.darkSurface.withOpacity(0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.gold),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authProvider.notifier).login(_emailController.text, _passwordController.text);
  }
}
