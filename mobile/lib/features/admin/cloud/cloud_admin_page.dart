import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/system_metrics_provider.dart';
import 'package:reservatior/shared/providers/health_check_provider.dart';

class CloudAdminPage extends ConsumerWidget {
  const CloudAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withOpacity(0.04),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.darkBg.withOpacity(0.8),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mobile.auto.admin_cloud_infrastructure'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                      Text(
                        'mobile.auto.admin_cloud_title'.tr(),
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

              // Health Check Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    'mobile.auto.admin_cloud_healthchecks'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ref
                      .watch(healthCheckListProvider)
                      .when(
                        data: (checks) {
                          if (checks.isEmpty) {
                            return Center(
                              child: Text(
                                'mobile.auto.admin_cloud_nochecks'.tr(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: checks.length,
                            itemBuilder: (context, index) {
                              final c = checks[index];
                              final isHealthy = c.status == 'HEALTHY';
                              return Card(
                                    color: Colors.white.withOpacity(0.05),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: isHealthy
                                            ? Colors.greenAccent.withOpacity(
                                                0.15,
                                              )
                                            : Colors.redAccent.withOpacity(
                                                0.15,
                                              ),
                                        child: Icon(
                                          isHealthy
                                              ? Icons.check_circle
                                              : Icons.warning,
                                          color: isHealthy
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        c.serviceName,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${c.responseTime ?? 0}ms • ${c.status}',
                                        style: GoogleFonts.outfit(
                                          color: isHealthy
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isHealthy
                                              ? Colors.greenAccent.withOpacity(
                                                  0.1,
                                                )
                                              : Colors.redAccent.withOpacity(
                                                  0.1,
                                                ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          isHealthy
                                              ? 'admin.cloud.online'.tr()
                                              : 'admin.cloud.offline'.tr(),
                                          style: GoogleFonts.outfit(
                                            color: isHealthy
                                                ? Colors.greenAccent
                                                : Colors.redAccent,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(delay: (80 * index).ms)
                                  .slideX(begin: 0.1);
                            },
                          );
                        },
                        loading: () => Center(
                          child: Text(
                            'mobile.auto.admin_cloud_scanning'.tr(),
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

              // System Metrics Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Text(
                    'mobile.auto.admin_cloud_systemmetrics'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ref
                      .watch(systemMetricsListProvider)
                      .when(
                        data: (metrics) {
                          if (metrics.isEmpty) {
                            return Center(
                              child: Text(
                                'mobile.auto.admin_cloud_nometrics'.tr(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: metrics.length,
                            itemBuilder: (context, index) {
                              final m = metrics[index];
                              return Card(
                                    color: Colors.white.withOpacity(0.05),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.cyanAccent
                                            .withOpacity(0.15),
                                        child: const Icon(
                                          Icons.analytics,
                                          color: Colors.cyanAccent,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        m.metricName,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${m.value} ${m.unit}',
                                        style: GoogleFonts.outfit(
                                          color: Colors.cyanAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(delay: (80 * index).ms)
                                  .slideX(begin: 0.1);
                            },
                          );
                        },
                        loading: () => Center(
                          child: Text(
                            'mobile.auto.admin_cloud_metricsloading'.tr(),
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

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {
          ref.invalidate(healthCheckListProvider);
          ref.invalidate(systemMetricsListProvider);
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }
}
