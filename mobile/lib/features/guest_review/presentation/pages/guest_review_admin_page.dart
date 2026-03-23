import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/guest_review_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// GuestReview Admin Page  |  14 fields
// Auto-generated — edit with care
// ================================================================

class GuestReviewAdminPage extends ConsumerWidget {
  const GuestReviewAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(guestReviewLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Review Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(guestReviewListProvider)),
        ],
      ),
      body: const _GuestReviewBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'GuestReviewFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Guest Review'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _GuestReviewBody extends ConsumerStatefulWidget {
  const _GuestReviewBody({super.key});
  @override ConsumerState<_GuestReviewBody> createState() => __GuestReviewBodyState();
}

class __GuestReviewBodyState extends ConsumerState<_GuestReviewBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(guestReviewListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Guest Reviews…',
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
              : items.where((item) => ((item.bookingId?.toString() ?? '') + " " + (item.guestId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.comment?.toString() ?? '') + " " + (item.response?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Guest Reviews yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(guestReviewListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.comment != null && item.comment!.toString().isNotEmpty ? item.comment!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.comment ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Booking Id: ' + item.bookingId?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(guestReviewListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, GuestReview item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guest Review Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Booking Id', item.bookingId?.toString() ?? 'N/A', Icons.link),
              _row('Guest Id', item.guestId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Rating', item.rating?.toString() ?? 'N/A', Icons.numbers),
              _row('Cleanliness', item.cleanliness?.toString() ?? 'N/A', Icons.numbers),
              _row('Communication', item.communication?.toString() ?? 'N/A', Icons.numbers),
              _row('Check In', item.checkIn?.toString() ?? 'N/A', Icons.numbers),
              _row('Accuracy', item.accuracy?.toString() ?? 'N/A', Icons.numbers),
              _row('Location', item.location?.toString() ?? 'N/A', Icons.numbers),
              _row('Value', item.value?.toString() ?? 'N/A', Icons.numbers),
              _row('Comment', item.comment?.toString() ?? 'N/A', Icons.notes),
              _row('Response', item.response?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Public', (item.isPublic == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {GuestReview? item}) {
  showDialog(context: context, builder: (ctx) => _GuestReviewForm(item: item, ref: ref));
}

class _GuestReviewForm extends ConsumerStatefulWidget {
  final GuestReview? item;
  final WidgetRef ref;
  const _GuestReviewForm({super.key, this.item, required this.ref});
  @override ConsumerState<_GuestReviewForm> createState() => __GuestReviewFormState();
}

class __GuestReviewFormState extends ConsumerState<_GuestReviewForm> {
  final _key = GlobalKey<FormState>();

  String? _bookingId;
  String? _guestId;
  String? _propertyId;
  int? _rating;
  int? _cleanliness;
  int? _communication;
  int? _checkIn;
  int? _accuracy;
  int? _location;
  int? _value;
  String? _comment;
  String? _response;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    _bookingId = widget.item?.bookingId?.toString();
    _guestId = widget.item?.guestId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _rating = widget.item?.rating;
    _cleanliness = widget.item?.cleanliness;
    _communication = widget.item?.communication;
    _checkIn = widget.item?.checkIn;
    _accuracy = widget.item?.accuracy;
    _location = widget.item?.location;
    _value = widget.item?.value;
    _comment = widget.item?.comment?.toString();
    _response = widget.item?.response?.toString();
    _isPublic = widget.item?.isPublic ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
      if (_guestId?.isNotEmpty == true) 'guestId': _guestId,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_rating != null) 'rating': _rating,
      if (_cleanliness != null) 'cleanliness': _cleanliness,
      if (_communication != null) 'communication': _communication,
      if (_checkIn != null) 'checkIn': _checkIn,
      if (_accuracy != null) 'accuracy': _accuracy,
      if (_location != null) 'location': _location,
      if (_value != null) 'value': _value,
      if (_comment?.isNotEmpty == true) 'comment': _comment,
      if (_response?.isNotEmpty == true) 'response': _response,
      'isPublic': _isPublic,
    };
    if (widget.item == null) {
      widget.ref.read(guestReviewCreateStateProvider.notifier).state = GuestReview.fromJson(data);
    } else {
      widget.ref.read(guestReviewUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'guestReview': GuestReview.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Guest Review' : 'New Guest Review'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.bookingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Guest Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.guestId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _guestId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Rating', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.rating?.toString() ?? '',
                    onSaved: (v) => _rating = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Cleanliness', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.cleanliness?.toString() ?? '',
                    onSaved: (v) => _cleanliness = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Communication', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.communication?.toString() ?? '',
                    onSaved: (v) => _communication = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Check In', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.checkIn?.toString() ?? '',
                    onSaved: (v) => _checkIn = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Accuracy', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.accuracy?.toString() ?? '',
                    onSaved: (v) => _accuracy = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.location?.toString() ?? '',
                    onSaved: (v) => _location = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.value?.toString() ?? '',
                    onSaved: (v) => _value = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Comment', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.comment?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _comment = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Response', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.response?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _response = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Public'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isPublic ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isPublic = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Guest Review'),
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

void _confirmDel(BuildContext context, WidgetRef ref, GuestReview item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Guest Review?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(guestReviewDeleteStateProvider.notifier).state = item.id;
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
