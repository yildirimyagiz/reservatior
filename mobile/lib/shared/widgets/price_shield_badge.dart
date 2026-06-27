import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class PriceShieldBadge extends StatelessWidget {
  final double? savingsPercentage;
  final bool isCompact;

  const PriceShieldBadge({
    super.key,
    this.savingsPercentage,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 12,
        vertical: isCompact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo[700]!,
            Colors.indigo[900]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo[900]!.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.indigo[300]!.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shield_outlined,
            color: Colors.white,
            size: isCompact ? 14 : 16,
          ),
          const SizedBox(width: 6),
          Text(
            savingsPercentage != null
                ? 'Price Shield: Saved ${savingsPercentage!.toStringAsFixed(0)}%'
                : 'mobile.leftovers.price_shield_active'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: isCompact ? 10 : 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
