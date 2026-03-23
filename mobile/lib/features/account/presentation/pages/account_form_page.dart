import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../shared/providers/account_provider.dart';

/// Page for creating or editing an account
class AccountFormPage extends ConsumerStatefulWidget {
  final Account? account;

  const AccountFormPage({
    Key? key,
    this.account,
  }) : super(key: key);

  @override
  ConsumerState<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends ConsumerState<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _providerIdController;
  late TextEditingController _accountIdController;
  late TextEditingController _userIdController;
  late TextEditingController _accessTokenController;
  late TextEditingController _refreshTokenController;
  late TextEditingController _tokenTypeController;
  late TextEditingController _scopeController;

  bool _isActive = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final account = widget.account;
    
    _providerIdController = TextEditingController(text: account?.providerId);
    _accountIdController = TextEditingController(text: account?.accountId);
    _userIdController = TextEditingController(text: account?.userId);
    _accessTokenController = TextEditingController(text: account?.accessToken);
    _refreshTokenController = TextEditingController(text: account?.refreshToken);
    _tokenTypeController = TextEditingController(text: account?.tokenType ?? 'Bearer');
    _scopeController = TextEditingController(text: account?.scope);
    _isActive = account?.isActive ?? true;
  }

  @override
  void dispose() {
    _providerIdController.dispose();
    _accountIdController.dispose();
    _userIdController.dispose();
    _accessTokenController.dispose();
    _refreshTokenController.dispose();
    _tokenTypeController.dispose();
    _scopeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.account != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Account' : 'Create Account'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Provider Information Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Provider Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _providerIdController,
                      decoration: const InputDecoration(
                        labelText: 'Provider ID *',
                        hintText: 'e.g., google, facebook, github',
                        prefixIcon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provider ID is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _accountIdController,
                      decoration: const InputDecoration(
                        labelText: 'Account ID',
                        hintText: 'External account identifier',
                        prefixIcon: Icon(Icons.fingerprint),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _userIdController,
                      decoration: const InputDecoration(
                        labelText: 'User ID *',
                        hintText: 'Internal user identifier',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User ID is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Token Information Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Token Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _accessTokenController,
                      decoration: const InputDecoration(
                        labelText: 'Access Token',
                        hintText: 'OAuth access token',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _refreshTokenController,
                      decoration: const InputDecoration(
                        labelText: 'Refresh Token',
                        hintText: 'OAuth refresh token',
                        prefixIcon: Icon(Icons.refresh),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tokenTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Token Type',
                        hintText: 'e.g., Bearer',
                        prefixIcon: Icon(Icons.label),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _scopeController,
                      decoration: const InputDecoration(
                        labelText: 'Scope',
                        hintText: 'OAuth scopes (space-separated)',
                        prefixIcon: Icon(Icons.security),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Status Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Status',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Active'),
                      subtitle: Text(
                        _isActive 
                            ? 'Account is currently active' 
                            : 'Account is currently inactive',
                      ),
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                      secondary: Icon(
                        _isActive ? Icons.check_circle : Icons.cancel,
                        color: _isActive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        isEditing ? 'Update Account' : 'Create Account',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),

            if (isEditing) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : () => _deleteAccount(context),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final account = Account(
        id: widget.account?.id ?? '',
        userId: _userIdController.text.trim(),
        providerId: _providerIdController.text.trim(),
        accountId: _accountIdController.text.trim().isEmpty 
            ? null 
            : _accountIdController.text.trim(),
        type: null, // You might want to add a dropdown for this
        accessToken: _accessTokenController.text.trim().isEmpty 
            ? null 
            : _accessTokenController.text.trim(),
        refreshToken: _refreshTokenController.text.trim().isEmpty 
            ? null 
            : _refreshTokenController.text.trim(),
        tokenType: _tokenTypeController.text.trim().isEmpty 
            ? null 
            : _tokenTypeController.text.trim(),
        scope: _scopeController.text.trim().isEmpty 
            ? null 
            : _scopeController.text.trim(),
        accessTokenExpiresAt: null,
        refreshTokenExpiresAt: null,
        isActive: _isActive,
        createdAt: widget.account?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      bool success;
      if (widget.account != null) {
        // Update existing account
        success = await ref.read(accountProvider.notifier).updateAccount(
          widget.account!.id,
          account,
        );
      } else {
        // Create new account
        success = await ref.read(accountProvider.notifier).createAccount(account);
      }

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.account != null 
                    ? 'Account updated successfully' 
                    : 'Account created successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          final error = ref.read(accountErrorProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error ?? 'Failed to save account'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete this account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.account != null) {
      setState(() {
        _isSubmitting = true;
      });

      final success = await ref.read(accountProvider.notifier).deleteAccount(
        widget.account!.id,
      );

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete account'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }
}
