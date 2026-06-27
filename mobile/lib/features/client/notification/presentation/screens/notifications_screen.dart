import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    final notifications = [
      _NotifItem(
        icon: Icons.gpp_maybe_rounded, 
        color: Colors.redAccent, 
        title: 'Yapay Zeka Denetimi: Konum Sapması', 
        subtitle: 'Fiziki denetim tamamlandı fakat görevli koordinatları mülk konumuyla uyuşmuyor. Manuel inceleme önerilir.', 
        time: 'Şimdi', 
        unread: true
      ),
      _NotifItem(
        icon: Icons.shield_outlined, 
        color: Colors.amberAccent, 
        title: 'Yapay Zeka Denetimi: KBS Jandarma Hatası', 
        subtitle: 'Pasaport numarası uyuşmazlığı nedeniyle jandarma KBS kaydı başarısız oldu. Acil düzeltme gerekiyor.', 
        time: '5dk', 
        unread: true
      ),
      _NotifItem(icon: Icons.home_work_rounded, color: AppColors.primary, title: 'mobile.notif.newBooking'.tr(), subtitle: 'mobile.notif.newBookingDesc'.tr(), time: 'mobile.auto.time_2m'.tr(), unread: true),
      _NotifItem(icon: Icons.attach_money_rounded, color: Colors.greenAccent, title: 'mobile.notif.paymentReceived'.tr(), subtitle: 'mobile.notif.paymentReceivedDesc'.tr(), time: 'mobile.auto.time_15m'.tr(), unread: true),
      _NotifItem(icon: Icons.auto_awesome_rounded, color: Colors.amberAccent, title: 'mobile.notif.aiValuation'.tr(), subtitle: 'mobile.notif.aiValuationDesc'.tr(), time: 'mobile.auto.time_1h'.tr(), unread: true),
      _NotifItem(icon: Icons.engineering_rounded, color: Colors.orangeAccent, title: 'mobile.notif.maintenance'.tr(), subtitle: 'mobile.notif.maintenanceDesc'.tr(), time: 'mobile.auto.time_3h'.tr(), unread: false),
      _NotifItem(icon: Icons.people_rounded, color: Colors.cyanAccent, title: 'mobile.notif.newTenant'.tr(), subtitle: 'mobile.notif.newTenantDesc'.tr(), time: 'mobile.auto.time_6h'.tr(), unread: false),
      _NotifItem(icon: Icons.verified_rounded, color: Colors.purpleAccent, title: 'mobile.notif.contractSigned'.tr(), subtitle: 'mobile.notif.contractSignedDesc'.tr(), time: 'mobile.auto.time_1d'.tr(), unread: false),
      _NotifItem(icon: Icons.trending_up_rounded, color: Colors.tealAccent, title: 'mobile.notif.marketUpdate'.tr(), subtitle: 'mobile.notif.marketUpdateDesc'.tr(), time: 'mobile.auto.time_2d'.tr(), unread: false),
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.95),
            elevation: 0,
            toolbarHeight: 70,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mobile.notif.systemAlerts'.tr(),
                  style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary, letterSpacing: 2),
                ),
                Text(
                  'mobile.notif.title'.tr(),
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'mobile.notif.markAllRead'.tr(),
                  style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),

          // Unread count banner
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 8, 20, 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.15), AppColors.primary.withOpacity(0.05)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.notifications_active_rounded, color: AppColors.primary, size: 18),
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3 ${'mobile.notif.unread'.tr()}', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                      Text('mobile.notif.stayUpdated'.tr(), style: GoogleFonts.outfit(fontSize: 11, color: Colors.white38)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
          ),

          // Notification list
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notif = notifications[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: notif.unread ? AppColors.primary.withOpacity(0.06) : AppColors.darkCard,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: notif.unread ? AppColors.primary.withOpacity(0.15) : Colors.white.withOpacity(0.03)),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: notif.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(notif.icon, color: notif.color, size: 22),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(notif.title, style: GoogleFonts.outfit(fontSize: 14, fontWeight: notif.unread ? FontWeight.w800 : FontWeight.w600, color: Colors.white)),
                          ),
                          Text(notif.time, style: GoogleFonts.outfit(fontSize: 10, color: Colors.white30, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(notif.subtitle, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                      trailing: notif.unread
                          ? Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))
                          : null,
                    ),
                  ).animate().fadeIn(delay: (200 + index * 60).ms).slideX(begin: 0.05);
                },
                childCount: notifications.length,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}

class _NotifItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;
  final bool unread;
  _NotifItem({required this.icon, required this.color, required this.title, required this.subtitle, required this.time, required this.unread});
}
