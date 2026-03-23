import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/communication_log_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// CommunicationLog Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class CommunicationLogAdminPage extends ConsumerWidget {
  const CommunicationLogAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(communicationLogLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Log Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(communicationLogListProvider)),
        ],
      ),
      body: const _CommunicationLogBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'CommunicationLogFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Communication Log'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _CommunicationLogBody extends ConsumerStatefulWidget {
  const _CommunicationLogBody({super.key});
  @override ConsumerState<_CommunicationLogBody> createState() => __CommunicationLogBodyState();
}

class __CommunicationLogBodyState extends ConsumerState<_CommunicationLogBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(communicationLogListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Communication Logs…',
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
              : items.where((item) => ((item.senderId?.toString() ?? '') + " " + (item.receiverId?.toString() ?? '') + " " + (item.content?.toString() ?? '') + " " + (item.entityId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '') + " " + (item.threadId?.toString() ?? '') + " " + (item.replyToId?.toString() ?? '') + " " + (item.channelId?.toString() ?? '') + " " + (item.ticketId?.toString() ?? '') + " " + (item.deletedById?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Communication Logs yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(communicationLogListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(communicationLogListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, CommunicationLog item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Communication Log Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Sender Id', item.senderId?.toString() ?? 'N/A', Icons.link),
              _row('Receiver Id', item.receiverId?.toString() ?? 'N/A', Icons.link),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Read', (item.isRead == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Read At', _formatDate(item.readAt), Icons.calendar_today),
              _row('Delivered At', _formatDate(item.deliveredAt), Icons.calendar_today),
              _row('Timestamp', _formatDate(item.timestamp), Icons.calendar_today),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
              _row('Thread Id', item.threadId?.toString() ?? 'N/A', Icons.link),
              _row('Reply To Id', item.replyToId?.toString() ?? 'N/A', Icons.link),
              _row('Channel Id', item.channelId?.toString() ?? 'N/A', Icons.link),
              _row('Ticket Id', item.ticketId?.toString() ?? 'N/A', Icons.link),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Is Edited', (item.isEdited == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Edited At', _formatDate(item.editedAt), Icons.calendar_today),
              _row('Deleted By Id', item.deletedById?.toString() ?? 'N/A', Icons.link),
              _row('Reactions', item.reactions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Attachments', item.attachments?.toString() ?? 'N/A', Icons.text_fields),
              _row('Read By', item.readBy?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {CommunicationLog? item}) {
  showDialog(context: context, builder: (ctx) => _CommunicationLogForm(item: item, ref: ref));
}

class _CommunicationLogForm extends ConsumerStatefulWidget {
  final CommunicationLog? item;
  final WidgetRef ref;
  const _CommunicationLogForm({super.key, this.item, required this.ref});
  @override ConsumerState<_CommunicationLogForm> createState() => __CommunicationLogFormState();
}

class __CommunicationLogFormState extends ConsumerState<_CommunicationLogForm> {
  final _key = GlobalKey<FormState>();

  String? _senderId;
  String? _receiverId;
  String? _type;
  String? _content;
  String? _entityId;
  String? _entityType;
  String? _metadata;
  bool _isRead = false;
  DateTime? _readAt;
  DateTime? _deliveredAt;
  DateTime? _timestamp;
  String? _userId;
  String? _agencyId;
  String? _threadId;
  String? _replyToId;
  String? _channelId;
  String? _ticketId;
  bool _isEdited = false;
  DateTime? _editedAt;
  String? _deletedById;
  String? _reactions;
  String? _attachments;
  String? _readBy;

  @override
  void initState() {
    super.initState();
    _senderId = widget.item?.senderId?.toString();
    _receiverId = widget.item?.receiverId?.toString();
    _type = widget.item?.type?.toString();
    _content = widget.item?.content?.toString();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _metadata = widget.item?.metadata?.toString();
    _isRead = widget.item?.isRead ?? false;
    _readAt = widget.item?.readAt;
    _deliveredAt = widget.item?.deliveredAt;
    _timestamp = widget.item?.timestamp;
    _userId = widget.item?.userId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _threadId = widget.item?.threadId?.toString();
    _replyToId = widget.item?.replyToId?.toString();
    _channelId = widget.item?.channelId?.toString();
    _ticketId = widget.item?.ticketId?.toString();
    _isEdited = widget.item?.isEdited ?? false;
    _editedAt = widget.item?.editedAt;
    _deletedById = widget.item?.deletedById?.toString();
    _reactions = widget.item?.reactions?.toString();
    _attachments = widget.item?.attachments?.toString();
    _readBy = widget.item?.readBy?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_senderId?.isNotEmpty == true) 'senderId': _senderId,
      if (_receiverId?.isNotEmpty == true) 'receiverId': _receiverId,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_content?.isNotEmpty == true) 'content': _content,
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
      'isRead': _isRead,
      if (_readAt != null) 'readAt': _readAt!.toIso8601String(),
      if (_deliveredAt != null) 'deliveredAt': _deliveredAt!.toIso8601String(),
      if (_timestamp != null) 'timestamp': _timestamp!.toIso8601String(),
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
      if (_threadId?.isNotEmpty == true) 'threadId': _threadId,
      if (_replyToId?.isNotEmpty == true) 'replyToId': _replyToId,
      if (_channelId?.isNotEmpty == true) 'channelId': _channelId,
      if (_ticketId?.isNotEmpty == true) 'ticketId': _ticketId,
      'isEdited': _isEdited,
      if (_editedAt != null) 'editedAt': _editedAt!.toIso8601String(),
      if (_deletedById?.isNotEmpty == true) 'deletedById': _deletedById,
      if (_reactions?.isNotEmpty == true) 'reactions': _reactions,
      if (_attachments?.isNotEmpty == true) 'attachments': _attachments,
      if (_readBy?.isNotEmpty == true) 'readBy': _readBy,
    };
    if (widget.item == null) {
      widget.ref.read(communicationLogCreateStateProvider.notifier).state = CommunicationLog.fromJson(data);
    } else {
      widget.ref.read(communicationLogUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'communicationLog': CommunicationLog.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Communication Log' : 'New Communication Log'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sender Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.senderId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _senderId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Receiver Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.receiverId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _receiverId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.content?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _content = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Read'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isRead ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isRead = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _readAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _readAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Read At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_readAt != null ? _formatDate(_readAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _deliveredAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _deliveredAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Delivered At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_deliveredAt != null ? _formatDate(_deliveredAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _timestamp ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _timestamp = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Timestamp',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_timestamp != null ? _formatDate(_timestamp) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thread Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.threadId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _threadId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reply To Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.replyToId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _replyToId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Channel Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.channelId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _channelId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Ticket Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.ticketId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ticketId = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Edited'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isEdited ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isEdited = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _editedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _editedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Edited At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_editedAt != null ? _formatDate(_editedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deleted By Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.deletedById?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _deletedById = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reactions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reactions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reactions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Attachments', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.attachments?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _attachments = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Read By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.readBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _readBy = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Communication Log'),
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

void _confirmDel(BuildContext context, WidgetRef ref, CommunicationLog item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Communication Log?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(communicationLogDeleteStateProvider.notifier).state = item.id;
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
