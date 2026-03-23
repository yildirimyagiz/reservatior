import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_chat_message_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIChatMessage Admin Page  |  23 fields
// Auto-generated — edit with care
// ================================================================

class AIChatMessageAdminPage extends ConsumerWidget {
  const AIChatMessageAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiChatMessageLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Chat Message Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiChatMessageListProvider)),
        ],
      ),
      body: const _AIChatMessageBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIChatMessageFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Chat Message'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIChatMessageBody extends ConsumerStatefulWidget {
  const _AIChatMessageBody();
  @override ConsumerState<_AIChatMessageBody> createState() => __AIChatMessageBodyState();
}

class __AIChatMessageBodyState extends ConsumerState<_AIChatMessageBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiChatMessageListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Chat Messages…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.sessionId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.content?.toString() ?? '') + " " + (item.contentHash?.toString() ?? '') + " " + (item.redactedContent?.toString() ?? '') + " " + (item.language?.toString() ?? '') + " " + (item.escalationTag?.toString() ?? '') + " " + (item.escalationTopic?.toString() ?? '') + " " + (item.securityReason?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Chat Messages yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiChatMessageListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.content != null && item.content!.toString().isNotEmpty ? item.content!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.content ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ${_formatDate(item.createdAt)}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiChatMessageListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIChatMessage item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Chat Message Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Session Id', item.sessionId?.toString() ?? 'N/A', Icons.link),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Role', item.role?.toString() ?? 'N/A', Icons.text_fields),
              _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
              _row('Content Hash', item.contentHash?.toString() ?? 'N/A', Icons.notes),
              _row('Redacted Content', item.redactedContent?.toString() ?? 'N/A', Icons.notes),
              _row('Pii Detected', (item.piiDetected == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Language', item.language?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is A I', (item.isAI == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Escalation Tag', item.escalationTag?.toString() ?? 'N/A', Icons.text_fields),
              _row('Escalation Topic', item.escalationTopic?.toString() ?? 'N/A', Icons.text_fields),
              _row('Payment Agreed', (item.paymentAgreed == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Payment Plan', item.paymentPlan?.toString() ?? 'N/A', Icons.text_fields),
              _row('Security Flag', (item.securityFlag == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Security Reason', item.securityReason?.toString() ?? 'N/A', Icons.text_fields),
              _row('Module Type', item.moduleType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
              _row('Token Count', item.tokenCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Processing Ms', item.processingMs?.toString() ?? 'N/A', Icons.numbers),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {AIChatMessage? item}) {
  showDialog(context: context, builder: (ctx) => _AIChatMessageForm(item: item, ref: ref));
}

class _AIChatMessageForm extends ConsumerStatefulWidget {
  final AIChatMessage? item;
  final WidgetRef ref;
  const _AIChatMessageForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIChatMessageForm> createState() => __AIChatMessageFormState();
}

class __AIChatMessageFormState extends ConsumerState<_AIChatMessageForm> {
  final _key = GlobalKey<FormState>();

  String? _sessionId;
  String? _listingId;
  String? _reservationId;
  String? _role;
  String? _content;
  String? _contentHash;
  String? _redactedContent;
  bool _piiDetected = false;
  String? _language;
  bool _isAI = false;
  String? _escalationTag;
  String? _escalationTopic;
  bool _paymentAgreed = false;
  String? _paymentPlan;
  bool _securityFlag = false;
  String? _securityReason;
  String? _moduleType;
  String? _metadata;
  int? _tokenCount;
  int? _processingMs;

  @override
  void initState() {
    super.initState();
    _sessionId = widget.item?.sessionId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _role = widget.item?.role?.toString();
    _content = widget.item?.content?.toString();
    _contentHash = widget.item?.contentHash?.toString();
    _redactedContent = widget.item?.redactedContent?.toString();
    _piiDetected = widget.item?.piiDetected ?? false;
    _language = widget.item?.language?.toString();
    _isAI = widget.item?.isAI ?? false;
    _escalationTag = widget.item?.escalationTag?.toString();
    _escalationTopic = widget.item?.escalationTopic?.toString();
    _paymentAgreed = widget.item?.paymentAgreed ?? false;
    _paymentPlan = widget.item?.paymentPlan?.toString();
    _securityFlag = widget.item?.securityFlag ?? false;
    _securityReason = widget.item?.securityReason?.toString();
    _moduleType = widget.item?.moduleType?.toString();
    _metadata = widget.item?.metadata?.toString();
    _tokenCount = widget.item?.tokenCount;
    _processingMs = widget.item?.processingMs;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_role?.isNotEmpty == true) 'role': _role,
      if (_content?.isNotEmpty == true) 'content': _content,
      if (_contentHash?.isNotEmpty == true) 'contentHash': _contentHash,
      if (_redactedContent?.isNotEmpty == true) 'redactedContent': _redactedContent,
      'piiDetected': _piiDetected,
      if (_language?.isNotEmpty == true) 'language': _language,
      'isAI': _isAI,
      if (_escalationTag?.isNotEmpty == true) 'escalationTag': _escalationTag,
      if (_escalationTopic?.isNotEmpty == true) 'escalationTopic': _escalationTopic,
      'paymentAgreed': _paymentAgreed,
      if (_paymentPlan?.isNotEmpty == true) 'paymentPlan': _paymentPlan,
      'securityFlag': _securityFlag,
      if (_securityReason?.isNotEmpty == true) 'securityReason': _securityReason,
      if (_moduleType?.isNotEmpty == true) 'moduleType': _moduleType,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
      if (_tokenCount != null) 'tokenCount': _tokenCount,
      if (_processingMs != null) 'processingMs': _processingMs,
    };
    if (widget.item == null) {
      widget.ref.read(aiChatMessageCreateStateProvider.notifier).state = AIChatMessage.fromJson(data);
    } else {
      widget.ref.read(aiChatMessageUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiChatMessage': AIChatMessage.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Chat Message' : 'New Ai Chat Message'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Session Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.sessionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Reservation Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.role?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _role = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.content?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _content = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content Hash', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.contentHash?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contentHash = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Redacted Content', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.redactedContent?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _redactedContent = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Pii Detected'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.piiDetected ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _piiDetected = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Language', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.language?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _language = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is A I'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isAI ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isAI = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Escalation Tag', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.escalationTag?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _escalationTag = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Escalation Topic', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.escalationTopic?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _escalationTopic = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Payment Agreed'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.paymentAgreed ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _paymentAgreed = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Payment Plan', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.paymentPlan?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _paymentPlan = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Security Flag'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.securityFlag ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _securityFlag = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Security Reason', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.securityReason?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _securityReason = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Module Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.moduleType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _moduleType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Metadata', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Token Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.tokenCount?.toString() ?? '',
                    onSaved: (v) => _tokenCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Processing Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.processingMs?.toString() ?? '',
                    onSaved: (v) => _processingMs = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Chat Message'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIChatMessage item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Chat Message?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiChatMessageDeleteStateProvider.notifier).state = item.id;
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
