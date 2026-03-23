import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/communication_template_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// CommunicationTemplate Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class CommunicationTemplateAdminPage extends ConsumerWidget {
  const CommunicationTemplateAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(communicationTemplateLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Template Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(communicationTemplateListProvider)),
        ],
      ),
      body: const _CommunicationTemplateBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'CommunicationTemplateFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Communication Template'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _CommunicationTemplateBody extends ConsumerStatefulWidget {
  const _CommunicationTemplateBody({super.key});
  @override ConsumerState<_CommunicationTemplateBody> createState() => __CommunicationTemplateBodyState();
}

class __CommunicationTemplateBodyState extends ConsumerState<_CommunicationTemplateBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(communicationTemplateListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Communication Templates…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.type?.toString() ?? '') + " " + (item.templateType?.toString() ?? '') + " " + (item.subject?.toString() ?? '') + " " + (item.htmlContent?.toString() ?? '') + " " + (item.textContent?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.message?.toString() ?? '') + " " + (item.category?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Communication Templates yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(communicationTemplateListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Type: ' + item.type?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(communicationTemplateListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, CommunicationTemplate item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Communication Template Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Template Type', item.templateType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Subject', item.subject?.toString() ?? 'N/A', Icons.text_fields),
              _row('Html Content', item.htmlContent?.toString() ?? 'N/A', Icons.notes),
              _row('Text Content', item.textContent?.toString() ?? 'N/A', Icons.notes),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Message', item.message?.toString() ?? 'N/A', Icons.text_fields),
              _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
              _row('Variables', item.variables?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {CommunicationTemplate? item}) {
  showDialog(context: context, builder: (ctx) => _CommunicationTemplateForm(item: item, ref: ref));
}

class _CommunicationTemplateForm extends ConsumerStatefulWidget {
  final CommunicationTemplate? item;
  final WidgetRef ref;
  const _CommunicationTemplateForm({super.key, this.item, required this.ref});
  @override ConsumerState<_CommunicationTemplateForm> createState() => __CommunicationTemplateFormState();
}

class __CommunicationTemplateFormState extends ConsumerState<_CommunicationTemplateForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _type;
  String? _templateType;
  String? _subject;
  String? _htmlContent;
  String? _textContent;
  String? _title;
  String? _message;
  String? _category;
  String? _variables;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _templateType = widget.item?.templateType?.toString();
    _subject = widget.item?.subject?.toString();
    _htmlContent = widget.item?.htmlContent?.toString();
    _textContent = widget.item?.textContent?.toString();
    _title = widget.item?.title?.toString();
    _message = widget.item?.message?.toString();
    _category = widget.item?.category?.toString();
    _variables = widget.item?.variables?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_templateType?.isNotEmpty == true) 'templateType': _templateType,
      if (_subject?.isNotEmpty == true) 'subject': _subject,
      if (_htmlContent?.isNotEmpty == true) 'htmlContent': _htmlContent,
      if (_textContent?.isNotEmpty == true) 'textContent': _textContent,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_message?.isNotEmpty == true) 'message': _message,
      if (_category?.isNotEmpty == true) 'category': _category,
      if (_variables?.isNotEmpty == true) 'variables': _variables,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(communicationTemplateCreateStateProvider.notifier).state = CommunicationTemplate.fromJson(data);
    } else {
      widget.ref.read(communicationTemplateUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'communicationTemplate': CommunicationTemplate.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Communication Template' : 'New Communication Template'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Template Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.templateType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _templateType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.subject?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Html Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.htmlContent?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _htmlContent = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Text Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.textContent?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _textContent = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.message?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _message = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.category?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _category = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Variables', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.variables?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _variables = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Communication Template'),
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

void _confirmDel(BuildContext context, WidgetRef ref, CommunicationTemplate item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Communication Template?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(communicationTemplateDeleteStateProvider.notifier).state = item.id;
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
