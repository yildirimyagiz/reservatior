import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/providers/admin/ai_sentiment_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardManagementScreen extends ConsumerWidget {
  const DashboardManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiMessagesAsync = ref.watch(aiAnalyzedMessagesProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'mobile.admin.dashboard.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // KPI Bar
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  _buildKpiCard('Aylık Ciro', '\$45,200', Icons.attach_money, Colors.greenAccent),
                  const SizedBox(width: 12),
                  _buildKpiCard('Bekleyen Bakım', '4', Icons.handyman, Colors.orangeAccent),
                  const SizedBox(width: 12),
                  _buildKpiCard('Aktif Kiracı', '124', Icons.people, Colors.blueAccent),
                ],
              ),
            ),
          ),

          // Title: AI Triage Alerts
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Text(
                    'AI Kriz Masası (Acil Mesajlar)',
                    style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Urgent Messages List
          aiMessagesAsync.when(
            loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
            error: (e, s) => SliverToBoxAdapter(child: Text('Hata: $e', style: const TextStyle(color: Colors.red))),
            data: (analyzedList) {
              final urgentMsgs = analyzedList.where((m) => m.sentiment == AiSentiment.angry || m.sentiment == AiSentiment.urgent).toList();
              
              if (urgentMsgs.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(16)),
                    child: const Center(child: Text('Kriz yok. Her şey yolunda!', style: TextStyle(color: Colors.white54))),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final am = urgentMsgs[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: am.sentiment.color.withValues(alpha: 0.1),
                          border: Border(left: BorderSide(color: am.sentiment.color, width: 4)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(am.message.subject ?? 'Konusuz', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(am.message.body, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70)),
                          trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                        ),
                      ).animate().fadeIn().slideX();
                    },
                    childCount: urgentMsgs.length,
                  ),
                ),
              );
            },
          ),

          // Title: Financial Automations
          SliverPadding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24, bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.gold),
                  const SizedBox(width: 8),
                  Text(
                    'Son Otomatik İşlemler (Finans)',
                    style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Financial List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.greenAccent, radius: 16, child: Icon(Icons.check, size: 16, color: Colors.black)),
                    title: const Text('Bakım Faturası Kesildi (WO-492)', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Mülk Ledgerından düşüldü: \$500.00', style: TextStyle(color: Colors.white54)),
                    trailing: const Text('2 dk önce', style: TextStyle(color: Colors.white30, fontSize: 12)),
                  ),
                );
              }, childCount: 3),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
