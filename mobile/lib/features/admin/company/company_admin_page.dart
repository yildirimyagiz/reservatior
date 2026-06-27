import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/organization_provider.dart';

class CompanyAdminPage extends ConsumerWidget {
  const CompanyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurpleAccent.withValues(alpha: 0.04),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mobile.auto.admin_company_enterprise'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                      Text(
                        'mobile.auto.admin_company_title'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ref
                      .watch(organizationListProvider)
                      .when(
                        data: (orgs) {
                          if (orgs.isEmpty) {
                            return Center(
                              child: Text(
                                'mobile.auto.admin_company_empty'.tr(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orgs.length,
                            itemBuilder: (context, index) {
                              final o = orgs[index];
                              return Card(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    margin: EdgeInsets.only(bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.deepPurpleAccent
                                            .withValues(alpha: 0.15),
                                        child: Icon(
                                          Icons.business,
                                          color: Colors.deepPurpleAccent,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        o.name,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        o.contactEmail ?? o.defaultCurrency,
                                        style: GoogleFonts.outfit(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          o.defaultLocale,
                                          style: GoogleFonts.outfit(
                                            color: Colors.deepPurpleAccent,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(delay: (100 * index).ms)
                                  .slideX(begin: 0.1);
                            },
                          );
                        },
                        loading: () => Center(
                          child: Text(
                            'mobile.auto.admin_company_loading'.tr(),
                            style: GoogleFonts.outfit(color: Colors.white54),
                          ).animate().shimmer(duration: 2.seconds),
                        ),
                        error: (err, _) => Center(
                          child: Text(
                            '${'admin.error.connection'.tr()}: $err',
                            style: GoogleFonts.outfit(color: Colors.redAccent),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => _showAddDialog(context, ref),
        child: Icon(Icons.business, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final slugCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkBg,
        title: Text(
          'mobile.auto.admin_company_addorg'.tr(),
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.admin_company_orgname'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            TextField(
              controller: slugCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.admin_company_slug'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'mobile.auto.admin_action_cancel'.tr(),
              style: GoogleFonts.outfit(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                ref.invalidate(organizationListProvider);
                Navigator.pop(ctx);
              }
            },
            child: Text(
              'mobile.auto.admin_action_create'.tr(),
              style: GoogleFonts.outfit(color: Colors.deepPurpleAccent),
            ),
          ),
        ],
      ),
    );
  }
}
