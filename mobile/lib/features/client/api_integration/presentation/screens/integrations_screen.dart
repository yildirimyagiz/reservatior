import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class IntegrationsScreen extends ConsumerWidget {
  const IntegrationsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.integrations'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('mobile.auto.connected'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          ..._connected.asMap().entries.map(
            (e) => _card(e.value, colors, e.key, true),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.available'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          ..._available.asMap().entries.map(
            (e) => _card(e.value, colors, e.key, false),
          ),
        ],
      ),
    );
  }

  Widget _card(
    Map<String, dynamic> item,
    ThemeAwareColors c,
    int i,
    bool connected,
  ) => Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: c.border),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (item['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            item['icon'] as IconData,
            color: item['color'] as Color,
            size: 24,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['name'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  fontSize: 15,
                ),
              ),
              Text(
                item['desc'] as String,
                style: TextStyle(color: c.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        if (connected)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('mobile.auto.active'.tr(),
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              textStyle: const TextStyle(fontSize: 12),
            ),
            child: Text('mobile.auto.connect'.tr()),
          ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  static final _connected = [
    {
      'name': 'mobile.leftovers.google_calendar'.tr(),
      'desc': 'mobile.leftovers.sync_events_viewings'.tr(),
      'icon': Icons.calendar_month_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'Stripe',
      'desc': 'mobile.leftovers.payment_processing'.tr(),
      'icon': Icons.payment_rounded,
      'color': Colors.purple,
    },
    {
      'name': 'SendGrid',
      'desc': 'mobile.leftovers.email_delivery'.tr(),
      'icon': Icons.email_rounded,
      'color': Colors.teal,
    },
  ];
  static final _available = [
    {
      'name': 'Twilio',
      'desc': 'mobile.leftovers.sms_voice_calls'.tr(),
      'icon': Icons.sms_rounded,
      'color': Colors.red,
    },
    {
      'name': 'Zapier',
      'desc': 'mobile.leftovers.workflow_automation'.tr(),
      'icon': Icons.bolt_rounded,
      'color': Colors.orange,
    },
    {
      'name': 'Slack',
      'desc': 'mobile.leftovers.team_notifications'.tr(),
      'icon': Icons.chat_bubble_rounded,
      'color': Colors.indigo,
    },
    {
      'name': 'QuickBooks',
      'desc': 'mobile.leftovers.accounting_sync'.tr(),
      'icon': Icons.account_balance_rounded,
      'color': Colors.green,
    },
    {
      'name': 'DocuSign',
      'desc': 'mobile.leftovers.digital_signatures'.tr(),
      'icon': Icons.draw_rounded,
      'color': Colors.amber,
    },
  ];
}
