import 'package:flutter/material.dart';

// ================================================================
// Home Admin Page  |  Dashboard overview for administrators
// ================================================================

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key? key}) : super(key: key);

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.account_circle_outlined), onPressed: () {}),
        ],
      ),
      drawer: _buildDrawer(),
      body: _getBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.home_work), label: 'Properties'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Users'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey[800]),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(radius: 28, backgroundColor: Colors.white24,
                    child: Icon(Icons.admin_panel_settings, size: 28, color: Colors.white)),
                SizedBox(height: 10),
                Text('Admin Panel', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Management Console', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), onTap: () {}),
          ListTile(leading: const Icon(Icons.home_work), title: const Text('Properties'), onTap: () {}),
          ListTile(leading: const Icon(Icons.people), title: const Text('Users'), onTap: () {}),
          ListTile(leading: const Icon(Icons.receipt_long), title: const Text('Financial Records'), onTap: () {}),
          ListTile(leading: const Icon(Icons.assignment), title: const Text('Leases'), onTap: () {}),
          ListTile(leading: const Icon(Icons.star_rate), title: const Text('Reviews'), onTap: () {}),
          const Divider(),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () {}),
          ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () {}),
        ],
      ),
    );
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0: return _buildDashboardTab();
      case 1: return const Center(child: Text('Properties'));
      case 2: return const Center(child: Text('Users'));
      case 3: return const Center(child: Text('Reports'));
      default: return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // KPI Stats
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildStatCard('Properties', '248', Icons.home_work, Colors.blue),
              _buildStatCard('Active Leases', '187', Icons.assignment, Colors.green),
              _buildStatCard('Pending Tasks', '34', Icons.pending_actions, Colors.orange),
              _buildStatCard('Revenue MTD', '\$84K', Icons.attach_money, Colors.purple),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Recent Activity
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('View All')),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(5, (i) => _buildActivityItem(i)),
        const SizedBox(height: 24),

        // Quick Actions
        Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12, crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _buildActionCard('Add Property', Icons.add_home, Colors.blue),
            _buildActionCard('New Lease', Icons.add_task, Colors.green),
            _buildActionCard('Run Report', Icons.bar_chart, Colors.orange),
            _buildActionCard('Manage Users', Icons.person_add, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(int index) {
    final icons = [Icons.person_add, Icons.home, Icons.receipt, Icons.star, Icons.assignment];
    final labels = ['New user registered', 'Property listed', 'Invoice paid', 'Review received', 'Lease signed'];
    final times = ['2m ago', '15m ago', '1h ago', '3h ago', '1d ago'];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey[50],
        child: Icon(icons[index], size: 18, color: Colors.blueGrey[600]),
      ),
      title: Text(labels[index], style: const TextStyle(fontSize: 14)),
      trailing: Text(times[index], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
    );
  }

  Widget _buildActionCard(String label, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
