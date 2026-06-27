import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:reservatior/core/providers/admin/lease_provider.dart';
import 'package:reservatior/shared/models/lease.dart';

class LeaseManagementScreen extends ConsumerWidget {
  const LeaseManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leasesAsync = ref.watch(leaseListProvider);

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
                    'mobile.admin.lease.title'.tr(),
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
              child: leasesAsync.when(
                data: (leases) => _buildGlassCard(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        const Color(0xFFD4AF37).withOpacity(0.1),
                      ),
                      columns: [
                        DataColumn(
                          label: Text(
                            'mobile.admin.lease.status'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.lease.rent'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.lease.start_date'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'mobile.admin.lease.end_date'.tr(),
                            style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: leases.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                item.status.name,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                "\${item.rent} \${item.currency}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.startDate.toLocal().toString().split(
                                  " ",
                                )[0],
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                            DataCell(
                              Text(
                                item.endDate.toLocal().toString().split(" ")[0],
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
                    'mobile.admin.lease.error_loading'.tr(),
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
          // Add new lease action
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
