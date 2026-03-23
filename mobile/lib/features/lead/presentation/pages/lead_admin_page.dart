import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/lead_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Lead Admin Page  |  20 fields
// Auto-generated — edit with care
// ================================================================

class LeadAdminPage extends ConsumerWidget {
  const LeadAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(leadLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(leadListProvider)),
        ],
      ),
      body: const _LeadBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'LeadFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Lead'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _LeadBody extends ConsumerStatefulWidget {
  const _LeadBody({super.key});
  @override ConsumerState<_LeadBody> createState() => __LeadBodyState();
}

class __LeadBodyState extends ConsumerState<_LeadBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(leadListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Leads…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.campaignId?.toString() ?? '') + " " + (item.sourceId?.toString() ?? '') + " " + (item.firstName?.toString() ?? '') + " " + (item.lastName?.toString() ?? '') + " " + (item.email?.toString() ?? '') + " " + (item.phone?.toString() ?? '') + " " + (item.timeline?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.sourceDetail?.toString() ?? '') + " " + (item.assignedToUserId?.toString() ?? '') + " " + (item.assignedToContactId?.toString() ?? '') + " " + (item.interestedPropertyId?.toString() ?? '') + " " + (item.interestedListingId?.toString() ?? '') + " " + (item.agentTeamId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Leads yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(leadListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.email != null && item.email!.toString().isNotEmpty ? item.email!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.email ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(leadListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Lead item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Lead item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lead Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Campaign Id', item.campaignId?.toString() ?? 'N/A', Icons.link),
              _row('Source Id', item.sourceId?.toString() ?? 'N/A', Icons.link),
              _row('First Name', item.firstName?.toString() ?? 'N/A', Icons.person),
              _row('Last Name', item.lastName?.toString() ?? 'N/A', Icons.text_fields),
              _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
              _row('Phone', item.phone?.toString() ?? 'N/A', Icons.phone),
              _row('Budget', item.budget?.toString() ?? 'N/A', Icons.numbers),
              _row('Timeline', item.timeline?.toString() ?? 'N/A', Icons.text_fields),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Source Detail', item.sourceDetail?.toString() ?? 'N/A', Icons.text_fields),
              _row('Assigned To User Id', item.assignedToUserId?.toString() ?? 'N/A', Icons.link),
              _row('Assigned To Contact Id', item.assignedToContactId?.toString() ?? 'N/A', Icons.link),
              _row('Interested Property Id', item.interestedPropertyId?.toString() ?? 'N/A', Icons.link),
              _row('Interested Listing Id', item.interestedListingId?.toString() ?? 'N/A', Icons.link),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Agent Team Id', item.agentTeamId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Lead? item}) {
  showDialog(context: context, builder: (ctx) => _LeadForm(item: item, ref: ref));
}

class _LeadForm extends ConsumerStatefulWidget {
  final Lead? item;
  final WidgetRef ref;
  const _LeadForm({super.key, this.item, required this.ref});
  @override ConsumerState<_LeadForm> createState() => __LeadFormState();
}

class __LeadFormState extends ConsumerState<_LeadForm> {
  final _key = GlobalKey<FormState>();

  String? _campaignId;
  String? _sourceId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  double? _budget;
  String? _timeline;
  String? _notes;
  String? _status;
  String? _sourceDetail;
  String? _assignedToUserId;
  String? _assignedToContactId;
  String? _interestedPropertyId;
  String? _interestedListingId;
  String? _agentTeamId;

  @override
  void initState() {
    super.initState();
    _campaignId = widget.item?.campaignId?.toString();
    _sourceId = widget.item?.sourceId?.toString();
    _firstName = widget.item?.firstName?.toString();
    _lastName = widget.item?.lastName?.toString();
    _email = widget.item?.email?.toString();
    _phone = widget.item?.phone?.toString();
    _budget = widget.item?.budget;
    _timeline = widget.item?.timeline?.toString();
    _notes = widget.item?.notes?.toString();
    _status = widget.item?.status?.toString();
    _sourceDetail = widget.item?.sourceDetail?.toString();
    _assignedToUserId = widget.item?.assignedToUserId?.toString();
    _assignedToContactId = widget.item?.assignedToContactId?.toString();
    _interestedPropertyId = widget.item?.interestedPropertyId?.toString();
    _interestedListingId = widget.item?.interestedListingId?.toString();
    _agentTeamId = widget.item?.agentTeamId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_campaignId?.isNotEmpty == true) 'campaignId': _campaignId,
      if (_sourceId?.isNotEmpty == true) 'sourceId': _sourceId,
      if (_firstName?.isNotEmpty == true) 'firstName': _firstName,
      if (_lastName?.isNotEmpty == true) 'lastName': _lastName,
      if (_email?.isNotEmpty == true) 'email': _email,
      if (_phone?.isNotEmpty == true) 'phone': _phone,
      if (_budget != null) 'budget': _budget,
      if (_timeline?.isNotEmpty == true) 'timeline': _timeline,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_sourceDetail?.isNotEmpty == true) 'sourceDetail': _sourceDetail,
      if (_assignedToUserId?.isNotEmpty == true) 'assignedToUserId': _assignedToUserId,
      if (_assignedToContactId?.isNotEmpty == true) 'assignedToContactId': _assignedToContactId,
      if (_interestedPropertyId?.isNotEmpty == true) 'interestedPropertyId': _interestedPropertyId,
      if (_interestedListingId?.isNotEmpty == true) 'interestedListingId': _interestedListingId,
      if (_agentTeamId?.isNotEmpty == true) 'agentTeamId': _agentTeamId,
    };
    if (widget.item == null) {
      widget.ref.read(leadCreateStateProvider.notifier).state = Lead.fromJson(data);
    } else {
      widget.ref.read(leadUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'lead': Lead.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Lead' : 'New Lead'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Campaign Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.campaignId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _campaignId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Source Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.sourceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sourceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.firstName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _firstName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.lastName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lastName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item.email?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _email = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                    initialValue: widget.item.phone?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.budget?.toString() ?? '',
                    onSaved: (v) => _budget = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Timeline', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.timeline?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _timeline = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Source Detail', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.sourceDetail?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sourceDetail = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Assigned To User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.assignedToUserId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _assignedToUserId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Assigned To Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.assignedToContactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _assignedToContactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Interested Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.interestedPropertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _interestedPropertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Interested Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.interestedListingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _interestedListingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agent Team Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.agentTeamId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agentTeamId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Lead'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Lead item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Lead?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(leadDeleteStateProvider.notifier).state = item.id;
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
