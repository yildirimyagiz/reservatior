import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/organization_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Organization Admin Page  |  18 fields
// Auto-generated — edit with care
// ================================================================

class OrganizationAdminPage extends ConsumerWidget {
  const OrganizationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(organizationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(organizationListProvider)),
        ],
      ),
      body: const _OrganizationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'OrganizationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Organization'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _OrganizationBody extends ConsumerStatefulWidget {
  const _OrganizationBody({super.key});
  @override ConsumerState<_OrganizationBody> createState() => __OrganizationBodyState();
}

class __OrganizationBodyState extends ConsumerState<_OrganizationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(organizationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Organizations…',
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
              : items.where((item) => ((item.name?.toString() ?? '') + " " + (item.defaultCurrency?.toString() ?? '') + " " + (item.defaultLocale?.toString() ?? '') + " " + (item.legalName?.toString() ?? '') + " " + (item.taxId?.toString() ?? '') + " " + (item.address?.toString() ?? '') + " " + (item.contactEmail?.toString() ?? '') + " " + (item.requiredInspections?.join(' ') ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Organizations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(organizationListProvider),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(organizationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Organization item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Organization Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Region', item.region?.toString() ?? 'N/A', Icons.text_fields),
              _row('Default Currency', item.defaultCurrency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Default Locale', item.defaultLocale?.toString() ?? 'N/A', Icons.text_fields),
              _row('Legal Name', item.legalName?.toString() ?? 'N/A', Icons.person),
              _row('Tax Id', item.taxId?.toString() ?? 'N/A', Icons.link),
              _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
              _row('Contact Email', item.contactEmail?.toString() ?? 'N/A', Icons.email),
              _row('Management Fee Type', item.managementFeeType?.toString() ?? 'N/A', Icons.attach_money),
              _row('Management Fee Rate', item.managementFeeRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Management Fee Amount', item.managementFeeAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Management Fee Scope', item.managementFeeScope?.toString() ?? 'N/A', Icons.attach_money),
              _row('Tax Reporting Enabled', (item.taxReportingEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Compliance Tracking', (item.complianceTracking == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Required Inspections', item.requiredInspections?.map((e) => e.toString()).join(', ') ?? 'N/A', Icons.checklist),
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

void _showForm(BuildContext context, WidgetRef ref, {Organization? item}) {
  showDialog(context: context, builder: (ctx) => _OrganizationForm(item: item, ref: ref));
}

class _OrganizationForm extends ConsumerStatefulWidget {
  final Organization? item;
  final WidgetRef ref;
  const _OrganizationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_OrganizationForm> createState() => __OrganizationFormState();
}

class __OrganizationFormState extends ConsumerState<_OrganizationForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _type;
  String? _region;
  String? _defaultCurrency;
  String? _defaultLocale;
  String? _legalName;
  String? _taxId;
  String? _address;
  String? _contactEmail;
  String? _managementFeeType;
  double? _managementFeeRate;
  double? _managementFeeAmount;
  String? _managementFeeScope;
  bool _taxReportingEnabled = false;
  bool _complianceTracking = false;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _region = widget.item?.region?.toString();
    _defaultCurrency = widget.item?.defaultCurrency?.toString();
    _defaultLocale = widget.item?.defaultLocale?.toString();
    _legalName = widget.item?.legalName?.toString();
    _taxId = widget.item?.taxId?.toString();
    _address = widget.item?.address?.toString();
    _contactEmail = widget.item?.contactEmail?.toString();
    _managementFeeType = widget.item?.managementFeeType?.toString();
    _managementFeeRate = widget.item?.managementFeeRate;
    _managementFeeAmount = widget.item?.managementFeeAmount;
    _managementFeeScope = widget.item?.managementFeeScope?.toString();
    _taxReportingEnabled = widget.item?.taxReportingEnabled ?? false;
    _complianceTracking = widget.item?.complianceTracking ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_region?.isNotEmpty == true) 'region': _region,
      if (_defaultCurrency?.isNotEmpty == true) 'defaultCurrency': _defaultCurrency,
      if (_defaultLocale?.isNotEmpty == true) 'defaultLocale': _defaultLocale,
      if (_legalName?.isNotEmpty == true) 'legalName': _legalName,
      if (_taxId?.isNotEmpty == true) 'taxId': _taxId,
      if (_address?.isNotEmpty == true) 'address': _address,
      if (_contactEmail?.isNotEmpty == true) 'contactEmail': _contactEmail,
      if (_managementFeeType?.isNotEmpty == true) 'managementFeeType': _managementFeeType,
      if (_managementFeeRate != null) 'managementFeeRate': _managementFeeRate,
      if (_managementFeeAmount != null) 'managementFeeAmount': _managementFeeAmount,
      if (_managementFeeScope?.isNotEmpty == true) 'managementFeeScope': _managementFeeScope,
      'taxReportingEnabled': _taxReportingEnabled,
      'complianceTracking': _complianceTracking,
    };
    if (widget.item == null) {
      widget.ref.read(organizationCreateStateProvider.notifier).state = Organization.fromJson(data);
    } else {
      widget.ref.read(organizationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'organization': Organization.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Organization' : 'New Organization'),
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
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.region?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _region = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Default Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.defaultCurrency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _defaultCurrency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Default Locale', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.defaultLocale?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _defaultLocale = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Legal Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.legalName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _legalName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tax Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.taxId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.address?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _address = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contact Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item.contactEmail?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contactEmail = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Management Fee Type', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item.managementFeeType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _managementFeeType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Management Fee Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.managementFeeRate?.toString() ?? '',
                    onSaved: (v) => _managementFeeRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Management Fee Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.managementFeeAmount?.toString() ?? '',
                    onSaved: (v) => _managementFeeAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Management Fee Scope', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item.managementFeeScope?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _managementFeeScope = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Tax Reporting Enabled'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.taxReportingEnabled ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _taxReportingEnabled = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Compliance Tracking'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.complianceTracking ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _complianceTracking = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Organization'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Organization item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Organization?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(organizationDeleteStateProvider.notifier).state = item.id;
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
