import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../data/models/room_model.dart';

/// İlan detay sayfasında — oda bazlı video navigasyon butonları
/// Her butona basınca video ilgili bölümün başlangıç anına atlar.
class RoomNavigatorWidget extends StatefulWidget {
  final List<RoomSection> rooms;
  final ValueChanged<double> onSeek; // saniye cinsinden timestamp
  final double currentTimestamp;

  const RoomNavigatorWidget({
    super.key,
    required this.rooms,
    required this.onSeek,
    required this.currentTimestamp,
  });

  
  State<RoomNavigatorWidget> createState() => _RoomNavigatorWidgetState();
}

class _RoomNavigatorWidgetState extends State<RoomNavigatorWidget> {
  String? _activeRoomId;

  
  void didUpdateWidget(RoomNavigatorWidget old) {
    super.didUpdateWidget(old);
    // Aktif odayı timestamp'e göre güncelle
    _updateActiveRoom(widget.currentTimestamp);
  }

  void _updateActiveRoom(double ts) {
    for (final r in widget.rooms.reversed) {
      if (r.videoTimestamp != null && ts >= r.videoTimestamp!) {
        if (_activeRoomId != r.id) {
          setState(() => _activeRoomId = r.id);
        }
        return;
      }
    }
    if (widget.rooms.isNotEmpty) {
      setState(() => _activeRoomId = widget.rooms.firstWhere.id);
    }
  }

  
  Widget build(BuildContext context) {
    final captured =
        widget.rooms.where((r) => r.status == RoomCaptureStatus.captured).toList();

    if (captured.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Row(
            children: [
              const Icon(Icons.map_outlined,
                  color: AppColors.gold, size: 16),
              const SizedBox(width: 6),
              Text(
                'Oda Gezgini',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.textPrimaryDark),
              ),
              const Spacer(),
              Text(
                '${captured.length} bölüm',
                style: const TextStyle(
                    color: AppColors.textSecondaryDark, fontSize: 12),
              ),
            ],
          ),
        ),

        // Grid butonlar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: captured.asMap().entries.map((e) {
              final i = e.key;
              final room = e.value;
              final isActive = _activeRoomId == room.id;

              return _RoomButton(
                room: room,
                isActive: isActive,
                onTap: () {
                  setState(() => _activeRoomId = room.id);
                  widget.onSeek(room.videoTimestamp ?? 0);
                },
              ).animate().fadeIn(
                    duration: 350.ms,
                    delay: Duration(milliseconds: 40 * i));
            }).toList(),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Horizontal scroll — genişletilmiş kart görünümü
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: 4),
            itemCount: captured.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final room = captured[i];
              final isActive = _activeRoomId == room.id;
              return _RoomTimelineCard(
                room: room,
                isActive: isActive,
                onTap: () {
                  setState(() => _activeRoomId = room.id);
                  widget.onSeek(room.videoTimestamp ?? 0);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Küçük oda butonu ──────────────────────────────────────────────────────────────
class _RoomButton extends StatelessWidget {
  final RoomSection room;
  final bool isActive;
  final VoidCallback onTap;

  const _RoomButton({
    required this.room,
    required this.isActive,
    required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? room.color.withOpacity(0.15)
              : AppColors.darkCard,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isActive
                ? room.color
                : AppColors.darkBorder,
            width: isActive ? 1.5 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: room.color.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(room.icon,
                style: TextStyle(
                    fontSize: 15,
                    color: isActive ? null : Colors.grey)),
            const SizedBox(width: 6),
            Text(
              room.displayName,
              style: TextStyle(
                color: isActive
                    ? room.color
                    : AppColors.textSecondaryDark,
                fontSize: 12,
                fontWeight:
                    isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Icon(Icons.play_arrow_rounded,
                  size: 13, color: room.color),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Zaman çizelgesi kartı ─────────────────────────────────────────────────────────
class _RoomTimelineCard extends StatelessWidget {
  final RoomSection room;
  final bool isActive;
  final VoidCallback onTap;

  const _RoomTimelineCard({
    required this.room,
    required this.isActive,
    required this.onTap,
  });

  String _formatTs(double? ts) {
    if (ts == null) return '0:00';
    final m = (ts ~/ 60).toString().padLeft(2, '0');
    final s = (ts % 60).toInt().toString().padLeft(2, '0');
    return '$m:$s';
  }

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        width: 100,
        decoration: BoxDecoration(
          color: isActive
              ? room.color.withOpacity(0.12)
              : AppColors.darkCard,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isActive
                ? room.color
                : AppColors.darkBorder,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            // Thumbnail arka Plan
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md - 1),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      room.color.withOpacity(0.08),
                      Colors.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            // İçerik
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(room.icon,
                          style: const TextStyle(fontSize: 18)),
                      const Spacer(),
                      if (isActive)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: room.color,
                            shape: BoxShape.circle,
                          ),
                        ).animate(
                                onPlay: (c) => c.repeat(reverse: true))
                            .fadeOut(duration: 600.ms),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    room.displayName,
                    style: TextStyle(
                      color: isActive
                          ? room.color
                          : AppColors.textPrimaryDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.play_circle_outline_rounded,
                          size: 10,
                          color: isActive
                              ? room.color
                              : AppColors.textSecondaryDark),
                      const SizedBox(width: 3),
                      Text(
                        _formatTs(room.videoTimestamp),
                        style: TextStyle(
                          color: isActive
                              ? room.color
                              : AppColors.textSecondaryDark,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// İlan özeti için kullanılan kompakt oda rozet listesi
class RoomBadgeStrip extends StatelessWidget {
  final List<RoomSection> rooms;

  const RoomBadgeStrip({super.key, required this.rooms});

  
  Widget build(BuildContext context) {
    final captured =
        rooms.where((r) => r.status == RoomCaptureStatus.captured).toList();
    if (captured.isEmpty) return const SizedBox();

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: captured.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (ctx, i) {
          final r = captured[i];
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: r.color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(color: r.color.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(r.icon,
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(
                  r.displayName,
                  style: TextStyle(
                      color: r.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
