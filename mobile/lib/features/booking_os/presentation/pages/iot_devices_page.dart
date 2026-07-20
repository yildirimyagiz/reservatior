import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class IotDevicesPage extends ConsumerWidget {
  const IotDevicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'booking_os.iot_devices'.tr(),
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
              child: _DeviceStatsCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _FilterChips(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _DeviceCard(index: index);
                },
                childCount: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceStatsCard extends StatelessWidget {
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
              Icon(Icons.sensors, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'booking_os.device_stats'.tr(),
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
                child: _StatItem(
                  label: 'booking_os.total_devices'.tr(),
                  value: '156',
                  color: AppColors.primary,
                  icon: Icons.devices,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatItem(
                  label: 'booking_os.online'.tr(),
                  value: '142',
                  color: AppColors.success,
                  icon: Icons.wifi,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatItem(
                  label: 'booking_os.offline'.tr(),
                  value: '14',
                  color: AppColors.warning,
                  icon: Icons.wifi_off,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'All', isSelected: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'Smart Locks', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Thermostats', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Sensors', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'Cameras', isSelected: false),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final int index;

  const _DeviceCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final deviceTypes = ['Smart Lock', 'Thermostat', 'Motion Sensor', 'Camera'];
    final deviceType = deviceTypes[index % deviceTypes.length];
    final isOnline = index % 5 != 0;
    final deviceIcons = {
      'Smart Lock': Icons.lock,
      'Thermostat': Icons.thermostat,
      'Motion Sensor': Icons.sensors,
      'Camera': Icons.videocam,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success.withValues(alpha: 0.2) : AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  deviceIcons[deviceType],
                  color: isOnline ? AppColors.success : AppColors.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceType,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Marina Residences #${['4B', '7A', '12C', '3D'][index % 4]}',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success.withValues(alpha: 0.2) : AppColors.warning.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isOnline ? AppColors.success : AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: isOnline ? AppColors.success : AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DeviceInfo(
                  label: 'booking_os.battery'.tr(),
                  value: '${85 - (index * 3)}%',
                  icon: Icons.battery_full,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DeviceInfo(
                  label: 'booking_os.signal'.tr(),
                  value: 'Strong',
                  icon: Icons.signal_cellular_alt,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DeviceInfo(
                  label: 'booking_os.last_seen'.tr(),
                  value: '${index * 5}m ago',
                  icon: Icons.access_time,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DeviceActionButton(
                  label: 'booking_os.control'.tr(),
                  icon: Icons.settings_remote,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DeviceActionButton(
                  label: 'booking_os.logs'.tr(),
                  icon: Icons.history,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DeviceActionButton(
                  label: 'booking_os.restart'.tr(),
                  icon: Icons.refresh,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _DeviceInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DeviceInfo({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _DeviceActionButton({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
