import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/account_provider.dart';
import 'account_form_page.dart';
import 'package:intl/intl.dart';

/// Page to display account details
class AccountDetailPage extends ConsumerWidget {
  final String accountId;

  const AccountDetailPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAsync = ref.watch(accountByIdProvider(accountId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
        actions: [
          accountAsync.when(
            data: (account) => PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'refresh',
                  child: ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text('Refresh Token'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: account.isActive == true ? 'deactivate' : 'activate',
                  child: ListTile(
                    leading: Icon(
                      account.isActive == true ? Icons.cancel : Icons.check_circle,
                    ),
                    title: Text(account.isActive == true ? 'Deactivate' : 'Activate'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItemDivider(),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Delete', style: TextStyle(color: Colors.red)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              onSelected: (value) => _handleMenuAction(context, ref, value.toString(), account.id),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: accountAsync.when(
        data: (account) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(accountByIdProvider(accountId));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: _getProviderColor(account.providerId).withOpacity(0.2),
                          child: Icon(
                            _getProviderIcon(account.providerId),
                            size: 40,
                            color: _getProviderColor(account.providerId),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _formatProviderName(account.providerId),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(account.type?.name ?? 'Unknown'),
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(account.isActive == true ? 'Active' : 'Inactive'),
                          backgroundColor: account.isActive == true 
                              ? Colors.green.withOpacity(0.2)
                              : Colors.red.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: account.isActive == true ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Account Information
                _buildSection(
                  context,
                  title: 'Account Information',
                  children: [
                    _buildDetailTile(
                      context,
                      icon: Icons.fingerprint,
                      label: 'Account ID',
                      value: account.accountId ?? 'N/A',
                      copyable: true,
                    ),
                    _buildDetailTile(
                      context,
                      icon: Icons.vpn_key,
                      label: 'Provider ID',
                      value: account.providerId ?? 'N/A',
                    ),
                    _buildDetailTile(
                      context,
                      icon: Icons.person,
                      label: 'User ID',
                      value: account.userId ?? 'N/A',
                      copyable: true,
                    ),
                    if (account.scope != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.security,
                        label: 'Scope',
                        value: account.scope!,
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Token Information
                _buildSection(
                  context,
                  title: 'Token Information',
                  children: [
                    if (account.accessToken != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.key,
                        label: 'Access Token',
                        value: '${account.accessToken!.substring(0, 20)}...',
                        copyable: true,
                        fullValue: account.accessToken,
                      ),
                    if (account.refreshToken != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.refresh,
                        label: 'Refresh Token',
                        value: '${account.refreshToken!.substring(0, 20)}...',
                        copyable: true,
                        fullValue: account.refreshToken,
                      ),
                    if (account.tokenType != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.label,
                        label: 'Token Type',
                        value: account.tokenType!,
                      ),
                    if (account.accessTokenExpiresAt != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.access_time,
                        label: 'Access Token Expires',
                        value: DateFormat('MMM dd, yyyy HH:mm').format(account.accessTokenExpiresAt!),
                        valueColor: account.accessTokenExpiresAt!.isBefore(DateTime.now())
                            ? Colors.red
                            : null,
                      ),
                    if (account.refreshTokenExpiresAt != null)
                      _buildDetailTile(
                        context,
                        icon: Icons.access_time,
                        label: 'Refresh Token Expires',
                        value: DateFormat('MMM dd, yyyy HH:mm').format(account.refreshTokenExpiresAt!),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Metadata
                _buildSection(
                  context,
                  title: 'Metadata',
                  children: [
                    _buildDetailTile(
                      context,
                      icon: Icons.calendar_today,
                      label: 'Created At',
                      value: DateFormat('MMM dd, yyyy HH:mm').format(account.createdAt),
                    ),
                    _buildDetailTile(
                      context,
                      icon: Icons.update,
                      label: 'Updated At',
                      value: DateFormat('MMM dd, yyyy HH:mm').format(account.updatedAt),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(accountByIdProvider(accountId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool copyable = false,
    String? fullValue,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: valueColor,
                      ),
                ),
              ],
            ),
          ),
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: fullValue ?? value));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              },
            ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, WidgetRef ref, String action, String id) async {
    switch (action) {
      case 'edit':
        final account = await ref.read(accountByIdProvider(id).future);
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountFormPage(account: account),
            ),
          );
        }
        break;
      case 'refresh':
        final success = await ref.read(accountProvider.notifier).refreshToken(id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(success ? 'Token refreshed' : 'Failed to refresh token'),
            ),
          );
        }
        break;
      case 'activate':
        await ref.read(accountProvider.notifier).activateAccount(id);
        ref.invalidate(accountByIdProvider(id));
        break;
      case 'deactivate':
        await ref.read(accountProvider.notifier).deactivateAccount(id);
        ref.invalidate(accountByIdProvider(id));
        break;
      case 'delete':
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text('Are you sure you want to delete this account?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        
        if (confirmed == true) {
          final success = await ref.read(accountProvider.notifier).deleteAccount(id);
          if (context.mounted) {
            if (success) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deleted')),
              );
            }
          }
        }
        break;
    }
  }

  IconData _getProviderIcon(String? providerId) {
    if (providerId == null) return Icons.cloud;
    final provider = providerId.toLowerCase();
    if (provider.contains('google')) return Icons.g_mobiledata;
    if (provider.contains('facebook')) return Icons.facebook;
    if (provider.contains('github')) return Icons.code;
    return Icons.account_circle;
  }

  Color _getProviderColor(String? providerId) {
    if (providerId == null) return Colors.grey;
    final provider = providerId.toLowerCase();
    if (provider.contains('google')) return Colors.red;
    if (provider.contains('facebook')) return Colors.blue;
    if (provider.contains('github')) return Colors.black;
    return Colors.grey;
  }

  String _formatProviderName(String? providerId) {
    if (providerId == null) return 'Unknown Provider';
    return providerId.substring(0, 1).toUpperCase() + providerId.substring(1);
  }
}
