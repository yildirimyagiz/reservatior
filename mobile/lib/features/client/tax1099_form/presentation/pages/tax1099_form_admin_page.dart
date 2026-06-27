import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reservatior/shared/providers/tax1099_form_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/tax1099_form/presentation/widgets/tax1099_form_list_widget.dart';
import 'package:reservatior/features/client/tax1099_form/presentation/widgets/tax1099_form_form_widget.dart';

class Tax1099FormAdminPage extends ConsumerWidget {
  const Tax1099FormAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final itemsAsync = ref.watch(tax1099FormListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text('mobile.auto.feature_tax1099form_title'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: itemsAsync.when(
        data: (data) {
          final filteredData = user?.organizationId != null
              ? data.where((item) {
                  try {
                    return (item as dynamic).orgId == user!.organizationId;
                  } catch (_) {
                    return true;
                  }
                }).toList()
              : data;

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(tax1099FormListProvider),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Tax1099FormListWidget(
                items: filteredData as List<Tax1099Form>,
              ),
            ),
          );
        },
        loading: () => SingleChildScrollView(
          child: Column(
            children: List.generate(8, (index) => const _ShimmerItem()),
          ),
        ),
        error: (e, s) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              SizedBox(height: 16),
              Text(
                '${'admin.shared.connectionError'.tr()}: $e',
                style: const TextStyle(color: AppColors.textSecondaryDark),
              ),
              TextButton(
                onPressed: () => ref.refresh(tax1099FormListProvider),
                child: Text('mobile.auto.admin_shared_retry'.tr()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: () => _showForm(context, ref),
        child: const Icon(Icons.add, color: AppColors.darkBg),
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {Tax1099Form? item}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Tax1099FormFormWidget(
          item: item,
          onSubmit: (val) {
            if (item == null)
              ref.read(tax1099FormCreateProvider.notifier).state = val;
            else
              ref.read(tax1099FormUpdateProvider.notifier).state = {
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
