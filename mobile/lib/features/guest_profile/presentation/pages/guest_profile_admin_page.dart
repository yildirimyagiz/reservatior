import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/guest_profile_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// GuestProfile Admin Page  |  8 fields
// Auto-generated — edit with care
// ================================================================

class GuestProfileAdminPage extends ConsumerWidget {
  const GuestProfileAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(guestProfileLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Profile Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(guestProfileListProvider)),
        ],
      ),
      body: const _GuestProfileBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'GuestProfileFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Guest Profile'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _GuestProfileBody extends ConsumerStatefulWidget {
  const _GuestProfileBody({super.key});
  @override ConsumerState<_GuestProfileBody> createState() => __GuestProfileBodyState();
}

class __GuestProfileBodyState extends ConsumerState<_GuestProfileBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(guestProfileListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Guest Profiles…',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _q.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                : null,
            border: const OutlineInputBorder(), isDense: true,
          ),
          onChanged: (v) => setState(() => _q = v.toLowerCase()),
        ),
      ),
      Expanded(child: async.when(
        data: (items) {
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.contactId?.toString() ?? '') + " " + (item.preferredCheckInTime?.toString() ?? '') + " " + (item.dietaryRestrictions?.toString() ?? '') + " " + (item.accessibilityNeeds?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Guest Profiles yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(guestProfileListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.preferredCheckInTime != null && item.preferredCheckInTime!.toString().isNotEmpty ? item.preferredCheckInTime!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.preferredCheckInTime ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Contact Id: ' + item.contactId?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                          onPressed: () => _showForm(context, ref, item: item)),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), tooltip: 'Delete',
                          onPressed: () => _confirmDel(context, ref, item)),
                    ]),
                    onTap: () => _showDetail(context, item),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          SelectableText('$e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: () => ref.invalidate(guestProfileListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, GuestProfile item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guest Profile Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
              _row('Preferred Check In Time', item.preferredCheckInTime?.toString() ?? 'N/A', Icons.text_fields),
              _row('Dietary Restrictions', item.dietaryRestrictions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Accessibility Needs', item.accessibilityNeeds?.toString() ?? 'N/A', Icons.text_fields),
              _row('Loyalty Points', item.loyaltyPoints?.toString() ?? 'N/A', Icons.numbers),
              _row('Lifetime Spent', item.lifetimeSpent?.toString() ?? 'N/A', Icons.numbers),
              _row('Booking Count', item.bookingCount?.toString() ?? 'N/A', Icons.numbers),
          ]),
        ),
      ),
    ),
  ));
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value),
    ])),
  ]),
);

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {GuestProfile? item}) {
  showDialog(context: context, builder: (ctx) => _GuestProfileForm(item: item, ref: ref));
}

class _GuestProfileForm extends ConsumerStatefulWidget {
  final GuestProfile? item;
  final WidgetRef ref;
  const _GuestProfileForm({super.key, this.item, required this.ref});
  @override ConsumerState<_GuestProfileForm> createState() => __GuestProfileFormState();
}

class __GuestProfileFormState extends ConsumerState<_GuestProfileForm> {
  final _key = GlobalKey<FormState>();

  String? _contactId;
  String? _preferredCheckInTime;
  String? _dietaryRestrictions;
  String? _accessibilityNeeds;
  int? _loyaltyPoints;
  double? _lifetimeSpent;
  int? _bookingCount;

  @override
  void initState() {
    super.initState();
    _contactId = widget.item?.contactId?.toString();
    _preferredCheckInTime = widget.item?.preferredCheckInTime?.toString();
    _dietaryRestrictions = widget.item?.dietaryRestrictions?.toString();
    _accessibilityNeeds = widget.item?.accessibilityNeeds?.toString();
    _loyaltyPoints = widget.item?.loyaltyPoints;
    _lifetimeSpent = widget.item?.lifetimeSpent;
    _bookingCount = widget.item?.bookingCount;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
      if (_preferredCheckInTime?.isNotEmpty == true) 'preferredCheckInTime': _preferredCheckInTime,
      if (_dietaryRestrictions?.isNotEmpty == true) 'dietaryRestrictions': _dietaryRestrictions,
      if (_accessibilityNeeds?.isNotEmpty == true) 'accessibilityNeeds': _accessibilityNeeds,
      if (_loyaltyPoints != null) 'loyaltyPoints': _loyaltyPoints,
      if (_lifetimeSpent != null) 'lifetimeSpent': _lifetimeSpent,
      if (_bookingCount != null) 'bookingCount': _bookingCount,
    };
    if (widget.item == null) {
      widget.ref.read(guestProfileCreateStateProvider.notifier).state = GuestProfile.fromJson(data);
    } else {
      widget.ref.read(guestProfileUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'guestProfile': GuestProfile.fromJson({...widget.item!.toJson(), ...data}),
      };
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? 'Edit Guest Profile' : 'New Guest Profile'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.contactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Preferred Check In Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.preferredCheckInTime?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _preferredCheckInTime = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dietary Restrictions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.dietaryRestrictions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dietaryRestrictions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Accessibility Needs', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.accessibilityNeeds?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _accessibilityNeeds = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Loyalty Points', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.loyaltyPoints?.toString() ?? '',
                    onSaved: (v) => _loyaltyPoints = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Lifetime Spent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.lifetimeSpent?.toString() ?? '',
                    onSaved: (v) => _lifetimeSpent = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Booking Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.bookingCount?.toString() ?? '',
                    onSaved: (v) => _bookingCount = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Guest Profile'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDel(BuildContext context, WidgetRef ref, GuestProfile item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Guest Profile?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(guestProfileDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

// ─── Helpers ─────────────────────────────────────────────────────

String _formatDate(DateTime? d) {
  if (d == null) return 'N/A';
  final y = d.year; final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0'); final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '$y-$mo-$day $h:$mi';
}
