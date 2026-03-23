import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/maintenance_work_order_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MaintenanceWorkOrder Admin Page  |  18 fields
// Auto-generated — edit with care
// ================================================================

class MaintenanceWorkOrderAdminPage extends ConsumerWidget {
  const MaintenanceWorkOrderAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(maintenanceWorkOrderLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Work Order Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(maintenanceWorkOrderListProvider)),
        ],
      ),
      body: const _MaintenanceWorkOrderBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MaintenanceWorkOrderFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Maintenance Work Order'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MaintenanceWorkOrderBody extends ConsumerStatefulWidget {
  const _MaintenanceWorkOrderBody({super.key});
  @override ConsumerState<_MaintenanceWorkOrderBody> createState() => __MaintenanceWorkOrderBodyState();
}

class __MaintenanceWorkOrderBodyState extends ConsumerState<_MaintenanceWorkOrderBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(maintenanceWorkOrderListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Maintenance Work Orders…',
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
              : items.where((item) => ((item.propertyId?.toString() ?? '') + " " + (item.tenantId?.toString() ?? '') + " " + (item.reportedBy?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.category?.toString() ?? '') + " " + (item.assignedTo?.toString() ?? '') + " " + (item.assignedVendor?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.organizationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Maintenance Work Orders yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(maintenanceWorkOrderListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(maintenanceWorkOrderListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(MaintenanceWorkOrder item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MaintenanceWorkOrder item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Maintenance Work Order Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Tenant Id', item.tenantId?.toString() ?? 'N/A', Icons.link),
              _row('Reported By', item.reportedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Priority', item.priority?.toString() ?? 'N/A', Icons.text_fields),
              _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Reported At', _formatDate(item.reportedAt), Icons.calendar_today),
              _row('Due Date', _formatDate(item.dueDate), Icons.calendar_today),
              _row('Assigned To', item.assignedTo?.toString() ?? 'N/A', Icons.text_fields),
              _row('Assigned Vendor', item.assignedVendor?.toString() ?? 'N/A', Icons.text_fields),
              _row('Estimated Cost', item.estimatedCost?.toString() ?? 'N/A', Icons.attach_money),
              _row('Actual Cost', item.actualCost?.toString() ?? 'N/A', Icons.attach_money),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Organization Id', item.organizationId?.toString() ?? 'N/A', Icons.link),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {MaintenanceWorkOrder? item}) {
  showDialog(context: context, builder: (ctx) => _MaintenanceWorkOrderForm(item: item, ref: ref));
}

class _MaintenanceWorkOrderForm extends ConsumerStatefulWidget {
  final MaintenanceWorkOrder? item;
  final WidgetRef ref;
  const _MaintenanceWorkOrderForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MaintenanceWorkOrderForm> createState() => __MaintenanceWorkOrderFormState();
}

class __MaintenanceWorkOrderFormState extends ConsumerState<_MaintenanceWorkOrderForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _tenantId;
  String? _reportedBy;
  String? _title;
  String? _description;
  String? _priority;
  String? _category;
  String? _status;
  DateTime? _reportedAt;
  DateTime? _dueDate;
  String? _assignedTo;
  String? _assignedVendor;
  double? _estimatedCost;
  double? _actualCost;
  String? _userId;
  String? _organizationId;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _reportedBy = widget.item?.reportedBy?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _priority = widget.item?.priority?.toString();
    _category = widget.item?.category?.toString();
    _status = widget.item?.status?.toString();
    _reportedAt = widget.item?.reportedAt;
    _dueDate = widget.item?.dueDate;
    _assignedTo = widget.item?.assignedTo?.toString();
    _assignedVendor = widget.item?.assignedVendor?.toString();
    _estimatedCost = widget.item?.estimatedCost;
    _actualCost = widget.item?.actualCost;
    _userId = widget.item?.userId?.toString();
    _organizationId = widget.item?.organizationId?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
      if (_reportedBy?.isNotEmpty == true) 'reportedBy': _reportedBy,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_priority?.isNotEmpty == true) 'priority': _priority,
      if (_category?.isNotEmpty == true) 'category': _category,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_reportedAt != null) 'reportedAt': _reportedAt!.toIso8601String(),
      if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
      if (_assignedTo?.isNotEmpty == true) 'assignedTo': _assignedTo,
      if (_assignedVendor?.isNotEmpty == true) 'assignedVendor': _assignedVendor,
      if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
      if (_actualCost != null) 'actualCost': _actualCost,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(maintenanceWorkOrderCreateStateProvider.notifier).state = MaintenanceWorkOrder.fromJson(data);
    } else {
      widget.ref.read(maintenanceWorkOrderUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'maintenanceWorkOrder': MaintenanceWorkOrder.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Maintenance Work Order' : 'New Maintenance Work Order'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.tenantId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reported By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.reportedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reportedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Priority', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.priority?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _priority = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.category?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _category = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _reportedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _reportedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Reported At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_reportedAt != null ? _formatDate(_reportedAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _dueDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Due Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_dueDate != null ? _formatDate(_dueDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Assigned To', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.assignedTo?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _assignedTo = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Assigned Vendor', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.assignedVendor?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _assignedVendor = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Estimated Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.estimatedCost?.toString() ?? '',
                    onSaved: (v) => _estimatedCost = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.actualCost?.toString() ?? '',
                    onSaved: (v) => _actualCost = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.organizationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Maintenance Work Order'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MaintenanceWorkOrder item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Maintenance Work Order?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(maintenanceWorkOrderDeleteStateProvider.notifier).state = item.id;
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
