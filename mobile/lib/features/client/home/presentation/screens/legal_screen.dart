import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class LegalScreen extends ConsumerWidget {
  final String title;
  final String type; // 'privacy', 'terms', 'trust'
  const LegalScreen({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final sections = type == 'privacy'
        ? _privacySections
        : type == 'terms'
        ? _termsSections
        : _trustSections;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('mobile.auto.last_updated_april_1_2026'.tr(),
            style: TextStyle(color: colors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ...sections.map(
            (s) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s['title'] as String,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s['body'] as String,
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static final _privacySections = [
    {
      'title': 'mobile.leftovers.1_information_we_collect'.tr(),
      'body':
          'mobile.leftovers.we_collect_information_you_provide_direc'.tr(),
    },
    {
      'title': 'mobile.leftovers.2_how_we_use_your_information'.tr(),
      'body':
          'mobile.leftovers.your_information_is_used_to_provide_main'.tr(),
    },
    {
      'title': 'mobile.leftovers.3_data_sharing'.tr(),
      'body':
          'mobile.leftovers.we_do_not_sell_your_personal_data_we_may'.tr(),
    },
    {
      'title': 'mobile.leftovers.4_data_retention'.tr(),
      'body':
          'mobile.leftovers.we_retain_your_data_for_as_long_as_your'.tr(),
    },
    {
      'title': 'mobile.leftovers.5_your_rights'.tr(),
      'body':
          'mobile.leftovers.you_have_the_right_to_access_correct_del'.tr(),
    },
  ];
  static final _termsSections = [
    {
      'title': 'mobile.leftovers.1_acceptance_of_terms'.tr(),
      'body':
          'mobile.leftovers.by_accessing_or_using_reservatior_you_ag'.tr(),
    },
    {
      'title': 'mobile.leftovers.2_account_registration'.tr(),
      'body':
          'mobile.leftovers.you_must_provide_accurate_and_complete_i'.tr(),
    },
    {
      'title': 'mobile.leftovers.3_property_listings'.tr(),
      'body':
          'mobile.leftovers.all_property_listings_must_be_accurate_a'.tr(),
    },
    {
      'title': 'mobile.leftovers.4_payment_terms'.tr(),
      'body':
          'mobile.leftovers.subscription_fees_are_billed_in_advance'.tr(),
    },
    {
      'title': 'mobile.leftovers.5_limitation_of_liability'.tr(),
      'body':
          'mobile.leftovers.reservatior_is_not_liable_for_decisions'.tr(),
    },
  ];
  static final _trustSections = [
    {
      'title': 'mobile.leftovers.data_encryption'.tr(),
      'body':
          'mobile.leftovers.all_data_is_encrypted_at_rest_aes_256_an'.tr(),
    },
    {
      'title': 'mobile.leftovers.soc_2_compliance'.tr(),
      'body':
          'mobile.leftovers.reservatior_maintains_soc_2_type_ii_comp'.tr(),
    },
    {
      'title': 'mobile.leftovers.gdpr_ccpa_ready'.tr(),
      'body':
          'mobile.leftovers.we_are_fully_compliant_with_gdpr_and_ccp'.tr(),
    },
    {
      'title': 'mobile.leftovers.infrastructure_security'.tr(),
      'body':
          'mobile.leftovers.our_infrastructure_is_hosted_on_enterpri'.tr(),
    },
  ];
}
