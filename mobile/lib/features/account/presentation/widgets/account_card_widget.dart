import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';
import 'package:intl/intl.dart';

/// Widget to display account information in a card format
class AccountCardWidget extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onActivate;
  final VoidCallback? onDeactivate;
  final VoidCallback? onRefreshToken;

  const AccountCardWidget({
    Key? key,
    required this.account,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onActivate,
    this.onDeactivate,
    this.onRefreshToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = account.isActive ?? false;
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with provider and status
              Row(
                children: [
                  // Provider Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getProviderColor(account.providerId).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getProviderIcon(account.providerId),
                      color: _getProviderColor(account.providerId),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Provider name and type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatProviderName(account.providerId),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account.type?.name ?? 'Unknown',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? Colors.green.withOpacity(0.1) 
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        color: isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              
              // Account details
              _buildDetailRow(
                context,
                icon: Icons.fingerprint,
                label: 'Account ID',
                value: account.accountId ?? 'N/A',
              ),
              const SizedBox(height: 8),
              _buildDetailRow(
                context,
                icon: Icons.vpn_key,
                label: 'Token Type',
                value: account.tokenType ?? 'N/A',
              ),
              if (account.scope != null) ...[
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  icon: Icons.security,
                  label: 'Scope',
                  value: account.scope!,
                ),
              ],
              if (account.accessTokenExpiresAt != null) ...[
                const SizedBox(height: 8),
                _buildDetailRow(
                  context,
                  icon: Icons.access_time,
                  label: 'Token Expires',
                  value: _formatDateTime(account.accessTokenExpiresAt),
                  valueColor: _isTokenExpired(account.accessTokenExpiresAt) 
                      ? Colors.red 
                      : null,
                ),
              ],
              
              const SizedBox(height: 16),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isActive && onActivate != null)
                    TextButton.icon(
                      onPressed: onActivate,
                      icon: const Icon(Icons.check_circle, size: 18),
                      label: const Text('Activate'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                    ),
                  if (isActive && onDeactivate != null)
                    TextButton.icon(
                      onPressed: onDeactivate,
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Deactivate'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.orange,
                      ),
                    ),
                  if (onRefreshToken != null)
                    TextButton.icon(
                      onPressed: onRefreshToken,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Refresh'),
                    ),
                  if (onEdit != null)
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit',
                    ),
                  if (onDelete != null)
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      tooltip: 'Delete',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: valueColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData _getProviderIcon(String? providerId) {
    if (providerId == null) return Icons.cloud;
    
    final provider = providerId.toLowerCase();
    if (provider.contains('google')) return Icons.g_mobiledata;
    if (provider.contains('facebook')) return Icons.facebook;
    if (provider.contains('twitter')) return Icons.flutter_dash;
    if (provider.contains('github')) return Icons.code;
    if (provider.contains('linkedin')) return Icons.business;
    if (provider.contains('microsoft')) return Icons.window;
    
    return Icons.account_circle;
  }

  Color _getProviderColor(String? providerId) {
    if (providerId == null) return Colors.grey;
    
    final provider = providerId.toLowerCase();
    if (provider.contains('google')) return Colors.red;
    if (provider.contains('facebook')) return Colors.blue;
    if (provider.contains('twitter')) return Colors.lightBlue;
    if (provider.contains('github')) return Colors.black;
    if (provider.contains('linkedin')) return const Color(0xFF0077B5);
    if (provider.contains('microsoft')) return const Color(0xFF00A4EF);
    
    return Colors.grey;
  }

  String _formatProviderName(String? providerId) {
    if (providerId == null) return 'Unknown Provider';
    
    // Capitalize first letter
    return providerId.substring(0, 1).toUpperCase() + 
           providerId.substring(1);
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    
    final now = DateTime.now();
    final difference = dateTime.difference(now);
    
    if (difference.isNegative) {
      return 'Expired ${DateFormat('MMM dd, yyyy').format(dateTime)}';
    } else if (difference.inDays > 7) {
      return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
    } else if (difference.inDays > 0) {
      return 'In ${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return 'In ${difference.inHours} hours';
    } else {
      return 'In ${difference.inMinutes} minutes';
    }
  }

  bool _isTokenExpired(DateTime? expiresAt) {
    if (expiresAt == null) return false;
    return expiresAt.isBefore(DateTime.now());
  }
}
