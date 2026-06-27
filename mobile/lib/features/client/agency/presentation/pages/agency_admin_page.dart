import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/features/client/agency/presentation/providers/agency_provider.dart';

class AgencyAdminPage extends ConsumerWidget {
  const AgencyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: AppColors.darkBg,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('mobile.auto.agencies_management'.tr(),
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent.withOpacity(0.2), AppColors.darkBg],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ref.watch(agencyProvider).when(
                data: (agencies) {
                  if (agencies.isEmpty) {
                    return Center(
                      child: Text('mobile.auto.no_agencies_found'.tr(),
                        style: GoogleFonts.outfit(color: Colors.white54),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: agencies.length,
                    itemBuilder: (context, index) {
                      final a = agencies[index];
                      return Dismissible(
                        key: Key(a.id),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ref.read(agencyProvider.notifier).deleteAgency(a.id);
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.05),
                          margin: EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(a.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600)),
                            subtitle: Text(
                              a.email.isNotEmpty ? a.email : 'mobile.leftovers.no_email_provided'.tr(),
                              style: GoogleFonts.outfit(color: Colors.indigoAccent),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
                              child: Text(a.status, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10)),
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1);
                    },
                  );
                },
                loading: () => Center(
                  child: Text('mobile.auto.loading_agencies'.tr(),
                    style: GoogleFonts.outfit(color: Colors.white54),
                  ).animate().shimmer(duration: 2.seconds),
                ),
                error: (err, _) => Center(
                  child: Text(
                    '${'admin.shared.connectionError'.tr()}: $err',
                    style: GoogleFonts.outfit(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () => _showAddDialog(context, ref),
        child: Icon(Icons.add, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkBg,
        title: Text('mobile.auto.new_agency'.tr(), style: GoogleFonts.outfit(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.agency_name'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            TextField(
              controller: emailCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.email_address'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            TextField(
              controller: phoneCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.phone_number'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('mobile.auto.cancel'.tr(), style: GoogleFonts.outfit(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                ref.read(agencyProvider.notifier).createAgency(
                  nameCtrl.text, emailCtrl.text, phoneCtrl.text
                );
                Navigator.pop(ctx);
              }
            },
            child: Text('mobile.auto.create'.tr(), style: GoogleFonts.outfit(color: Colors.indigoAccent)),
          ),
        ],
      ),
    );
  }
}
