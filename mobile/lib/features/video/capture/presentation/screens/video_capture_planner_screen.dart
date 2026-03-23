import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/app_widgets.dart';
import '../../data/models/room_model.dart';
import './guided_capture_screen.dart';

/// ADIM 1 — Çekim Planı Ekranı
/// Kullanıcı hangi odaları çekeceğini seçer, ardından rehberli çekime geçer.
class VideoCapturePlannerScreen extends StatefulWidget {
  const VideoCapturePlannerScreen({super.key});

  
  State<VideoCapturePlannerScreen> createState() =>
      _VideoCapturePlannerScreenState();
}

class _VideoCapturePlannerScreenState
    extends State<VideoCapturePlannerScreen> {
  final List<RoomSection> _rooms =
      kAllRoomSections.map((r) => r.copyWith()).toList();

  List<RoomSection> get _selected =>
      _rooms.where((r) => r.status != RoomCaptureStatus.skipped).toList();

  int get _totalSeconds =>
      _selected.fold(0, (s, r) => s + r.recommendedDuration.inSeconds);

  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: const Text('Çekim Planı'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() {
              for (final r in _rooms) {
                if (r.isRequired) r.status = RoomCaptureStatus.pending;
              }
            }),
            child: const Text('Varsayılan',
                style: TextStyle(color: AppColors.gold, fontSize: 13)),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Özet bar ──────────────────────────────────────────
          _SummaryBar(
            selectedCount: _selected.length,
            totalSeconds: _totalSeconds,
          ).animate().fadeIn(duration: 400.ms),

          // ── Oda listesi ───────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              itemCount: _rooms.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (ctx, i) {
                final room = _rooms[i];
                final isSelected =
                    room.status != RoomCaptureStatus.skipped;
                return _RoomPlanCard(
                  room: room,
                  isSelected: isSelected,
                  onToggle: room.isRequired
                      ? null // Zorunlu odalar devre dışı bırakılamaz
                      : () {
                          setState(() {
                            _rooms[i].status = isSelected
                                ? RoomCaptureStatus.skipped
                                : RoomCaptureStatus.pending;
                          });
                        },
                  onReorder: null,
                ).animate().fadeIn(
                    duration: 400.ms,
                    delay: Duration(milliseconds: 40 + i * 30));
              },
            ),
          ),

          // ── Başlat butonu ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppColors.darkBorder)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _InfoChip(
                        icon: Icons.videocam_outlined,
                        label: '${_selected.length} Bölüm',
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _InfoChip(
                        icon: Icons.timer_outlined,
                        label: '~${(_totalSeconds / 60).ceil()} dk',
                        color: AppColors.info,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _InfoChip(
                        icon: Icons.auto_awesome_rounded,
                        label: 'AI Rehber',
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                GoldButton(
                  label: '🎬  Çekime Başla',
                  onPressed: _selected.isEmpty
                      ? null
                      : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GuidedCaptureScreen(
                                rooms: _selected,
                              ),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Özet Bar ──────────────────────────────────────────────────────────────────────
class _SummaryBar extends StatelessWidget {
  final int selectedCount, totalSeconds;
  const _SummaryBar(
      {required this.selectedCount, required this.totalSeconds});

  
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.gold.withOpacity(0.08),
          AppColors.darkCard,
        ]),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border:
            Border.all(color: AppColors.gold.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Text('✨',
              style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Destekli Çekim Rehberi',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.gold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Her odada adım adım yönlendirme alacaksınız',
                  style: TextStyle(
                      color: AppColors.textSecondaryDark,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Oda Plan Kartı ────────────────────────────────────────────────────────────────
class _RoomPlanCard extends StatelessWidget {
  final RoomSection room;
  final bool isSelected;
  final VoidCallback? onToggle;
  final VoidCallback? onReorder;

  const _RoomPlanCard({
    required this.room,
    required this.isSelected,
    this.onToggle,
    this.onReorder,
  });

  
  Widget build(BuildContext context) {
    final Color cardColor = isSelected
        ? room.color.withOpacity(0.08)
        : AppColors.darkCard.withOpacity(0.5);
    final Color borderColor = isSelected
        ? room.color.withOpacity(0.35)
        : AppColors.darkBorder;

    return AnimatedContainer(
      duration: 200.ms,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: 12),
        child: Row(
          children: [
            // Oda ikonu
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? room.color.withOpacity(0.15)
                    : AppColors.darkMuted.withOpacity(0.4),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Center(
                child: Text(room.icon,
                    style: TextStyle(
                        fontSize: 22,
                        color: isSelected ? null : Colors.grey)),
              ),
            ),
            const SizedBox(width: 12),

            // İsim + süre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        room.displayName,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.textPrimaryDark
                              : AppColors.textSecondaryDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (room.isRequired) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                AppColors.gold.withOpacity(0.15),
                            borderRadius:
                                BorderRadius.circular(AppRadius.full),
                          ),
                          child: const Text('Zorunlu',
                              style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          size: 11,
                          color: AppColors.textSecondaryDark),
                      const SizedBox(width: 3),
                      Text(
                        '~${room.recommendedDuration.inSeconds}sn',
                        style: const TextStyle(
                            color: AppColors.textSecondaryDark,
                            fontSize: 11),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.tips_and_updates_outlined,
                          size: 11,
                          color: AppColors.textSecondaryDark),
                      const SizedBox(width: 3),
                      Text(
                        '${room.tips.length} ipucu',
                        style: const TextStyle(
                            color: AppColors.textSecondaryDark,
                            fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Toggle switch
            Transform.scale(
              scale: 0.85,
              child: Switch(
                value: isSelected,
                onChanged: room.isRequired ? null : (_) => onToggle?.call(),
                activeColor: room.color,
                inactiveThumbColor: AppColors.darkMuted,
                inactiveTrackColor: AppColors.darkBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _InfoChip(
      {required this.icon, required this.label, required this.color});

  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
