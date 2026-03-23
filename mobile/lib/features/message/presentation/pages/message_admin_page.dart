import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/message_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Message Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class MessageAdminPage extends ConsumerWidget {
  const MessageAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(messageLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(messageListProvider)),
        ],
      ),
      body: const _MessageBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MessageFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Message'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MessageBody extends ConsumerStatefulWidget {
  const _MessageBody({super.key});
  @override ConsumerState<_MessageBody> createState() => __MessageBodyState();
}

class __MessageBodyState extends ConsumerState<_MessageBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(messageListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Messages…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.threadId?.toString() ?? '') + " " + (item.senderUserId?.toString() ?? '') + " " + (item.senderContactId?.toString() ?? '') + " " + (item.body?.toString() ?? '') + " " + (item.subject?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Messages yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(messageListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.subject != null && item.subject!.toString().isNotEmpty ? item.subject!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.subject ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.readStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.readStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(messageListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Message item) {
    final s = item.readStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Message item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Message Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Thread Id', item.threadId?.toString() ?? 'N/A', Icons.link),
              _row('Sender Type', item.senderType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Sender User Id', item.senderUserId?.toString() ?? 'N/A', Icons.link),
              _row('Sender Contact Id', item.senderContactId?.toString() ?? 'N/A', Icons.link),
              _row('Body', item.body?.toString() ?? 'N/A', Icons.notes),
              _row('Subject', item.subject?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Thread Starter', (item.isThreadStarter == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Thread Info', item.threadInfo?.toString() ?? 'N/A', Icons.text_fields),
              _row('Read Status', item.readStatus?.toString() ?? 'N/A', Icons.info_outline),
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

void _showForm(BuildContext context, WidgetRef ref, {Message? item}) {
  showDialog(context: context, builder: (ctx) => _MessageForm(item: item, ref: ref));
}

class _MessageForm extends ConsumerStatefulWidget {
  final Message? item;
  final WidgetRef ref;
  const _MessageForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MessageForm> createState() => __MessageFormState();
}

class __MessageFormState extends ConsumerState<_MessageForm> {
  final _key = GlobalKey<FormState>();

  String? _threadId;
  String? _senderType;
  String? _senderUserId;
  String? _senderContactId;
  String? _body;
  String? _subject;
  bool _isThreadStarter = false;
  String? _threadInfo;
  String? _readStatus;

  @override
  void initState() {
    super.initState();
    _threadId = widget.item?.threadId?.toString();
    _senderType = widget.item?.senderType?.toString();
    _senderUserId = widget.item?.senderUserId?.toString();
    _senderContactId = widget.item?.senderContactId?.toString();
    _body = widget.item?.body?.toString();
    _subject = widget.item?.subject?.toString();
    _isThreadStarter = widget.item?.isThreadStarter ?? false;
    _threadInfo = widget.item?.threadInfo?.toString();
    _readStatus = widget.item?.readStatus?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_threadId?.isNotEmpty == true) 'threadId': _threadId,
      if (_senderType?.isNotEmpty == true) 'senderType': _senderType,
      if (_senderUserId?.isNotEmpty == true) 'senderUserId': _senderUserId,
      if (_senderContactId?.isNotEmpty == true) 'senderContactId': _senderContactId,
      if (_body?.isNotEmpty == true) 'body': _body,
      if (_subject?.isNotEmpty == true) 'subject': _subject,
      'isThreadStarter': _isThreadStarter,
      if (_threadInfo?.isNotEmpty == true) 'threadInfo': _threadInfo,
      if (_readStatus?.isNotEmpty == true) 'readStatus': _readStatus,
    };
    if (widget.item == null) {
      widget.ref.read(messageCreateStateProvider.notifier).state = Message.fromJson(data);
    } else {
      widget.ref.read(messageUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'message': Message.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Message' : 'New Message'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thread Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.threadId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _threadId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sender Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.senderType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _senderType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sender User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.senderUserId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _senderUserId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sender Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.senderContactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _senderContactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Body', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.body?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _body = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.subject?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Thread Starter'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isThreadStarter ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isThreadStarter = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thread Info', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.threadInfo?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _threadInfo = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Read Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.readStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _readStatus = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Message'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Message item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Message?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(messageDeleteStateProvider.notifier).state = item.id;
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
