import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class SagaConfigPage extends ConsumerWidget {
  const SagaConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'saga_flow.config'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _GlobalSettingsCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _RetryPolicyCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _TimeoutSettingsCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _CompensationCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlobalSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.global_settings'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingToggle(
            label: 'saga_flow.enable_saga'.tr(),
            subtitle: 'saga_flow.enable_saga_desc'.tr(),
            value: true,
          ),
          const SizedBox(height: 12),
          _SettingToggle(
            label: 'saga_flow.async_mode'.tr(),
            subtitle: 'saga_flow.async_mode_desc'.tr(),
            value: true,
          ),
          const SizedBox(height: 12),
          _SettingToggle(
            label: 'saga_flow.logging'.tr(),
            subtitle: 'saga_flow.logging_desc'.tr(),
            value: true,
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _RetryPolicyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.refresh, color: AppColors.warning, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.retry_policy'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingRow(
            label: 'saga_flow.max_retries'.tr(),
            value: '3',
            icon: Icons.repeat,
          ),
          const SizedBox(height: 12),
          _SettingRow(
            label: 'saga_flow.retry_delay'.tr(),
            value: '5s',
            icon: Icons.timer,
          ),
          const SizedBox(height: 12),
          _SettingRow(
            label: 'saga_flow.backoff_strategy'.tr(),
            value: 'Exponential',
            icon: Icons.trending_up,
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 100.ms);
  }
}

class _TimeoutSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: AppColors.info, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.timeout_settings'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingRow(
            label: 'saga_flow.step_timeout'.tr(),
            value: '30s',
            icon: Icons.access_time,
          ),
          const SizedBox(height: 12),
          _SettingRow(
            label: 'saga_flow.saga_timeout'.tr(),
            value: '5m',
            icon: Icons.schedule,
          ),
          const SizedBox(height: 12),
          _SettingRow(
            label: 'saga_flow.compensation_timeout'.tr(),
            value: '2m',
            icon: Icons.undo,
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 200.ms);
  }
}

class _CompensationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.undo, color: AppColors.success, size: 20),
              const SizedBox(width: 8),
              Text(
                'saga_flow.compensation'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingToggle(
            label: 'saga_flow.auto_compensate'.tr(),
            subtitle: 'saga_flow.auto_compensate_desc'.tr(),
            value: true,
          ),
          const SizedBox(height: 12),
          _SettingToggle(
            label: 'saga_force_compensate'.tr(),
            subtitle: 'saga_force_compensate_desc'.tr(),
            value: false,
          ),
          const SizedBox(height: 12),
          _SettingRow(
            label: 'saga_flow.compensation_strategy'.tr(),
            value: 'Full Rollback',
            icon: Icons.settings_backup_restore,
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 300.ms);
  }
}

class _SettingToggle extends StatelessWidget {
  final String label;
  final String subtitle;
  final bool value;

  const _SettingToggle({
    required this.label,
    required this.subtitle,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (value) {},
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SettingRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white54),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.5)),
          ),
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
