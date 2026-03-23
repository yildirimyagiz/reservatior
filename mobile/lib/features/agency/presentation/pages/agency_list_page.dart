import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/providers.dart';
import 'agency_admin_page.dart';

/// Agency List Page - Browse all agencies
class AgencyListPage extends ConsumerStatefulWidget {
  const AgencyListPage({super.key});

  @override
  ConsumerState<AgencyListPage> createState() => _AgencyListPageState();
}

class _AgencyListPageState extends ConsumerState<AgencyListPage> {
  @override
  Widget build(BuildContext context) {
    final agenciesAsync = ref.watch(agencyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agencies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: agenciesAsync.when(
        data: (agencies) {
          if (agencies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.business_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No agencies found',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: agencies.length,
            itemBuilder: (context, index) {
              final agency = agencies[index];
              return _buildAgencyCard(context, agency);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(agencyListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgencyAdminPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New Agency'),
      ),
    );
  }

  Widget _buildAgencyCard(BuildContext context, dynamic agency) {
    final theme = Theme.of(context);
    final name = agency.name ?? 'Unnamed Agency';
    final totalProperties = agency.totalProperties ?? 0;
    final totalAgents = agency.totalAgents ?? 0;
    final isActive = agency.isActive ?? false;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgencyAdminPage(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with logo/icon
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
              ),
              child: Center(
                child: agency.logoUrl != null
                    ? Image.network(
                        agency.logoUrl!,
                        height: 60,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.business,
                          size: 48,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.business,
                        size: 48,
                        color: Colors.white,
                      ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Stats
                  Row(
                    children: [
                      Icon(Icons.home, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '$totalProperties',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.people, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '$totalAgents',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isActive ? 'Active' : 'Inactive',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
