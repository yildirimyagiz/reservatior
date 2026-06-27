import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/features/client/booking_security/booking_security_notifier.dart';
import 'package:reservatior/shared/models/booking_security.dart';
import 'package:reservatior/shared/providers/booking_security_provider.dart';

class BookingSecurityListPage extends ConsumerStatefulWidget {
  const BookingSecurityListPage({super.key});

  @override
  ConsumerState<BookingSecurityListPage> createState() =>
      _BookingSecurityListPageState();
}

class _BookingSecurityListPageState
    extends ConsumerState<BookingSecurityListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _loadBookings();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreBookings();
    }
  }

  void _loadBookings() {
    final filter = ref.read(bookingSecurityFilterProvider);
    ref
        .read(bookingSecurityNotifierProvider.notifier)
        .loadBookings(
          orgId: filter.orgId,
          listingId: filter.listingId,
          contactId: filter.contactId,
          status: filter.status,
          ownershipVerified: filter.ownershipVerified,
          verificationStatus: filter.verificationStatus,
          startDate: filter.startDate,
          endDate: filter.endDate,
          page: 1,
          limit: _pageSize,
        );
  }

  void _loadMoreBookings() {
    _currentPage++;
    final filter = ref.read(bookingSecurityFilterProvider);
    ref
        .read(bookingSecurityNotifierProvider.notifier)
        .loadBookings(
          orgId: filter.orgId,
          listingId: filter.listingId,
          contactId: filter.contactId,
          status: filter.status,
          ownershipVerified: filter.ownershipVerified,
          verificationStatus: filter.verificationStatus,
          startDate: filter.startDate,
          endDate: filter.endDate,
          page: _currentPage,
          limit: _pageSize,
        );
  }

  void _refreshBookings() {
    _currentPage = 1;
    _loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookingSecurityNotifierProvider);
    final filter = ref.read(bookingSecurityFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('mobile.auto.feature_bookingsecurity_title'.tr()),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshBookings,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCards(state.analytics),
          Expanded(child: _buildBookingsList(state)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateBooking,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatsCards(Map<String, dynamic> analytics) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'mobile.auto.total_bookings'.tr(),
              value: (analytics['totalBookings'] ?? 0).toString(),
              icon: Icons.book,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _StatCard(
              title: 'mobile.auto.verified'.tr(),
              value: (analytics['verifiedBookings'] ?? 0).toString(),
              icon: Icons.verified,
              color: Colors.green,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _StatCard(
              title: 'mobile.auto.high_risk'.tr(),
              value: (analytics['highRiskBookings'] ?? 0).toString(),
              icon: Icons.warning,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(BookingSecurityState state) {
    if (state.isLoading && state.bookings.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${'mobile.admin.error_label'.tr()}: ${state.error}"),
            ElevatedButton(
              onPressed: _refreshBookings,
              child: Text('mobile.auto.admin_shared_retry'.tr()),
            ),
          ],
        ),
      );
    }

    if (state.bookings.isEmpty) {
      return Center(child: Text('mobile.auto.no_bookings_found'.tr()));
    }

    return RefreshIndicator(
      onRefresh: () async => _refreshBookings(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.bookings.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.bookings.length) {
            return Center(child: CircularProgressIndicator());
          }

          final booking = state.bookings[index];
          return _BookingCard(
            booking: booking,
            onTap: () => _navigateToBookingDetail(booking),
            onVerify: booking['ownershipVerified'] == false
                ? () => _verifyOwnership(booking['id'])
                : null,
            onScreen: booking['securityScreeningRequired'] == true
                ? () => _createSecurityScreening(booking['id'])
                : null,
          );
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('mobile.auto.search_bookings'.tr()),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'mobile.auto.enter_search_query'.tr(),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) {
            Navigator.pop(context);
            if (query.isNotEmpty) {
              _searchBookings(query);
            }
          },
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => _FilterDialog(
        currentFilter: ref.read(bookingSecurityFilterProvider),
        onFilterChanged: (filter) {
          ref.read(bookingSecurityFilterProvider.notifier).state = filter;
          _refreshBookings();
        },
      ),
    );
  }

  void _searchBookings(String query) {
    ref.read(bookingSecurityNotifierProvider.notifier).searchBookings(query);
  }

  void _navigateToCreateBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingSecurityCreatePage(),
      ),
    );
  }

  void _navigateToBookingDetail(Map<String, dynamic> booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingSecurityDetailPage(booking: booking),
      ),
    );
  }

  void _verifyOwnership(String id) async {
    try {
      await ref
          .read(bookingSecurityNotifierProvider.notifier)
          .verifyOwnership(
            id,
            propertyId: 'property-123', // This should come from booking data
            verificationMethod: 'MANUAL',
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('mobile.auto.ownership_verification_started'.tr())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${'admin.shared.connectionError'.tr()}: $e')));
      }
    }
  }

  void _createSecurityScreening(String id) async {
    try {
      await ref
          .read(bookingSecurityNotifierProvider.notifier)
          .createSecurityScreening(
            id,
            riskLevel: 'MEDIUM',
            riskScore: 0.5,
            manualReviewRequired: false,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('mobile.auto.security_screening_created'.tr())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${'admin.shared.connectionError'.tr()}: $e')));
      }
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onTap;
  final VoidCallback? onVerify;
  final VoidCallback? onScreen;

  const _BookingCard({
    required this.booking,
    required this.onTap,
    this.onVerify,
    this.onScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(booking['status']),
          child: Icon(_getStatusIcon(booking['status']), color: Colors.white),
        ),
        title: Text(
          'Booking: ${booking['id']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${booking['status']}'),
            Text(
              'Verified: \${booking[\'ownershipVerified\'] == true ? "Yes".tr() : "No".tr()}',
            ),
            if (booking['riskLevel'] != null)
              Text('Risk Level: ${booking['riskLevel']}'),
            Text('Start Date: ${booking['startDate']}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onVerify != null)
              IconButton(
                icon: Icon(Icons.verified_user),
                onPressed: onVerify,
                tooltip: 'mobile.auto.verify_ownership'.tr(),
              ),
            if (onScreen != null)
              IconButton(
                icon: Icon(Icons.security),
                onPressed: onScreen,
                tooltip: 'mobile.auto.security_screening'.tr(),
              ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.hourglass_empty;
      case 'cancelled':
        return Icons.cancel;
      case 'completed':
        return Icons.done_all;
      default:
        return Icons.help;
    }
  }
}

class _FilterDialog extends StatefulWidget {
  final BookingSecurityFilterState currentFilter;
  final Function(BookingSecurityFilterState) onFilterChanged;

  const _FilterDialog({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late TextEditingController _orgIdController;
  late TextEditingController _listingIdController;
  late TextEditingController _contactIdController;
  late String? _selectedStatus;
  late bool? _ownershipVerified;
  late String? _verificationStatus;

  @override
  void initState() {
    super.initState();
    _orgIdController = TextEditingController(text: widget.currentFilter.orgId);
    _listingIdController = TextEditingController(
      text: widget.currentFilter.listingId,
    );
    _contactIdController = TextEditingController(
      text: widget.currentFilter.contactId,
    );
    _selectedStatus = widget.currentFilter.status;
    _ownershipVerified = widget.currentFilter.ownershipVerified;
    _verificationStatus = widget.currentFilter.verificationStatus;
  }

  @override
  void dispose() {
    _orgIdController.dispose();
    _listingIdController.dispose();
    _contactIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('mobile.auto.filter_bookings'.tr()),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _orgIdController,
              decoration: InputDecoration(
                labelText: 'mobile.auto.organization_id'.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _listingIdController,
              decoration: InputDecoration(
                labelText: 'mobile.auto.listing_id'.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contactIdController,
              decoration: InputDecoration(
                labelText: 'mobile.auto.contact_id'.tr(),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'mobile.auto.status'.tr(),
                border: OutlineInputBorder(),
              ),
              items: ['pending', 'confirmed', 'cancelled', 'completed'].map((
                status,
              ) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedStatus = value),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<bool>(
              value: _ownershipVerified,
              decoration: InputDecoration(
                labelText: 'mobile.auto.ownership_verified'.tr(),
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text('mobile.auto.all'.tr())),
                DropdownMenuItem(value: true, child: Text('mobile.auto.yes'.tr())),
                DropdownMenuItem(value: false, child: Text('mobile.auto.no'.tr())),
              ],
              onChanged: (value) => setState(() => _ownershipVerified = value),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _verificationStatus,
              decoration: InputDecoration(
                labelText: 'mobile.auto.verification_status'.tr(),
                border: OutlineInputBorder(),
              ),
              items: ['pending', 'verified', 'rejected'].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) => setState(() => _verificationStatus = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('mobile.auto.cancel'.tr()),
        ),
        TextButton(
          onPressed: () {
            widget.onFilterChanged(
              BookingSecurityFilterState(
                orgId: _orgIdController.text.isEmpty
                    ? null
                    : _orgIdController.text,
                listingId: _listingIdController.text.isEmpty
                    ? null
                    : _listingIdController.text,
                contactId: _contactIdController.text.isEmpty
                    ? null
                    : _contactIdController.text,
                status: _selectedStatus,
                ownershipVerified: _ownershipVerified,
                verificationStatus: _verificationStatus,
              ),
            );
            Navigator.pop(context);
          },
          child: Text('mobile.auto.apply'.tr()),
        ),
      ],
    );
  }
}

// Placeholder pages for navigation
class BookingSecurityCreatePage extends StatelessWidget {
  const BookingSecurityCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mobile.auto.create_booking'.tr())),
      body: Center(child: Text('mobile.auto.create_booking_form_todo'.tr())),
    );
  }
}

class BookingSecurityDetailPage extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingSecurityDetailPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mobile.auto.booking_details'.tr())),
      body: Center(child: Text('Details for ${booking['id']} - TODO')),
    );
  }
}
