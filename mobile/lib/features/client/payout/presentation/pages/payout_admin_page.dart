import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reservatior/shared/providers/payout_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/payout/presentation/widgets/payout_list_widget.dart';
import 'package:reservatior/features/client/payout/presentation/widgets/payout_form_widget.dart';

class PayoutAdminPage extends ConsumerWidget {
  const PayoutAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final itemsAsync = ref.watch(payoutListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('mobile.auto.payout_center'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
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
                    padding: const EdgeInsets.only(bottom: 100),
                    sliver: SliverToBoxAdapter(
                      child: RefreshIndicator(
                        backgroundColor: AppColors.darkSurface,
                        color: AppColors.primary,
                        onRefresh: () async => ref.refresh(payoutListProvider),
                        child: PayoutListWidget(
                          items: filteredData as List<Payout>,
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
                          Icons.error_outline,
                          color: AppColors.primary,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sync Error: $e',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        TextButton(
                          onPressed: () => ref.refresh(payoutListProvider),
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
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          onPressed: () => _showForm(context, ref),
          icon: const Icon(Icons.receipt_long_rounded, color: Colors.white),
          label: Text('mobile.auto.new_payout'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {Payout? item}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: PayoutFormWidget(
          item: item,
          onSubmit: (val) {
            if (item == null)
              ref.read(payoutCreateProvider.notifier).state = val;
            else
              ref.read(payoutUpdateProvider.notifier).state = {
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
