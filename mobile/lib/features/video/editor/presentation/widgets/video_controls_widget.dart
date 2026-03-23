import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_theme.dart';

class _SkipButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SkipButton({
    required this.icon,
    required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class PropertyInfoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final Color color;

  const PropertyInfoButton({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.color = AppColors.gold,
  });

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyInfoOverlay extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const PropertyInfoOverlay({
    super.key,
    required this.isVisible,
    required this.onClose,
  });

  
  State<PropertyInfoOverlay> createState() => _PropertyInfoOverlayState();
}

class _PropertyInfoOverlayState extends State<PropertyInfoOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      duration: 300.ms,
      vsync: this,
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));

    if (widget.isVisible) {
      _animCtrl.forward();
    }
  }

  
  void didUpdateWidget(PropertyInfoOverlay old) {
    super.didUpdateWidget(old);
    if (widget.isVisible != old.isVisible) {
      if (widget.isVisible) {
        _animCtrl.forward();
      } else {
        _animCtrl.reverse();
      }
    }
  }

  
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox();

    return Positioned(
      bottom: 100,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.home_work_rounded,
                      color: AppColors.gold,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Luxury Penthouse',
                      style: TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: widget.onClose,
                      child: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textSecondaryDark,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    PropertyInfoChip(
                      icon: Icons.square_foot,
                      label: '120m²',
                    ),
                    SizedBox(width: 8),
                    PropertyInfoChip(
                      icon: Icons.king_bed_rounded,
                      label: '3 Beds',
                    ),
                    SizedBox(width: 8),
                    PropertyInfoChip(
                      icon: Icons.bathtub_rounded,
                      label: '2 Baths',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    PropertyInfoChip(
                      icon: Icons.location_on_rounded,
                      label: 'Beverly Hills',
                    ),
                    SizedBox(width: 8),
                    PropertyInfoChip(
                      icon: Icons.attach_money_rounded,
                      label: '\$2.5M',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                  ),
                  child: const Text(
                    'Tap to schedule a viewing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PropertyInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const PropertyInfoChip({
    super.key,
    required this.icon,
    required this.label,
  });

  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.textSecondaryDark,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
