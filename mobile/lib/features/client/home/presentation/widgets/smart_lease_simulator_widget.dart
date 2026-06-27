import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SmartLeaseSimulatorWidget extends StatelessWidget {
  const SmartLeaseSimulatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF064E3B), const Color(0xFF065F46).withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: const Color(0xFF10B981).withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.calculate_rounded, color: Color(0xFF10B981), size: 24),
              ),
              SizedBox(width: 12),
              Text('mobile.auto.commission_simulator'.tr(), style: GoogleFonts.outfit(color: const Color(0xFF6EE7B7), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            ],
          ),
          SizedBox(height: 20),
          Text('mobile.auto.traditional_vs_reservatior'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _col('Traditional', '₺20,000', 'mobile.leftovers.one_time'.tr(), Colors.redAccent.withOpacity(0.8), Icons.trending_down_rounded)),
              const SizedBox(width: 16),
              Expanded(child: _col('Reservatior', '₺86,400+', 'mobile.leftovers.36_months_mrr'.tr(), const Color(0xFF10B981), Icons.trending_up_rounded)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Color(0xFF6EE7B7), size: 16),
                SizedBox(width: 10),
                Expanded(
                  child: Text('mobile.auto.20_000_rent_2_tenant_2_landlord_36_months_86_400_cumulative_revenue_per_unit'.tr(),
                    style: GoogleFonts.outfit(color: const Color(0xFF6EE7B7), fontSize: 11, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _col(String label, String value, String sub, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(label, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.outfit(color: color, fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 2),
          Text(sub, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }
}
