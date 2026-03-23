import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_chatbot_session_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIChatbotSession Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class AIChatbotSessionAdminPage extends ConsumerWidget {
  const AIChatbotSessionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiChatbotSessionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Chatbot Session Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiChatbotSessionListProvider)),
        ],
      ),
      body: const _AIChatbotSessionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIChatbotSessionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Chatbot Session'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIChatbotSessionBody extends ConsumerStatefulWidget {
  const _AIChatbotSessionBody();
  @override ConsumerState<_AIChatbotSessionBody> createState() => __AIChatbotSessionBodyState();
}

class __AIChatbotSessionBodyState extends ConsumerState<_AIChatbotSessionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiChatbotSessionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Chatbot Sessions…',
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
              : items.where((AIChatbotSession item) {
                  final searchText = [
                    item.orgId ?? '',
                    item.userId ?? '',
                    item.contactId ?? '',
                    item.sessionId ?? '',
                    item.intent ?? '',
                    item.status ?? '',
                    item.transferredTo ?? '',
                  ].join(' ');
                  return searchText.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Chatbot Sessions yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiChatbotSessionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.intent != null && item.intent!.toString().isNotEmpty ? item.intent!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.intent ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ${item.status?.toString() ?? 'N/A'}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withValues(alpha: 0.4)),
                    ),
                    child: Text(item.status!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiChatbotSessionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AIChatbotSession item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIChatbotSession item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Chatbot Session Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
              _row('Session Id', item.sessionId?.toString() ?? 'N/A', Icons.link),
              _row('Conversation History', item.conversationHistory?.toString() ?? 'N/A', Icons.text_fields),
              _row('Intent', item.intent?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Transferred To', item.transferredTo?.toString() ?? 'N/A', Icons.text_fields),
              _row('Started At', _formatDate(item.startedAt), Icons.calendar_today),
              _row('Last Activity At', _formatDate(item.lastActivityAt), Icons.calendar_today),
              _row('Ended At', _formatDate(item.endedAt), Icons.calendar_today),
              _row('Satisfaction', item.satisfaction?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {AIChatbotSession? item}) {
  showDialog(context: context, builder: (ctx) => _AIChatbotSessionForm(item: item, ref: ref));
}

class _AIChatbotSessionForm extends ConsumerStatefulWidget {
  final AIChatbotSession? item;
  final WidgetRef ref;
  const _AIChatbotSessionForm({this.item, required this.ref});
  @override ConsumerState<_AIChatbotSessionForm> createState() => __AIChatbotSessionFormState();
}

class __AIChatbotSessionFormState extends ConsumerState<_AIChatbotSessionForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _contactId;
  String? _sessionId;
  String? _conversationHistory;
  String? _intent;
  double? _confidence;
  String? _status;
  String? _transferredTo;
  DateTime? _startedAt;
  DateTime? _lastActivityAt;
  DateTime? _endedAt;
  int? _satisfaction;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _sessionId = widget.item?.sessionId?.toString();
    _conversationHistory = widget.item?.conversationHistory?.toString();
    _intent = widget.item?.intent?.toString();
    _confidence = widget.item?.confidence;
    _status = widget.item?.status?.toString();
    _transferredTo = widget.item?.transferredTo?.toString();
    _startedAt = widget.item?.startedAt;
    _lastActivityAt = widget.item?.lastActivityAt;
    _endedAt = widget.item?.endedAt;
    _satisfaction = widget.item?.satisfaction;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
      if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
      if (_conversationHistory?.isNotEmpty == true) 'conversationHistory': _conversationHistory,
      if (_intent?.isNotEmpty == true) 'intent': _intent,
      if (_confidence != null) 'confidence': _confidence,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_transferredTo?.isNotEmpty == true) 'transferredTo': _transferredTo,
      if (_startedAt != null) 'startedAt': _startedAt!.toIso8601String(),
      if (_lastActivityAt != null) 'lastActivityAt': _lastActivityAt!.toIso8601String(),
      if (_endedAt != null) 'endedAt': _endedAt!.toIso8601String(),
      if (_satisfaction != null) 'satisfaction': _satisfaction,
    };
    if (widget.item == null) {
      widget.ref.read(aiChatbotSessionCreateStateProvider.notifier).state = AIChatbotSession.fromJson(data);
    } else {
      widget.ref.read(aiChatbotSessionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiChatbotSession': AIChatbotSession.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Chatbot Session' : 'New Ai Chatbot Session'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.contactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Session Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.sessionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Conversation History', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.conversationHistory?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _conversationHistory = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Intent', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.intent?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _intent = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Transferred To', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.transferredTo?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _transferredTo = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _startedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _startedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Started At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_startedAt != null ? _formatDate(_startedAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastActivityAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastActivityAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Activity At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastActivityAt != null ? _formatDate(_lastActivityAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _endedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _endedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Ended At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_endedAt != null ? _formatDate(_endedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Satisfaction', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.satisfaction?.toString() ?? '',
                    onSaved: (v) => _satisfaction = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Chatbot Session'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIChatbotSession item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Chatbot Session?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiChatbotSessionDeleteStateProvider.notifier).state = item.id;
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
