import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class SolicitorDetailsPage extends ConsumerWidget {
  final String? id;

  const SolicitorDetailsPage({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'solicitor_management.details'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _ProfileCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _ContactInfoCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _LegalInfoCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _AppointmentCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _ActionsCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
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
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(Icons.person, color: AppColors.primary, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            'John Smith',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Smith & Co Legal',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.success.withOpacity(0.5)),
            ),
            child: Text(
              'VERIFIED',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _ContactInfoCard extends StatelessWidget {
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
              Icon(Icons.contact_mail, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'solicitor_management.contact_info'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.email,
            label: 'Email',
            value: 'john@smithlegal.com',
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.phone,
            label: 'Phone',
            value: '+44 20 7123 4567',
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.location_on,
            label: 'Address',
            value: '123 Legal Street, London, UK',
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 100.ms);
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white54),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegalInfoCard extends StatelessWidget {
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
              Icon(Icons.scale, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'solicitor_management.legal_info'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _LegalRow(
            label: 'solicitor_management.type'.tr(),
            value: 'TENANT_INTERNATIONAL_LAWYER',
          ),
          const SizedBox(height: 12),
          _LegalRow(
            label: 'solicitor_management.country'.tr(),
            value: 'GB',
          ),
          const SizedBox(height: 12),
          _LegalRow(
            label: 'solicitor_management.bar_reg'.tr(),
            value: 'BAR-GB-12345',
          ),
          const SizedBox(height: 12),
          _LegalRow(
            label: 'solicitor_management.notice_address'.tr(),
            value: '123 Legal Street, London, UK',
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 200.ms);
  }
}

class _LegalRow extends StatelessWidget {
  final String label;
  final String value;

  const _LegalRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _AppointmentCard extends StatelessWidget {
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
              Icon(Icons.event, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'solicitor_management.appointment'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _AppointmentRow(
            label: 'solicitor_management.appointment_type'.tr(),
            value: 'INITIAL_CONSULTATION',
          ),
          const SizedBox(height: 12),
          _AppointmentRow(
            label: 'solicitor_management.appointment_date'.tr(),
            value: 'Aug 1, 2026',
          ),
          const SizedBox(height: 12),
          _AppointmentRow(
            label: 'solicitor_management.completion_date'.tr(),
            value: 'Not set',
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 300.ms);
  }
}

class _AppointmentRow extends StatelessWidget {
  final String label;
  final String value;

  const _AppointmentRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _ActionsCard extends StatelessWidget {
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
                'solicitor_management.actions'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'solicitor_management.verify'.tr(),
                  icon: Icons.verified,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  label: 'solicitor_management.contact'.tr(),
                  icon: Icons.mail,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'solicitor_management.documents'.tr(),
                  icon: Icons.folder,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  label: 'solicitor_management.history'.tr(),
                  icon: Icons.history,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(delay: 400.ms);
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
