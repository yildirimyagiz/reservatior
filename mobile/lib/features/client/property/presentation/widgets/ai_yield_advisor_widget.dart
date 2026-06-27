import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import removed - AppColors not available
import 'dart:math';

/// A dynamic widget that calculates the 'mobile.leftovers.vacancy_cost'.tr() vs 'mobile.leftovers.discount_benefit'.tr()
/// and displays a highly interactive AI recommendation to the landlord.
class AiYieldAdvisorWidget extends StatelessWidget {
  final double requestedRent;
  final double marketRent;
  final String regionCode;

  const AiYieldAdvisorWidget({
    super.key,
    required this.requestedRent,
    required this.marketRent,
    this.regionCode = 'TR',
  });

  // Simplified Dart port of the ai-yield-optimization.ts algorithm
  Map<String, dynamic> _calculateYield() {
    // Basic rules simulating the backend
    double maxPremium = 0.15; // 15% above market triggers warning
    int estimatedVacancyDays = 60;
    double recommendedDiscount = 0.10; // 10% discount

    if (regionCode == 'USA') {
      maxPremium = 0.10;
      estimatedVacancyDays = 30;
      recommendedDiscount = 0.05;
    }

    // Is the price too high compared to market?
    if (requestedRent <= marketRent * (1 + maxPremium)) {
      return {'isOptimal': true};
    }

    double dailyRent = requestedRent / 30;
    double vacancyLoss = dailyRent * estimatedVacancyDays;
    
    double discountedRent = requestedRent * (1 - recommendedDiscount);
    double annualLossDueToDiscount = (requestedRent - discountedRent) * 12;

    bool isDiscountBetter = vacancyLoss > annualLossDueToDiscount;
    double netAdvantage = (vacancyLoss - annualLossDueToDiscount).abs();

    return {
      'isOptimal': false,
      'vacancyLoss': vacancyLoss,
      'discountedRent': discountedRent,
      'isDiscountBetter': isDiscountBetter,
      'netAdvantage': netAdvantage,
      'estimatedVacancyDays': estimatedVacancyDays,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (requestedRent == 0 || marketRent == 0) return const SizedBox.shrink();

    final calculation = _calculateYield();
    if (calculation['isOptimal'] == true) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green[400], size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text('mobile.auto.ai_analysis_your_pricing_is_optimal_for_quick_rental'.tr(),
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    // High Price Warning UI
    final vacancyLoss = calculation['vacancyLoss'] as double;
    final discountedRent = calculation['discountedRent'] as double;
    final netAdvantage = calculation['netAdvantage'] as double;
    final days = calculation['estimatedVacancyDays'] as int;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.orange[400], size: 24),
              SizedBox(width: 12),
              Text('mobile.auto.ai_yield_optimizer'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Warning: At this price, your property may sit vacant for $days days.',
            style: TextStyle(color: Colors.red[300], fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('mobile.auto.estimated_vacancy_loss'.tr(), style: TextStyle(color: Colors.white54, fontSize: 10)),
                    Text('\$${vacancyLoss.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('mobile.auto.recommended_rent'.tr(), style: TextStyle(color: Colors.orangeAccent, fontSize: 10)),
                    Text('\$${discountedRent.toStringAsFixed(0)}', style: const TextStyle(color: Colors.orangeAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Lowering your rent yields \$${netAdvantage.toStringAsFixed(0)} more annually compared to waiting.',
            style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Action to update the rent field automatically
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('mobile.auto.apply_ai_suggested_price'.tr(), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
