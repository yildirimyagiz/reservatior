import 'package:flutter/material.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/role_provider.dart';
import 'dart:ui' as ui;

class RolesAdminPage extends ConsumerWidget {
  const RolesAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withValues(alpha: 0.04),
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
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mobile.auto.admin_roles_accesscontrol'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                      Text(
                        'mobile.auto.admin_roles_title'.tr(),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: ref
                      .watch(roleListProvider)
                      .when(
                        data: (roles) {
                          if (roles.isEmpty) {
                            return Center(
                              child: Text(
                                'mobile.auto.admin_roles_empty'.tr(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: roles.length,
                            itemBuilder: (context, index) {
                              final r = roles[index];
                              return Card(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.redAccent
                                            .withValues(alpha: 0.15),
                                        child: const Icon(
                                          Icons.shield,
                                          color: Colors.redAccent,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        r.role.name,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${r.permissions.length} ${'admin.roles.permissions'.tr()}',
                                        style: GoogleFonts.outfit(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.chevron_right,
                                        color: Colors.white24,
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
                            'mobile.auto.admin_roles_loading'.tr(),
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
        backgroundColor: Colors.redAccent,
        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
        child: const Icon(Icons.shield, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }
}
