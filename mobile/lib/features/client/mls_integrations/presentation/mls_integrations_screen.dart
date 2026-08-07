import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// MLS Integrations — connection status + sync controls
// ---------------------------------------------------------------------------

enum _MlsStatus { connected, syncing, error, disconnected }

class _MlsProvider {
  final String id;
  final String name;
  final String region;
  final _MlsStatus status;
  final String lastSync;
  final int listingsCount;
  final bool autoSync;
  final IconData icon;

  const _MlsProvider({
    required this.id,
    required this.name,
    required this.region,
    required this.status,
    required this.lastSync,
    required this.listingsCount,
    required this.autoSync,
    required this.icon,
  });
}

final _mlsProvidersProvider =
    StateNotifierProvider<_MlsNotifier, List<_MlsProvider>>(
  (ref) => _MlsNotifier(),
);

class _MlsNotifier extends StateNotifier<List<_MlsProvider>> {
  _MlsNotifier()
      : super([
          _MlsProvider(
            id: '1',
            name: 'NWMLS',
            region: 'Northwest (US)',
            status: _MlsStatus.connected,
            lastSync: '5 min ago',
            listingsCount: 1243,
            autoSync: true,
            icon: Icons.cloud_done_outlined,
          ),
          _MlsProvider(
            id: '2',
            name: 'CRMLS',
            region: 'California (US)',
            status: _MlsStatus.syncing,
            lastSync: 'Syncing…',
            listingsCount: 882,
            autoSync: true,
            icon: Icons.sync,
          ),
          _MlsProvider(
            id: '3',
            name: 'TREB',
            region: 'Toronto, Canada',
            status: _MlsStatus.error,
            lastSync: '2 days ago',
            listingsCount: 0,
            autoSync: false,
            icon: Icons.cloud_off_outlined,
          ),
          _MlsProvider(
            id: '4',
            name: 'Rightmove API',
            region: 'United Kingdom',
            status: _MlsStatus.connected,
            lastSync: '1 hr ago',
            listingsCount: 4510,
            autoSync: true,
            icon: Icons.cloud_done_outlined,
          ),
          _MlsProvider(
            id: '5',
            name: 'EmlakJet',
            region: 'Turkey',
            status: _MlsStatus.disconnected,
            lastSync: 'Never',
            listingsCount: 0,
            autoSync: false,
            icon: Icons.link_off,
          ),
        ]);

  void toggleAutoSync(String id) {
    state = [
      for (final p in state)
        if (p.id == id)
          _MlsProvider(
            id: p.id,
            name: p.name,
            region: p.region,
            status: p.status,
            lastSync: p.lastSync,
            listingsCount: p.listingsCount,
            autoSync: !p.autoSync,
            icon: p.icon,
          )
        else
          p,
    ];
  }
}

class MlsIntegrationsScreen extends ConsumerWidget {
  const MlsIntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(_mlsProvidersProvider);
    final connected = providers.where((p) => p.status == _MlsStatus.connected).length;
    final totalListings = providers.fold(0, (sum, p) => sum + p.listingsCount);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'MLS Integrations',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add_link, color: AppColors.primary),
                tooltip: 'Add MLS',
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // KPI row
                Row(children: [
                  _KpiCard(
                    label: 'Connected',
                    value: '$connected / ${providers.length}',
                    icon: Icons.cloud_done_outlined,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  _KpiCard(
                    label: 'Total Listings',
                    value: totalListings.toString(),
                    icon: Icons.home_work_outlined,
                    color: AppColors.primary,
                  ),
                ]),
                const SizedBox(height: 24),
                Text(
                  'Providers',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                ...providers.map(
                  (p) => _ProviderCard(
                    provider: p,
                    onToggleAutoSync: () => ref
                        .read(_mlsProvidersProvider.notifier)
                        .toggleAutoSync(p.id),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _KpiCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Text(label,
                style: GoogleFonts.outfit(
                    color: Colors.white38, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  final _MlsProvider provider;
  final VoidCallback onToggleAutoSync;
  const _ProviderCard(
      {required this.provider, required this.onToggleAutoSync});

  Color get _statusColor {
    switch (provider.status) {
      case _MlsStatus.connected:
        return AppColors.success;
      case _MlsStatus.syncing:
        return AppColors.info;
      case _MlsStatus.error:
        return AppColors.error;
      case _MlsStatus.disconnected:
        return Colors.white38;
    }
  }

  String get _statusLabel {
    switch (provider.status) {
      case _MlsStatus.connected:
        return 'Connected';
      case _MlsStatus.syncing:
        return 'Syncing';
      case _MlsStatus.error:
        return 'Error';
      case _MlsStatus.disconnected:
        return 'Disconnected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(provider.icon, color: _statusColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.name,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      provider.region,
                      style: GoogleFonts.outfit(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: _statusColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  _statusLabel,
                  style: GoogleFonts.outfit(
                    color: _statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.home_outlined, color: Colors.white38, size: 14),
              const SizedBox(width: 4),
              Text(
                '${provider.listingsCount} listings',
                style:
                    GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, color: Colors.white38, size: 14),
              const SizedBox(width: 4),
              Text(
                provider.lastSync,
                style:
                    GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Auto-sync',
                style:
                    GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(width: 6),
              Switch.adaptive(
                value: provider.autoSync,
                onChanged: (_) => onToggleAutoSync(),
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
