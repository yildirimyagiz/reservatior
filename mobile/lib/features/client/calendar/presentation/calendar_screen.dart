import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/calendar_event.dart';
import 'package:reservatior/shared/providers/calendar_event_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  final bool todayFocus;
  const CalendarScreen({super.key, this.todayFocus = false});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _month = DateTime(DateTime.now().year, DateTime.now().month);
  }

  void _shift(int delta) {
    setState(() => _month = DateTime(_month.year, _month.month + delta));
  }

  @override
  Widget build(BuildContext context) {
    final asyncEvents = ref.watch(calendarEventListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              widget.todayFocus ? 'Today' : 'Calendar',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _shift(-1),
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.white70),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMM().format(_month),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _shift(1),
                      icon: const Icon(Icons.chevron_right,
                          color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildMonthGrid(asyncEvents.value ?? const []),
                const SizedBox(height: 24),
                Text(
                  widget.todayFocus ? 'Upcoming today' : 'Upcoming events',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                _buildUpcoming(asyncEvents.value ?? const []),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid(List<CalendarEvent> events) {
    final today = DateTime.now();
    final firstDay = DateTime(_month.year, _month.month, 1);
    final leading = firstDay.weekday % 7;
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;

    final cells = <DateTime>[];
    for (var i = 0; i < leading; i++) {
      cells.add(DateTime(_month.year, _month.month, -leading + i + 1));
    }
    for (var d = 1; d <= daysInMonth; d++) {
      cells.add(DateTime(_month.year, _month.month, d));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            children: const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map(
                  (d) => Expanded(
                    child: Text(
                      d,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          for (var r = 0; r < (cells.length / 7).ceil(); r++)
            Row(
              children: [
                for (var c = 0; c < 7; c++)
                  Expanded(
                    child: _dayCell(cells[r * 7 + c], events, today),
                  ),
              ],
            ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _dayCell(DateTime date, List<CalendarEvent> events, DateTime today) {
    final inMonth = date.month == _month.month;
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final dayEvents = events
        .where((e) =>
            e.startDate.year == date.year &&
            e.startDate.month == date.month &&
            e.startDate.day == date.day)
        .toList();

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 44,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isToday ? AppColors.primary : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: GoogleFonts.outfit(
                color: !inMonth
                    ? Colors.white24
                    : (isToday ? Colors.white : Colors.white70),
                fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
            if (dayEvents.isNotEmpty)
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: isToday ? Colors.white : AppColors.gold,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcoming(List<CalendarEvent> events) {
    final sorted = [...events]..sort((a, b) => a.startDate.compareTo(b.startDate));
    final upcoming = sorted.where((e) => e.startDate.isAfter(DateTime.now())).take(6).toList();

    if (upcoming.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          children: [
            Icon(Icons.event_available, color: Colors.white24, size: 36),
            const SizedBox(height: 8),
            Text(
              'No upcoming events',
              style: GoogleFonts.outfit(color: Colors.white54),
            ),
          ],
        ),
      );
    }

    return Column(
      children: upcoming
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.event,
                        color: AppColors.primary, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (e.location != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            e.location!,
                            style: GoogleFonts.outfit(
                                color: Colors.white38, fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Text(
                    DateFormat.MMMd().add_Hm().format(e.startDate),
                    style: GoogleFonts.outfit(
                        color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
