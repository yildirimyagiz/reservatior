import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class SkeletonLoader extends ConsumerWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 20.0,
    this.borderRadius = 12.0,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.textSecondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
     .shimmer(
       duration: 1500.ms,
       color: Colors.white.withOpacity(0.1),
       angle: 0.5, // 45 degree shimmer
     );
  }
}

class PropertyCardSkeleton extends ConsumerWidget {
  const PropertyCardSkeleton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            child: const SkeletonLoader(
              borderRadius: 0,
            ),
          ),
          // Info skeleton
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(height: 18, width: 140, margin: EdgeInsets.only(bottom: 8)),
                const SkeletonLoader(height: 12, width: 100, margin: EdgeInsets.only(bottom: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SkeletonLoader(height: 16, width: 60),
                    Row(
                      children: const [
                        SkeletonLoader(height: 12, width: 24, margin: EdgeInsets.only(right: 4)),
                        SkeletonLoader(height: 12, width: 24),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyListTileSkeleton extends ConsumerWidget {
  const PropertyListTileSkeleton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          const SkeletonLoader(width: 100, height: 100, borderRadius: 16),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(height: 16, width: 120, margin: EdgeInsets.only(bottom: 8)),
                const SkeletonLoader(height: 12, width: 80, margin: EdgeInsets.only(bottom: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SkeletonLoader(height: 16, width: 60),
                    Row(
                      children: const [
                        SkeletonLoader(height: 12, width: 24, margin: EdgeInsets.only(right: 4)),
                        SkeletonLoader(height: 12, width: 24),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
