import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/attorney_management_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AttorneyManagement Admin Page  |  20 fields
// Auto-generated — edit with care
// ================================================================

class AttorneyManagementAdminPage extends ConsumerWidget {
  const AttorneyManagementAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(attorneyManagementLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attorney Management Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(attorneyManagementListProvider)),
        ],
      ),
      body: const _AttorneyManagementBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AttorneyManagementFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Attorney Management'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AttorneyManagementBody extends ConsumerStatefulWidget {
  const _AttorneyManagementBody({super.key});
  @override ConsumerState<_AttorneyManagementBody> createState() => __AttorneyManagementBodyState();
}

class __AttorneyManagementBodyState extends ConsumerState<_AttorneyManagementBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(attorneyManagementListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Attorney Managements…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.contactId?.toString() ?? '') + " " + (item.solicitorFirm?.toString() ?? '') + " " + (item.solicitorName?.toString() ?? '') + " " + (item.solicitorEmail?.toString() ?? '') + " " + (item.solicitorPhone?.toString() ?? '') + " " + (item.appointmentType?.toString() ?? '') + " " + (item.appointmentNotes?.toString() ?? '') + " " + (item.status?.toString() ?? '') + " " + (item.completionNotes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Attorney Managements yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(attorneyManagementListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.solicitorFirm != null && item.solicitorFirm!.toString().isNotEmpty ? item.solicitorFirm!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.solicitorFirm ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(attorneyManagementListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AttorneyManagement item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AttorneyManagement item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attorney Management Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
              _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
              _row('Solicitor Firm', item.solicitorFirm?.toString() ?? 'N/A', Icons.text_fields),
              _row('Solicitor Name', item.solicitorName?.toString() ?? 'N/A', Icons.person),
              _row('Solicitor Email', item.solicitorEmail?.toString() ?? 'N/A', Icons.email),
              _row('Solicitor Phone', item.solicitorPhone?.toString() ?? 'N/A', Icons.phone),
              _row('Appointment Type', item.appointmentType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Appointment Date', _formatDate(item.appointmentDate), Icons.calendar_today),
              _row('Appointment Notes', item.appointmentNotes?.toString() ?? 'N/A', Icons.notes),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Search Date', _formatDate(item.searchDate), Icons.calendar_today),
              _row('Draft Contract Date', _formatDate(item.draftContractDate), Icons.calendar_today),
              _row('Final Contract Date', _formatDate(item.finalContractDate), Icons.calendar_today),
              _row('Completion Date', _formatDate(item.completionDate), Icons.calendar_today),
              _row('Completion Notes', item.completionNotes?.toString() ?? 'N/A', Icons.notes),
              _row('Fees', item.fees?.toString() ?? 'N/A', Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {AttorneyManagement? item}) {
  showDialog(context: context, builder: (ctx) => _AttorneyManagementForm(item: item, ref: ref));
}

class _AttorneyManagementForm extends ConsumerStatefulWidget {
  final AttorneyManagement? item;
  final WidgetRef ref;
  const _AttorneyManagementForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AttorneyManagementForm> createState() => __AttorneyManagementFormState();
}

class __AttorneyManagementFormState extends ConsumerState<_AttorneyManagementForm> {
  final _key = GlobalKey<FormState>();

  String? _dealId;
  String? _contactId;
  String? _solicitorFirm;
  String? _solicitorName;
  String? _solicitorEmail;
  String? _solicitorPhone;
  String? _appointmentType;
  DateTime? _appointmentDate;
  String? _appointmentNotes;
  String? _status;
  DateTime? _searchDate;
  DateTime? _draftContractDate;
  DateTime? _finalContractDate;
  DateTime? _completionDate;
  String? _completionNotes;
  String? _fees;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _solicitorFirm = widget.item?.solicitorFirm?.toString();
    _solicitorName = widget.item?.solicitorName?.toString();
    _solicitorEmail = widget.item?.solicitorEmail?.toString();
    _solicitorPhone = widget.item?.solicitorPhone?.toString();
    _appointmentType = widget.item?.appointmentType?.toString();
    _appointmentDate = widget.item?.appointmentDate;
    _appointmentNotes = widget.item?.appointmentNotes?.toString();
    _status = widget.item?.status?.toString();
    _searchDate = widget.item?.searchDate;
    _draftContractDate = widget.item?.draftContractDate;
    _finalContractDate = widget.item?.finalContractDate;
    _completionDate = widget.item?.completionDate;
    _completionNotes = widget.item?.completionNotes?.toString();
    _fees = widget.item?.fees?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
      if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
      if (_solicitorFirm?.isNotEmpty == true) 'solicitorFirm': _solicitorFirm,
      if (_solicitorName?.isNotEmpty == true) 'solicitorName': _solicitorName,
      if (_solicitorEmail?.isNotEmpty == true) 'solicitorEmail': _solicitorEmail,
      if (_solicitorPhone?.isNotEmpty == true) 'solicitorPhone': _solicitorPhone,
      if (_appointmentType?.isNotEmpty == true) 'appointmentType': _appointmentType,
      if (_appointmentDate != null) 'appointmentDate': _appointmentDate!.toIso8601String(),
      if (_appointmentNotes?.isNotEmpty == true) 'appointmentNotes': _appointmentNotes,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_searchDate != null) 'searchDate': _searchDate!.toIso8601String(),
      if (_draftContractDate != null) 'draftContractDate': _draftContractDate!.toIso8601String(),
      if (_finalContractDate != null) 'finalContractDate': _finalContractDate!.toIso8601String(),
      if (_completionDate != null) 'completionDate': _completionDate!.toIso8601String(),
      if (_completionNotes?.isNotEmpty == true) 'completionNotes': _completionNotes,
      if (_fees?.isNotEmpty == true) 'fees': _fees,
    };
    if (widget.item == null) {
      widget.ref.read(attorneyManagementCreateStateProvider.notifier).state = AttorneyManagement.fromJson(data);
    } else {
      widget.ref.read(attorneyManagementUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'attorneyManagement': AttorneyManagement.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Attorney Management' : 'New Attorney Management'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.dealId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.contactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Firm', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.solicitorFirm?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorFirm = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.solicitorName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item?.solicitorEmail?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorEmail = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Solicitor Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                    initialValue: widget.item?.solicitorPhone?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _solicitorPhone = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Appointment Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.appointmentType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _appointmentType = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _appointmentDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _appointmentDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Appointment Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_appointmentDate != null ? _formatDate(_appointmentDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Appointment Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.appointmentNotes?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _appointmentNotes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _searchDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _searchDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Search Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_searchDate != null ? _formatDate(_searchDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _draftContractDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _draftContractDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Draft Contract Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_draftContractDate != null ? _formatDate(_draftContractDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _finalContractDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _finalContractDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Final Contract Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_finalContractDate != null ? _formatDate(_finalContractDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _completionDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _completionDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Completion Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_completionDate != null ? _formatDate(_completionDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Completion Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.completionNotes?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _completionNotes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fees', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item?.fees?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fees = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Attorney Management'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AttorneyManagement item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Attorney Management?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(attorneyManagementDeleteStateProvider.notifier).state = item.id;
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
