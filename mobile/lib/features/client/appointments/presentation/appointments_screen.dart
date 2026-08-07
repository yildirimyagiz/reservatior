import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/appointment.dart';
import 'package:reservatior/shared/providers/appointment_provider.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() =>
      _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  String? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final asyncAppointments = ref.watch(appointmentListProvider);
    final appointments = asyncAppointments.value ?? <Appointment>[];

    final statuses = appointments.map((a) => a.status).toSet().toList();

    final visible = _statusFilter == null
        ? appointments
        : appointments.where((a) => a.status == _statusFilter).toList()
          ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Appointments',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          if (statuses.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        selected: _statusFilter == null,
                        onTap: () => setState(() => _statusFilter = null),
                      ),
                      ...statuses.map((s) => _FilterChip(
                            label: s.replaceAll('_', ' '),
                            selected: _statusFilter == s,
                            onTap: () =>
                                setState(() => _statusFilter = s),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncAppointments.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load appointments',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (appointments) {
                    if (visible.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.event_busy_outlined,
                                color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No appointments',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children:
                          visible.map((a) => _AppointmentTile(appointment: a)).toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  const _AppointmentTile({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(appointment.status);
    final allDay =
        appointment.startDate == appointment.endDate && appointment.title.isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.event_outlined, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      appointment.appointmentType.replaceAll('_', ' '),
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  appointment.status.replaceAll('_', ' '),
                  style: GoogleFonts.outfit(
                      color: color, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (appointment.description != null) ...[
            const SizedBox(height: 8),
            Text(
              appointment.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                allDay
                    ? DateFormat.yMMMd().format(appointment.startDate)
                    : '${DateFormat.yMMMd().format(appointment.startDate)} · '
                        '${DateFormat.Hm().format(appointment.startDate)}–${DateFormat.Hm().format(appointment.endDate)}',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
              if (appointment.location != null) ...[
                const Spacer(),
                Icon(Icons.place_outlined, color: Colors.white24, size: 13),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    appointment.location!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                  ),
                ),
              ],
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'DONE':
        return AppColors.success;
      case 'CANCELLED':
        return Colors.white38;
      case 'CONFIRMED':
      case 'SCHEDULED':
        return AppColors.info;
      case 'PENDING':
      default:
        return AppColors.warning;
    }
  }
}
