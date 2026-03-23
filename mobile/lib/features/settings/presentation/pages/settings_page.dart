import 'package:flutter/material.dart';

/// Settings Page - App settings and preferences
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Profile Section
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('John Doe'),
            subtitle: const Text('john@example.com'),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const Divider(),
          
          // Account Settings
          _buildSectionHeader(context, 'Account'),
          ListTile(leading: const Icon(Icons.person), title: const Text('Profile'), onTap: () {}),
          ListTile(leading: const Icon(Icons.security), title: const Text('Privacy & Security'), onTap: () {}),
          ListTile(leading: const Icon(Icons.payment), title: const Text('Payment Methods'), onTap: () {}),
          ListTile(leading: const Icon(Icons.subscriptions), title: const Text('Subscription'), onTap: () {}),
          const Divider(),
          
          // App Settings
          _buildSectionHeader(context, 'App Settings'),
          SwitchListTile(value: true, onChanged: (_) {}, title: const Text('Notifications'), secondary: const Icon(Icons.notifications)),
          SwitchListTile(value: false, onChanged: (_) {}, title: const Text('Dark Mode'), secondary: const Icon(Icons.dark_mode)),
          ListTile(leading: const Icon(Icons.language), title: const Text('Language'), subtitle: const Text('English'), onTap: () {}),
          ListTile(leading: const Icon(Icons.sync), title: const Text('Sync Settings'), onTap: () {}),
          const Divider(),
          
          // Support
          _buildSectionHeader(context, 'Support'),
          ListTile(leading: const Icon(Icons.help), title: const Text('Help & FAQ'), onTap: () {}),
          ListTile(leading: const Icon(Icons.contact_support), title: const Text('Contact Support'), onTap: () {}),
          ListTile(leading: const Icon(Icons.info), title: const Text('About'), onTap: () {}),
          const Divider(),
          
          // Danger Zone
          ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text('Logout', style: TextStyle(color: Colors.red)), onTap: () {}),
          ListTile(leading: const Icon(Icons.delete_forever, color: Colors.red), title: const Text('Delete Account', style: TextStyle(color: Colors.red)), onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[600], fontWeight: FontWeight.bold)),
    );
  }
}
