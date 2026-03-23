import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/event_attendee_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// EventAttendee Admin Page  |  9 fields
// Auto-generated — edit with care
// ================================================================

class EventAttendeeAdminPage extends ConsumerWidget {
  const EventAttendeeAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(eventAttendeeLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Attendee Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(eventAttendeeListProvider)),
        ],
      ),
      body: const _EventAttendeeBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'EventAttendeeFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Event Attendee'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _EventAttendeeBody extends ConsumerStatefulWidget {
  const _EventAttendeeBody({super.key});
  @override ConsumerState<_EventAttendeeBody> createState() => __EventAttendeeBodyState();
}

class __EventAttendeeBodyState extends ConsumerState<_EventAttendeeBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(eventAttendeeListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Event Attendees…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.eventId?.toString() ?? '') + " " + (item.contactId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.rsvpStatus?.toString() ?? '') + " " + (item.notes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Event Attendees yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(eventAttendeeListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.rsvpStatus != null && item.rsvpStatus!.toString().isNotEmpty ? item.rsvpStatus!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.rsvpStatus ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.rsvpStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.rsvpStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
                  ),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(eventAttendeeListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(EventAttendee item) {
    final s = item.rsvpStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, EventAttendee item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Attendee Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Event Id', item.eventId?.toString() ?? 'N/A', Icons.link),
              _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Rsvp Status', item.rsvpStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {EventAttendee? item}) {
  showDialog(context: context, builder: (ctx) => _EventAttendeeForm(item: item, ref: ref));
}

class _EventAttendeeForm extends ConsumerStatefulWidget {
  final EventAttendee? item;
  final WidgetRef ref;
  const _EventAttendeeForm({super.key, this.item, required this.ref});
  @override ConsumerState<_EventAttendeeForm> createState() => __EventAttendeeFormState();
}

class __EventAttendeeFormState extends ConsumerState<_EventAttendeeForm> {
  final _key = GlobalKey<FormState>();

  String? _eventId;
  String? _contactId;
  String? _userId;
  String? _rsvpStatus;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _eventId = widget.item?.eventId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _userId = widget.item?.userId?.toString();
    _rsvpStatus = widget.item?.rsvpStatus?.toString();
    _notes = widget.item?.notes?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_eventId?.isNotEmpty == true) 'eventId': _eventId,
      if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_rsvpStatus?.isNotEmpty == true) 'rsvpStatus': _rsvpStatus,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    if (widget.item == null) {
      widget.ref.read(eventAttendeeCreateStateProvider.notifier).state = EventAttendee.fromJson(data);
    } else {
      widget.ref.read(eventAttendeeUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'eventAttendee': EventAttendee.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Event Attendee' : 'New Event Attendee'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Event Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.eventId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _eventId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.contactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rsvp Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.rsvpStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _rsvpStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Event Attendee'),
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

void _confirmDel(BuildContext context, WidgetRef ref, EventAttendee item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Event Attendee?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(eventAttendeeDeleteStateProvider.notifier).state = item.id;
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
