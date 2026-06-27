import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';

// ─── Gold Gradient Button ───────────────────────────────────────────────────────
class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const GoldButton({
    super.key, required this.label,
    this.onPressed, this.icon,
    this.isLoading = false, this.width,
  });

  
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.goldDark, AppColors.gold, AppColors.goldLight],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.3),
              blurRadius: 20, offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
          child: isLoading
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.darkBg, strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: AppColors.darkBg),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.darkBg, fontWeight: FontWeight.w700,
                      fontSize: 14, letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

// ─── Premium Card ────────────────────────────────────────────────────────────────
class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hasBorder;
  final Color? borderColor;

  const PremiumCard({
    super.key, required this.child, this.padding,
    this.onTap, this.hasBorder = true, this.borderColor,
  });

  
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: hasBorder ? Border.all(
              color: borderColor ?? (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Gold Badge ──────────────────────────────────────────────────────────────────
class PlanBadge extends StatelessWidget {
  final String label;
  const PlanBadge({super.key, required this.label});

  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldDark, AppColors.goldLight],
        ),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: AppColors.darkBg, fontSize: 10,
          fontWeight: FontWeight.w800, letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─── Shimmer Loading Card ────────────────────────────────────────────────────────
class ShimmerCard extends StatelessWidget {
  final double height;
  final double? width;
  const ShimmerCard({super.key, this.height = 120, this.width});

  
  Widget build(BuildContext context) {
    return Container(
      height: height, width: width,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(
      duration: 1500.ms,
      color: AppColors.darkMuted.withOpacity(0.5),
    );
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key, required this.title,
    this.actionLabel, this.onAction,
  });

  
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(color: AppColors.gold, fontSize: 13),
            ),
          ),
      ],
    );
  }
}

// ─── AI Step Progress Row ────────────────────────────────────────────────────────
class AiStepRow extends StatelessWidget {
  final String label;
  final AiStepState state;
  final double? progress;

  const AiStepRow({
    super.key, required this.label,
    required this.state, this.progress,
  });

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 24, height: 24,
            child: switch (state) {
              AiStepState.completed => const Icon(
                  Icons.check_circle_rounded, color: AppColors.success, size: 24),
              AiStepState.running => SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(
                    value: progress, strokeWidth: 2,
                    color: AppColors.gold,
                    backgroundColor: AppColors.darkBorder,
                  ),
                ),
              AiStepState.failed => const Icon(
                  Icons.cancel_rounded, color: AppColors.error, size: 24),
              AiStepState.pending => Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkMuted, width: 2),
                  ),
                ),
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: state == AiStepState.running
                  ? AppColors.textPrimaryDark
                  : state == AiStepState.completed
                    ? AppColors.success
                    : AppColors.textSecondaryDark,
                fontSize: 14,
                fontWeight: state == AiStepState.running
                  ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum AiStepState { pending, running, completed, failed }

// ─── Language Selector Chip ──────────────────────────────────────────────────────
class LanguageChip extends StatelessWidget {
  final String flag;
  final String code;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageChip({
    super.key, required this.flag, required this.code,
    required this.name, required this.isSelected, required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
            ? AppColors.gold.withOpacity(0.15)
            : AppColors.darkCard,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected ? AppColors.gold : AppColors.darkBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              code.toUpperCase(),
              style: TextStyle(
                color: isSelected ? AppColors.gold : AppColors.textSecondaryDark,
                fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Metric Card ─────────────────────────────────────────────────────────────────
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String? change;
  final bool isPositive;
  final IconData icon;
  final Color? iconColor;

  const MetricCard({
    super.key, required this.label, required this.value,
    this.change, this.isPositive = true,
    required this.icon, this.iconColor,
  });

  
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.gold).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: 18, color: iconColor ?? AppColors.gold),
              ),
              if (change != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (isPositive ? AppColors.success : AppColors.error).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    change!,
                    style: TextStyle(
                      color: isPositive ? AppColors.success : AppColors.error,
                      fontSize: 11, fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondaryDark, fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
