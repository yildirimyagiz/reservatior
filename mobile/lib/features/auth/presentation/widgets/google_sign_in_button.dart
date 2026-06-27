import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/google_auth_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class GoogleSignInButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;
  final bool fullWidth;

  const GoogleSignInButton({
    super.key,
    this.onPressed,
    this.text,
    this.isLoading = false,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final googleState = ref.watch(googleAuthProvider);

    final buttonWidth = fullWidth ? double.infinity : null;
    final buttonText = text ?? 'mobile.auto.continue_with_google'.tr();
    final isButtonLoading = isLoading || googleState.isLoading;

    return Container(
      width: buttonWidth,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: (isButtonLoading || onPressed == null) ? null : onPressed,
        icon: isButtonLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : _buildGoogleIcon(colors),
        label: Text(
          isButtonLoading ? 'mobile.auto.signing_in'.tr() : buttonText,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: colors.textPrimary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.background,
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon(ThemeAwareColors colors) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: const Icon(
        Icons.g_mobiledata_rounded,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}

class ModernGoogleSignInButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;
  final bool fullWidth;

  const ModernGoogleSignInButton({
    super.key,
    this.onPressed,
    this.text,
    this.isLoading = false,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final googleState = ref.watch(googleAuthProvider);

    final buttonWidth = fullWidth ? double.infinity : null;
    final buttonText = text ?? 'mobile.auto.continue_with_google'.tr();
    final isButtonLoading = isLoading || googleState.isLoading;

    return Container(
      width: buttonWidth,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Material(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: (isButtonLoading || onPressed == null) ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isButtonLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  _buildGoogleIcon(colors),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isButtonLoading ? 'mobile.auto.signing_in'.tr() : buttonText,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon(ThemeAwareColors colors) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: const Icon(
        Icons.g_mobiledata_rounded,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}

class CompactGoogleSignInButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool showLabel;

  const CompactGoogleSignInButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final googleState = ref.watch(googleAuthProvider);

    final isButtonLoading = isLoading || googleState.isLoading;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.border),
      ),
      child: Material(
        color: colors.background,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: (isButtonLoading || onPressed == null) ? null : onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isButtonLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  const Icon(
                    Icons.g_mobiledata_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                if (showLabel && !isButtonLoading) ...[
                  SizedBox(width: 8),
                  Text('mobile.auto.google'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInCard extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? title;
  final String? subtitle;
  final bool isLoading;

  const GoogleSignInCard({
    super.key,
    this.onPressed,
    this.title,
    this.subtitle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final googleState = ref.watch(googleAuthProvider);

    final isButtonLoading = isLoading || googleState.isLoading;
    final cardTitle = title ?? 'mobile.auto.quick_sign_in'.tr();
    final cardSubtitle = subtitle ?? 'mobile.auto.use_google_account'.tr();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.background.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.g_mobiledata_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTitle,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cardSubtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: (isButtonLoading || onPressed == null)
                  ? null
                  : onPressed,
              icon: isButtonLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.g_mobiledata_rounded, size: 18),
              label: Text(
                isButtonLoading ? 'mobile.auto.signing_in'.tr() : 'mobile.auto.continue_with_google'.tr(),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.background,
                foregroundColor: colors.textPrimary,
                side: BorderSide(color: colors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Google Sign-In Loading Widget
class GoogleSignInLoadingWidget extends ConsumerWidget {
  const GoogleSignInLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
          SizedBox(height: 16),
          Text('mobile.auto.signing_in_with_google'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text('mobile.auto.please_wait_a_moment'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
