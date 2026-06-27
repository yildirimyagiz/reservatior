import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/appointment_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/appointment/presentation/widgets/appointment_list_widget.dart';
import 'package:reservatior/features/client/appointment/presentation/widgets/appointment_form_widget.dart';

class AppointmentAdminPage extends ConsumerWidget {
  const AppointmentAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final itemsAsync = ref.watch(appointmentListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Neural Background Glow
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.05),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 140,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('mobile.auto.neural_booking'.tr(),
                        style: GoogleFonts.outfit(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                      Text('mobile.auto.appointment_center'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              itemsAsync.when(
                data: (data) {
                  final filteredData = user?.organizationId != null
                      ? data.where((item) {
                          try {
                            return (item as dynamic).orgId ==
                                user!.organizationId;
                          } catch (_) {
                            return true;
                          }
                        }).toList()
                      : data;

                  return SliverPadding(
                    padding: const EdgeInsets.only(bottom: 120),
                    sliver: SliverToBoxAdapter(
                      child: RefreshIndicator(
                        backgroundColor: AppColors.darkSurface,
                        color: AppColors.gold,
                        onRefresh: () async =>
                            ref.refresh(appointmentListProvider),
                        child: AppointmentListWidget(
                          items: filteredData as List<Appointment>,
                        ),
                      ),
                    ),
                  );
                },
                loading: () => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const _ShimmerItem(),
                    childCount: 8,
                  ),
                ),
                error: (e, s) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          color: AppColors.gold,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Calendar Sync Error: $e',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        TextButton(
                          onPressed: () => ref.refresh(appointmentListProvider),
                          child: Text('mobile.auto.admin_shared_retry'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.gold.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.gold,
          onPressed: () => _showForm(context, ref),
          icon: const Icon(Icons.add_task_rounded, color: AppColors.darkBg),
          label: Text('mobile.auto.schedule_now'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBg,
            ),
          ),
        ),
      ).animate().slideY(begin: 1, end: 0, delay: 500.ms),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {Appointment? item}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: AppointmentFormWidget(
          item: item,
          onSubmit: (val) {
            if (item == null)
              ref.read(appointmentCreateProvider.notifier).state = val;
            else
              ref.read(appointmentUpdateProvider.notifier).state = {
                'id': item.id,
                'data': val,
              };
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white10,
        highlightColor: Colors.white24,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 120, height: 12, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(width: 80, height: 10, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
