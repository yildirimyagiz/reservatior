import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/providers.dart';
import '../../../../gen_models/models_library.dart';

// Agency Admin Page  |  30 fields
// Auto-generated — edit with care

class AgencyAdminPage extends ConsumerWidget {
  const AgencyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(agencyLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agency Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(agencyListProvider)),
        ],
      ),
      body: const _AgencyBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AgencyFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Agency'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AgencyBody extends ConsumerStatefulWidget {
  const _AgencyBody();
  @override ConsumerState<_AgencyBody> createState() => __AgencyBodyState();
}

class __AgencyBodyState extends ConsumerState<_AgencyBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agencyListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Agencys…',
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
              : items.where((item) => '${item.organizationId?.toString() ?? ''} ${item.name?.toString() ?? ''} ${item.description?.toString() ?? ''} ${item.email?.toString() ?? ''} ${item.phoneNumber?.toString() ?? ''} ${item.address?.toString() ?? ''} ${item.website?.toString() ?? ''} ${item.logoUrl?.toString() ?? ''} ${item.facilityId?.toString() ?? ''} ${item.includedServiceId?.toString() ?? ''} ${item.extraChargeId?.toString() ?? ''} ${item.ownerId?.toString() ?? ''} ${item.theme?.toString() ?? ''} ${item.externalId?.toString() ?? ''} ${item.licenseNumber?.toString() ?? ''} ${item.taxIdentificationNumber?.toString() ?? ''} ${item.taxJurisdiction?.toString() ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Agencys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(agencyListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(agencyListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Agency item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Agency item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agency Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Organization Id', item.organizationId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
              _row('Phone Number', item.phoneNumber?.toString() ?? 'N/A', Icons.phone),
              _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
              _row('Website', item.website?.toString() ?? 'N/A', Icons.link),
              _row('Logo Url', item.logoUrl?.toString() ?? 'N/A', Icons.link),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Facility Id', item.facilityId?.toString() ?? 'N/A', Icons.link),
              _row('Included Service Id', item.includedServiceId?.toString() ?? 'N/A', Icons.link),
              _row('Extra Charge Id', item.extraChargeId?.toString() ?? 'N/A', Icons.link),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Owner Id', item.ownerId?.toString() ?? 'N/A', Icons.link),
              _row('Settings', item.settings?.toString() ?? 'N/A', Icons.text_fields),
              _row('Theme', item.theme?.toString() ?? 'N/A', Icons.text_fields),
              _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
              _row('Integration', item.integration?.toString() ?? 'N/A', Icons.text_fields),
              _row('Total Properties', item.totalProperties?.toString() ?? 'N/A', Icons.attach_money),
              _row('Total Agents', item.totalAgents?.toString() ?? 'N/A', Icons.attach_money),
              _row('Established Year', item.establishedYear?.toString() ?? 'N/A', Icons.numbers),
              _row('License Number', item.licenseNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Tax Identification Number', item.taxIdentificationNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Tax Jurisdiction', item.taxJurisdiction?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metrics', item.metrics?.toString() ?? 'N/A', Icons.text_fields),
              _row('Tax Configuration', item.taxConfiguration?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {Agency? item}) {
  showDialog(context: context, builder: (ctx) => _AgencyForm(item: item, ref: ref));
}

class _AgencyForm extends ConsumerStatefulWidget {
  final Agency? item;
  final WidgetRef ref;
  const _AgencyForm({this.item, required this.ref});
  @override ConsumerState<_AgencyForm> createState() => __AgencyFormState();
}

class __AgencyFormState extends ConsumerState<_AgencyForm> {
  final _key = GlobalKey<FormState>();

  String? _organizationId;
  String? _name;
  String? _description;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _website;
  String? _logoUrl;
  String? _status;
  String? _facilityId;
  String? _includedServiceId;
  String? _extraChargeId;
  bool _isActive = false;
  String? _ownerId;
  String? _settings;
  String? _theme;
  String? _externalId;
  String? _integration;
  int? _totalProperties;
  int? _totalAgents;
  int? _establishedYear;
  String? _licenseNumber;
  double? _commissionRate;
  String? _taxIdentificationNumber;
  String? _taxJurisdiction;
  String? _metrics;
  String? _taxConfiguration;

  @override
  void initState() {
    super.initState();
    _organizationId = widget.item?.organizationId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _email = widget.item?.email?.toString();
    _phoneNumber = widget.item?.phoneNumber?.toString();
    _address = widget.item?.address?.toString();
    _website = widget.item?.website?.toString();
    _logoUrl = widget.item?.logoUrl?.toString();
    _status = widget.item?.status?.toString();
    _facilityId = widget.item?.facilityId?.toString();
    _includedServiceId = widget.item?.includedServiceId?.toString();
    _extraChargeId = widget.item?.extraChargeId?.toString();
    _isActive = widget.item?.isActive ?? false;
    _ownerId = widget.item?.ownerId?.toString();
    _settings = widget.item?.settings?.toString();
    _theme = widget.item?.theme?.toString();
    _externalId = widget.item?.externalId?.toString();
    _integration = widget.item?.integration?.toString();
    _totalProperties = widget.item?.totalProperties;
    _totalAgents = widget.item?.totalAgents;
    _establishedYear = widget.item?.establishedYear;
    _licenseNumber = widget.item?.licenseNumber?.toString();
    _commissionRate = widget.item?.commissionRate;
    _taxIdentificationNumber = widget.item?.taxIdentificationNumber?.toString();
    _taxJurisdiction = widget.item?.taxJurisdiction?.toString();
    _metrics = widget.item?.metrics?.toString();
    _taxConfiguration = widget.item?.taxConfiguration?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_email?.isNotEmpty == true) 'email': _email,
      if (_phoneNumber?.isNotEmpty == true) 'phoneNumber': _phoneNumber,
      if (_address?.isNotEmpty == true) 'address': _address,
      if (_website?.isNotEmpty == true) 'website': _website,
      if (_logoUrl?.isNotEmpty == true) 'logoUrl': _logoUrl,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
      if (_includedServiceId?.isNotEmpty == true) 'includedServiceId': _includedServiceId,
      if (_extraChargeId?.isNotEmpty == true) 'extraChargeId': _extraChargeId,
      'isActive': _isActive,
      if (_ownerId?.isNotEmpty == true) 'ownerId': _ownerId,
      if (_settings?.isNotEmpty == true) 'settings': _settings,
      if (_theme?.isNotEmpty == true) 'theme': _theme,
      if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
      if (_integration?.isNotEmpty == true) 'integration': _integration,
      if (_totalProperties != null) 'totalProperties': _totalProperties,
      if (_totalAgents != null) 'totalAgents': _totalAgents,
      if (_establishedYear != null) 'establishedYear': _establishedYear,
      if (_licenseNumber?.isNotEmpty == true) 'licenseNumber': _licenseNumber,
      if (_commissionRate != null) 'commissionRate': _commissionRate,
      if (_taxIdentificationNumber?.isNotEmpty == true) 'taxIdentificationNumber': _taxIdentificationNumber,
      if (_taxJurisdiction?.isNotEmpty == true) 'taxJurisdiction': _taxJurisdiction,
      if (_metrics?.isNotEmpty == true) 'metrics': _metrics,
      if (_taxConfiguration?.isNotEmpty == true) 'taxConfiguration': _taxConfiguration,
    };
    if (widget.item == null) {
      widget.ref.read(agencyCreateStateProvider.notifier).state = Agency.fromJson(data);
    } else {
      widget.ref.read(agencyUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'agency': Agency.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Agency' : 'New Agency'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Organization Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.organizationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                    initialValue: widget.item?.email?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _email = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()),
                    initialValue: widget.item?.phoneNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _phoneNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                    initialValue: widget.item?.address?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _address = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Website', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.website?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _website = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Logo Url', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.logoUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _logoUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Facility Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.facilityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Included Service Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.includedServiceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Extra Charge Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.extraChargeId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _extraChargeId = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: const Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: _isActive,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Owner Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.ownerId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ownerId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Settings', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.settings?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _settings = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Theme', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.theme?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _theme = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'External Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.externalId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Integration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.integration?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _integration = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Properties', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.totalProperties?.toString() ?? '',
                    onSaved: (v) => _totalProperties = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Agents', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.totalAgents?.toString() ?? '',
                    onSaved: (v) => _totalAgents = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Established Year', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.establishedYear?.toString() ?? '',
                    onSaved: (v) => _establishedYear = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'License Number', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.licenseNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _licenseNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.commissionRate?.toString() ?? '',
                    onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tax Identification Number', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.taxIdentificationNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxIdentificationNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tax Jurisdiction', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.taxJurisdiction?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxJurisdiction = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.metrics?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metrics = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tax Configuration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.taxConfiguration?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxConfiguration = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Agency'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Agency item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Agency?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(agencyDeleteStateProvider.notifier).state = item.id;
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
