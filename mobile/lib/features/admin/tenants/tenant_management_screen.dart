import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:reservatior/core/providers/admin/tenant_provider.dart';
import 'package:reservatior/shared/models/tenant.dart';

class TenantManagementScreen extends ConsumerWidget {
  const TenantManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantsAsync = ref.watch(tenantListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A1A).withOpacity(0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  title: Text(
                    'mobile.admin.tenant.title'.tr(),
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFD4AF37).withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: tenantsAsync.when(
                data: (tenants) => _buildGlassCard(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        const Color(0xFFD4AF37).withOpacity(0.1),
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'mobile.admin.tenant.first_name'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.tenant.last_name'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.tenant.email'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.tenant.payment_status'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.tenant.created'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: tenants.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                item.firstName,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.lastName,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.email,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.paymentStatus.name,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.createdAt.toLocal().toString().split(
                                  " ",
                                )[0],
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFD4AF37),
                    ),
                  ),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'mobile.admin.tenant.error_loading'.tr(),
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new tenant action
        },
        backgroundColor: const Color(0xFFD4AF37),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}
