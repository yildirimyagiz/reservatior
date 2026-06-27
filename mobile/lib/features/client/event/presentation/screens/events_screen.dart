import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.events'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUpcomingSection(colors),
          SizedBox(height: 24),
          Text('mobile.auto.past_events'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._pastEvents.asMap().entries.map(
            (e) => _buildEventCard(e.value, colors, e.key, isPast: true),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSection(ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.upcoming'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ..._upcomingEvents.asMap().entries.map(
          (e) => _buildEventCard(e.value, colors, e.key),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    Map<String, dynamic> event,
    ThemeAwareColors colors,
    int index, {
    bool isPast = false,
  }) {
    return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: (event['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event['day'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: event['color'] as Color,
                      ),
                    ),
                    Text(
                      event['month'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: event['color'] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: isPast
                            ? colors.textSecondary
                            : colors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: colors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event['time'] as String,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: colors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event['location'] as String,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isPast)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event['type'] as String,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 60 * index))
        .slideX(begin: 0.03);
  }

  static final _upcomingEvents = [
    {
      'title': 'mobile.leftovers.property_viewing_45_park_ave'.tr(),
      'day': '15',
      'month': 'APR',
      'time': 'mobile.leftovers.10_00_am'.tr(),
      'location': 'mobile.leftovers.manhattan_ny'.tr(),
      'type': 'Viewing',
      'color': Colors.blue,
    },
    {
      'title': 'mobile.leftovers.client_meeting_smith_family'.tr(),
      'day': '17',
      'month': 'APR',
      'time': 'mobile.leftovers.2_30_pm'.tr(),
      'location': 'mobile.leftovers.office_hq'.tr(),
      'type': 'Meeting',
      'color': Colors.green,
    },
    {
      'title': 'mobile.leftovers.open_house_brooklyn_loft'.tr(),
      'day': '20',
      'month': 'APR',
      'time': 'mobile.leftovers.11_00_am'.tr(),
      'location': 'mobile.leftovers.brooklyn_ny'.tr(),
      'type': 'mobile.leftovers.open_house'.tr(),
      'color': Colors.orange,
    },
  ];
  static final _pastEvents = [
    {
      'title': 'mobile.leftovers.contract_signing_penthouse_suite'.tr(),
      'day': '10',
      'month': 'APR',
      'time': 'mobile.leftovers.3_00_pm'.tr(),
      'location': 'mobile.leftovers.legal_office'.tr(),
      'type': 'Signing',
      'color': Colors.purple,
    },
    {
      'title': 'mobile.leftovers.property_inspection'.tr(),
      'day': '08',
      'month': 'APR',
      'time': 'mobile.leftovers.9_00_am'.tr(),
      'location': 'mobile.leftovers.queens_ny'.tr(),
      'type': 'Inspection',
      'color': Colors.teal,
    },
  ];
}
