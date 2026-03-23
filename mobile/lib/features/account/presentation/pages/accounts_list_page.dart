import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/account_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/account_card_widget.dart';
import 'account_detail_page.dart';
import 'account_form_page.dart';

/// Page to display list of accounts
class AccountsListPage extends ConsumerStatefulWidget {
  const AccountsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountsListPage> createState() => _AccountsListPageState();
}

class _AccountsListPageState extends ConsumerState<AccountsListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(accountListProvider.notifier).loadAccounts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.8) {
      // Load more when scrolled 80% down
      ref.read(accountListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountListState = ref.watch(accountListProvider);
    final isLoading = ref.watch(accountLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search accounts...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    ref.read(accountListProvider.notifier).searchAccounts(query);
                  }
                },
              )
            : const Text('Accounts'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  ref.read(accountListProvider.notifier).refresh();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(accountListProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: accountListState.when(
        initial: () => const Center(
          child: Text('Pull to refresh'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (accounts, currentPage, hasMore, total) {
          if (accounts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No accounts found',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first account to get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(accountListProvider.notifier).refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: accounts.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == accounts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final account = accounts[index];
                return AccountCardWidget(
                  account: account,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountDetailPage(
                          accountId: account.id,
                        ),
                      ),
                    );
                  },
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountFormPage(
                          account: account,
                        ),
                      ),
                    );
                  },
                  onDelete: () => _confirmDelete(context, account),
                  onActivate: () => _activateAccount(account.id),
                  onDeactivate: () => _deactivateAccount(account.id),
                  onRefreshToken: () => _refreshToken(account.id),
                );
              },
            ),
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(accountListProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
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
              builder: (context) => const AccountFormPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Account'),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Accounts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Active Only'),
              leading: Radio(
                value: true,
                groupValue: null,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Inactive Only'),
              leading: Radio(
                value: false,
                groupValue: null,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('All Accounts'),
              leading: Radio(
                value: null,
                groupValue: null,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(accountListProvider.notifier).refresh();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Account account) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: Text(
          'Are you sure you want to delete this ${account.providerId} account?',
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

    if (confirmed == true && mounted) {
      final success = await ref
          .read(accountProvider.notifier)
          .deleteAccount(account.id);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
        ref.read(accountListProvider.notifier).refresh();
      }
    }
  }

  Future<void> _activateAccount(String id) async {
    final success = await ref
        .read(accountProvider.notifier)
        .activateAccount(id);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account activated')),
      );
      ref.read(accountListProvider.notifier).refresh();
    }
  }

  Future<void> _deactivateAccount(String id) async {
    final success = await ref
        .read(accountProvider.notifier)
        .deactivateAccount(id);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deactivated')),
      );
      ref.read(accountListProvider.notifier).refresh();
    }
  }

  Future<void> _refreshToken(String id) async {
    final success = await ref
        .read(accountProvider.notifier)
        .refreshToken(id);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token refreshed successfully')),
      );
      ref.read(accountListProvider.notifier).refresh();
    }
  }
}
