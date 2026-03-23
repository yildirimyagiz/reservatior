// ══════════════════════════════════════════════════════════════════════════════
//  more_screen.dart  —  Secondary navigation hub
//  Tasks, Messages, Reports, Documents, Settings vs.
// ══════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import './core/theme/app_theme.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        surfaceTintColor: Colors.transparent,
        title: const Text('Menü',
            style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 20, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppColors.textSecondaryDark),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [

          // ── İletişim ────────────────────────────────────────
          _SectionHeader('İletişim'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.chat_bubble_rounded,
              label: 'Mesajlar',
              subtitle: 'Konuşmalar & yazışmalar',
              color: AppColors.info,
              Route: '/messages',
              badge: 4,
            ),
            _MenuEntry(
              icon: Icons.notifications_rounded,
              label: 'Bildirimler',
              subtitle: 'Sistem bildirimleri',
              color: AppColors.warning,
              Route: '/notifications',
              badge: 2,
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 50.ms),

          // ── Görevler & Takvim ───────────────────────────────
          _SectionHeader('Görevler & Planlama'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.task_alt_rounded,
              label: 'Görevler',
              subtitle: 'Bekleyen & aktif görevler',
              color: AppColors.gold,
              Route: '/tasks',
              badge: 3,
            ),
            _MenuEntry(
              icon: Icons.calendar_today_rounded,
              label: 'Takvim',
              subtitle: 'Randevu & etkinlikler',
              color: AppColors.success,
              Route: '/calendar',
            ),
            _MenuEntry(
              icon: Icons.folder_rounded,
              label: 'Belgeler',
              subtitle: 'Döküman yönetimi',
              color: AppColors.info,
              Route: '/documents',
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 100.ms),

          // ── Analiz & Raporlar ────────────────────────────────
          _SectionHeader('Analiz & Raporlar'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.bar_chart_rounded,
              label: 'Raporlar',
              subtitle: 'Özel & zamanlanmış raporlar',
              color: AppColors.gold,
              Route: '/reports',
            ),
            _MenuEntry(
              icon: Icons.analytics_rounded,
              label: 'Analitik',
              subtitle: 'Performans & trendler',
              color: AppColors.info,
              Route: '/Analytics',
            ),
            _MenuEntry(
              icon: Icons.map_rounded,
              label: 'Piyasa Analizi',
              subtitle: 'Bölge değerleme & CMA',
              color: AppColors.success,
              Route: '/market-analysis',
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 150.ms),

          // ── Finans ──────────────────────────────────────────
          _SectionHeader('Finans'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.account_balance_rounded,
              label: 'Finansal Kayıtlar',
              subtitle: 'Gelir, gider, özet',
              color: AppColors.success,
              Route: '/financials',
            ),
            _MenuEntry(
              icon: Icons.payments_rounded,
              label: 'Ödemeler',
              subtitle: 'Ödeme geçmişi',
              color: AppColors.gold,
              Route: '/payments',
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 200.ms),

          // ── AI & Entegrasyon ─────────────────────────────────
          _SectionHeader('AI & Araçlar'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.smart_toy_rounded,
              label: 'AI Asistan',
              subtitle: 'EstateAI Chat',
              color: AppColors.gold,
              Route: '/ai-chat',
              isNew: true,
            ),
            _MenuEntry(
              icon: Icons.photo_camera_rounded,
              label: 'Sosyal Medya',
              subtitle: 'Instagram feed & paylaşım',
              color: const Color(0xFFE1306C),
              Route: '/social-feed',
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 250.ms),

          // ── Hesap ────────────────────────────────────────────
          _SectionHeader('Hesap'),
          _MenuGroup(items: [
            _MenuEntry(
              icon: Icons.settings_rounded,
              label: 'Ayarlar',
              subtitle: 'Uygulama tercihleri',
              color: AppColors.textSecondaryDark,
              Route: '/settings',
            ),
          ]).animate().fadeIn(duration: 300.ms, delay: 300.ms),

          const SizedBox(height: 24),

          // ── Version ──────────────────────────────────────────
          Center(
            child: Text(
              'EstateAI v2.0.0',
              style: const TextStyle(color: AppColors.darkMuted, fontSize: 11),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─── Section Header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8, left: 2),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.textSecondaryDark,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

// ─── Menu Group ────────────────────────────────────────────────────────────────
class _MenuGroup extends StatelessWidget {
  final List<_MenuEntry> items;
  const _MenuGroup({required this.items});

  
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final item = e.value;
          final isLast = e.key == items.length - 1;
          return _MenuTile(entry: item, isLast: isLast);
        }).toList(),
      ),
    );
  }
}

// ─── Menu Tile ────────────────────────────────────────────────────────────────
class _MenuTile extends StatelessWidget {
  final _MenuEntry entry;
  final bool isLast;
  const _MenuTile({required this.entry, required this.isLast});

  
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => context.push(entry.Route),
          borderRadius: BorderRadius.vertical(
            top: e.key == 0 ? const Radius.circular(AppRadius.md) : Radius.zero,
            bottom: isLast ? const Radius.circular(AppRadius.md) : Radius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              // Icon
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: entry.color.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(entry.icon, size: 18, color: entry.color),
              ),
              const SizedBox(width: 12),

              // Text
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(entry.label,
                      style: const TextStyle(color: AppColors.textPrimaryDark, fontSize: 14, fontWeight: FontWeight.w500)),
                  if (entry.isNew) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('YENİ', style: TextStyle(color: AppColors.gold, fontSize: 9, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ]),
                Text(entry.subtitle,
                    style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 11)),
              ])),

              // Badge or chevron
              if (entry.badge != null && entry.badge! > 0)
                Container(
                  constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(child: Text('${entry.badge}',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800))),
                )
              else
                const Icon(Icons.chevron_right_rounded, color: AppColors.darkMuted, size: 18),
            ]),
          ),
        ),
        if (!isLast)
          const Divider(color: AppColors.darkBorder, height: 1, indent: 64),
      ],
    );
  }
}

// ─── Entry Model ──────────────────────────────────────────────────────────────
class _MenuEntry {
  final IconData icon;
  final String label, subtitle, Route;
  final Color color;
  final int? badge;
  final bool isNew;
  const _MenuEntry({
    required this.icon, required this.label, required this.subtitle,
    required this.color, required this.Route, this.badge, this.isNew = false,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
//  home_page.dart  —  Messaging widget + quick stats eklendi
//  Mevcut home_page.dart'ı extend eder, messaging section eklenir
// ══════════════════════════════════════════════════════════════════════════════

/// Mesajlaşma section'ı — HomePage'e SliverToBoxAdapter olarak eklenir
class HomeMessagingSection extends StatelessWidget {
  const HomeMessagingSection({super.key});

  // Sample recent threads — gerçekte threadsProvider'dan gelir
  static const _threads = [
    (name: 'John Smith',    initials: 'JS', msg: 'Pazartesi uygun mu?',       time: '10:30', unread: 2),
    (name: 'Maria Garcia',  initials: 'MG', msg: 'Evrakları yarın gönderirim', time: 'Dün',   unread: 0),
    (name: 'Ali Rıza K.',   initials: 'AK', msg: 'Teklifinizi değerlendiriyorum', time: 'Dün', unread: 1),
  ];

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        // ── Header ──────────────────────────────────────────
        Row(children: [
          const Expanded(
            child: Text('Son Mesajlar',
                style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          GestureDetector(
            onTap: () => context.push('/messages'),
            child: const Text('Tümünü Gör →',
                style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ]),
        const SizedBox(height: 10),

        // ── Thread List ──────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Column(
            children: _threads.asMap().entries.map((e) {
              final t = e.value;
              final isLast = e.key == _threads.length - 1;
              return _CompactThreadTile(
                name: t.name,
                initials: t.initials,
                Message: t.msg,
                time: t.time,
                unread: t.unread,
                isLast: isLast,
                onTap: () => context.push('/messages/thread_${e.key + 1}',
                    extra: {'subject': t.msg, 'Contact': {'name': t.name, 'initials': t.initials}}),
              );
            }).toList(),
          ),
        ),

        // ── Compose Button ───────────────────────────────────
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => context.push('/messages'),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.info.withOpacity(0.3)),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.edit_rounded, size: 15, color: AppColors.info),
              SizedBox(width: 6),
              Text('Yeni Mesaj', style: TextStyle(color: AppColors.info, fontSize: 13, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ─── Compact Thread Tile ──────────────────────────────────────────────────────
class _CompactThreadTile extends StatelessWidget {
  final String name, initials, Message, time;
  final int unread;
  final bool isLast;
  final VoidCallback onTap;

  const _CompactThreadTile({
    required this.name, required this.initials, required this.Message,
    required this.time, required this.unread, required this.isLast, required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          child: Row(children: [
            // Avatar
            Stack(children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: unread > 0
                    ? AppColors.gold.withOpacity(0.2)
                    : AppColors.darkSurface,
                child: Text(initials, style: TextStyle(
                  color: unread > 0 ? AppColors.gold : AppColors.textSecondaryDark,
                  fontSize: 12, fontWeight: FontWeight.w700,
                )),
              ),
              if (unread > 0)
                Positioned(right: 0, top: 0, child: Container(
                  width: 14, height: 14,
                  decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                  child: Center(child: Text('$unread',
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800))),
                )),
            ]),
            const SizedBox(width: 10),

            // Content
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(name, style: TextStyle(
                  color: AppColors.textPrimaryDark, fontSize: 13,
                  fontWeight: unread > 0 ? FontWeight.w700 : FontWeight.w500,
                ))),
                Text(time, style: TextStyle(
                  color: unread > 0 ? AppColors.gold : AppColors.textSecondaryDark,
                  fontSize: 10,
                  fontWeight: unread > 0 ? FontWeight.w600 : FontWeight.w400,
                )),
              ]),
              const SizedBox(height: 2),
              Text(Message,
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: unread > 0 ? AppColors.textPrimaryDark : AppColors.textSecondaryDark,
                  fontSize: 12,
                  fontWeight: unread > 0 ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ])),
          ]),
        ),
      ),
      if (!isLast)
        const Divider(color: AppColors.darkBorder, height: 1, indent: 56),
    ]);
  }
}

/// Görev Özeti Widget — HomePage'e SliverToBoxAdapter olarak eklenir
class HomeTaskSummarySection extends StatelessWidget {
  const HomeTaskSummarySection({super.key});

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Row(children: [
          const Expanded(
            child: Text('Bekleyen Görevler',
                style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          GestureDetector(
            onTap: () {
              try {
                context.push('/tasks');
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hata: $error')),
                );
              }
            },
            child: const Text('Tümünü Gör →',
                style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ]),
        const SizedBox(height: 10),

        // Task summaries
        Row(children: [
          Expanded(child: _TaskStat(count: 3, label: 'Acil', color: AppColors.error, icon: Icons.priority_high_rounded, onTap: () => context.push('/tasks'))),
          const SizedBox(width: 10),
          Expanded(child: _TaskStat(count: 5, label: 'Bekleyen', color: AppColors.warning, icon: Icons.schedule_rounded, onTap: () => context.push('/tasks'))),
          const SizedBox(width: 10),
          Expanded(child: _TaskStat(count: 2, label: 'Bugün', color: AppColors.info, icon: Icons.today_rounded, onTap: () => context.push('/tasks'))),
        ]),
      ]),
    );
  }
}

class _TaskStat extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  const _TaskStat({required this.count, required this.label, required this.color, required this.icon, required this.onTap});

  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text('$count', style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 11)),
        ]),
      ),
    );
  }
}