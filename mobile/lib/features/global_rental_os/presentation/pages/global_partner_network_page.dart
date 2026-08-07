import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Global Partner Network — shows 15 partner roles across 5 tiers
/// with country-adjusted commission rates.
class GlobalPartnerNetworkPage extends StatelessWidget {
  const GlobalPartnerNetworkPage({super.key});

  static const _tiers = [
    {'name': 'REFERRAL', 'base': 5, 'color': Color(0xFF6B7280)},
    {'name': 'SILVER', 'base': 8, 'color': Color(0xFF9CA3AF)},
    {'name': 'GOLD', 'base': 10, 'color': Color(0xFFF59E0B)},
    {'name': 'PLATINUM', 'base': 12, 'color': Color(0xFF8B5CF6)},
    {'name': 'STRATEGIC', 'base': 15, 'color': Color(0xFF10B981)},
  ];

  static const _roles = [
    {'role': 'Real Estate Agent', 'icon': Icons.real_estate_agent_outlined, 'color': Color(0xFF3B82F6)},
    {'role': 'Property Manager', 'icon': Icons.apartment_outlined, 'color': Color(0xFF10B981)},
    {'role': 'Relocation Company', 'icon': Icons.flight_outlined, 'color': Color(0xFF8B5CF6)},
    {'role': 'Corporate HR Partner', 'icon': Icons.business_center_outlined, 'color': Color(0xFFF59E0B)},
    {'role': 'Investment Advisor', 'icon': Icons.trending_up_outlined, 'color': Color(0xFFEF4444)},
    {'role': 'Building Manager', 'icon': Icons.domain_outlined, 'color': Color(0xFF06B6D4)},
    {'role': 'Travel Agency', 'icon': Icons.luggage_outlined, 'color': Color(0xFFEC4899)},
    {'role': 'Local Operator', 'icon': Icons.handyman_outlined, 'color': Color(0xFF78716C)},
    {'role': 'Interior Designer', 'icon': Icons.design_services_outlined, 'color': Color(0xFFA855F7)},
    {'role': 'Legal Advisor', 'icon': Icons.gavel_outlined, 'color': Color(0xFF64748B)},
    {'role': '2% Guarantee Underwriter', 'icon': Icons.verified_user_outlined, 'color': Color(0xFF14B8A6)},
    {'role': 'Cleaning Service', 'icon': Icons.cleaning_services_outlined, 'color': Color(0xFF84CC16)},
    {'role': 'Concierge Provider', 'icon': Icons.room_service_outlined, 'color': Color(0xFFE11D48)},
    {'role': 'Tech Integration', 'icon': Icons.integration_instructions_outlined, 'color': Color(0xFF2563EB)},
    {'role': 'Channel Partner', 'icon': Icons.share_outlined, 'color': Color(0xFFD97706)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B27),
        title: Text(
          'Global Partner Network',
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tier summary
          Text('COMMISSION TIERS', style: GoogleFonts.outfit(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          const SizedBox(height: 10),
          Row(
            children: _tiers.map((t) {
              final color = t['color'] as Color;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Text('${t['base']}%', style: GoogleFonts.outfit(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 2),
                      Text(t['name'] as String, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 7, fontWeight: FontWeight.w700, letterSpacing: 1)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield, color: Color(0xFF10B981), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'All partner deals are protected by Reservatior\'s 2% Rent Guarantee Underwriting Fund & zero-deposit escrow settlement.',
                    style: GoogleFonts.outfit(color: const Color(0xFFA7F3D0), fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Roles
          Text('PARTNER ROLES (${_roles.length})', style: GoogleFonts.outfit(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          const SizedBox(height: 10),
          ...List.generate(_roles.length, (i) {
            final role = _roles[i];
            final color = role['color'] as Color;
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2433),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.15)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(role['icon'] as IconData, size: 18, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(role['role'] as String, style: GoogleFonts.outfit(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                        Text('5-15% commission · Multi-tier eligible', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: color.withOpacity(0.2)),
                    ),
                    child: Text('GLOBAL', style: GoogleFonts.outfit(color: color, fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1)),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
