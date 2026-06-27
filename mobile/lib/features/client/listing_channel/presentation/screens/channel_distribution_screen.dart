import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class ChannelDistributionScreen extends ConsumerWidget {
  const ChannelDistributionScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.channels'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: _stat('Active', '5', Colors.green, colors)),
              const SizedBox(width: 10),
              Expanded(child: _stat('Synced', '142', Colors.blue, colors)),
              const SizedBox(width: 10),
              Expanded(child: _stat('Pending', '8', Colors.orange, colors)),
            ],
          ).animate().fadeIn(),
          SizedBox(height: 24),
          Text('mobile.auto.distribution_channels'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._channels.asMap().entries.map(
            (e) => _channelCard(e.value, colors, e.key),
          ),
        ],
      ),
    );
  }

  Widget _stat(String l, String v, Color c, ThemeAwareColors cl) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cl.card,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cl.border),
    ),
    child: Column(
      children: [
        Text(
          v,
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: c,
          ),
        ),
        Text(l, style: TextStyle(color: cl.textSecondary, fontSize: 11)),
      ],
    ),
  );

  Widget _channelCard(
    Map<String, dynamic> ch,
    ThemeAwareColors c,
    int i,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: c.border),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (ch['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            ch['icon'] as IconData,
            color: ch['color'] as Color,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ch['name'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${ch['listings']} listings synced',
                style: TextStyle(color: c.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (ch['active'] as bool ? Colors.green : Colors.grey)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                ch['active'] as bool ? 'Active' : 'Paused',
                style: TextStyle(
                  color: ch['active'] as bool ? Colors.green : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ch['lastSync'] as String,
              style: TextStyle(color: c.textSecondary, fontSize: 10),
            ),
          ],
        ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  static final _channels = [
    {
      'name': 'Zillow',
      'listings': 45,
      'icon': Icons.home_rounded,
      'color': Colors.blue,
      'active': true,
      'lastSync': 'mobile.leftovers.2m_ago'.tr(),
    },
    {
      'name': 'Airbnb',
      'listings': 28,
      'icon': Icons.hotel_rounded,
      'color': Colors.red,
      'active': true,
      'lastSync': 'mobile.leftovers.5m_ago'.tr(),
    },
    {
      'name': 'mobile.leftovers.booking_com'.tr(),
      'listings': 32,
      'icon': Icons.travel_explore_rounded,
      'color': Colors.indigo,
      'active': true,
      'lastSync': 'mobile.leftovers.10m_ago'.tr(),
    },
    {
      'name': 'mobile.leftovers.realtor_com'.tr(),
      'listings': 22,
      'icon': Icons.apartment_rounded,
      'color': Colors.green,
      'active': true,
      'lastSync': 'mobile.leftovers.15m_ago'.tr(),
    },
    {
      'name': 'Vrbo',
      'listings': 15,
      'icon': Icons.villa_rounded,
      'color': Colors.orange,
      'active': true,
      'lastSync': 'mobile.leftovers.20m_ago'.tr(),
    },
    {
      'name': 'MLS',
      'listings': 0,
      'icon': Icons.list_alt_rounded,
      'color': Colors.purple,
      'active': false,
      'lastSync': 'mobile.leftovers.not_synced'.tr(),
    },
  ];
}
