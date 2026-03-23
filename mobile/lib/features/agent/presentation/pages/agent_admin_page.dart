import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/agent_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Agent Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class AgentAdminPage extends ConsumerWidget {
  const AgentAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(agentLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(agentListProvider)),
        ],
      ),
      body: const _AgentBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AgentFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Agent'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AgentBody extends ConsumerStatefulWidget {
  const _AgentBody();
  @override ConsumerState<_AgentBody> createState() => __AgentBodyState();
}

class __AgentBodyState extends ConsumerState<_AgentBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agentListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Agents…',
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
              : items.where((item) => '${item.name ?? ''} ${item.email ?? ''} ${item.phoneNumber ?? ''} ${item.bio ?? ''} ${item.locationId ?? ''} ${item.address ?? ''} ${item.website ?? ''} ${item.logoUrl ?? ''} ${item.agencyId ?? ''} ${item.licenseNumber ?? ''} ${item.education ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Agents yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(agentListProvider),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(agentListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Agent item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Agent item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agent Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
              _row('Phone Number', item.phoneNumber?.toString() ?? 'N/A', Icons.phone),
              _row('Bio', item.bio?.toString() ?? 'N/A', Icons.text_fields),
              _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
              _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
              _row('Website', item.website?.toString() ?? 'N/A', Icons.link),
              _row('Logo Url', item.logoUrl?.toString() ?? 'N/A', Icons.link),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
              _row('License Number', item.licenseNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Years Of Experience', item.yearsOfExperience?.toString() ?? 'N/A', Icons.numbers),
              _row('Education', item.education?.toString() ?? 'N/A', Icons.text_fields),
              _row('Performance Metrics', item.performanceMetrics?.toString() ?? 'N/A', Icons.text_fields),
              _row('Tax Configuration', item.taxConfiguration?.toString() ?? 'N/A', Icons.text_fields),
              _row('Availability', item.availability?.toString() ?? 'N/A', Icons.text_fields),
              _row('Social Media', item.socialMedia?.toString() ?? 'N/A', Icons.text_fields),
              _row('Settings', item.settings?.toString() ?? 'N/A', Icons.text_fields),
              _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
              _row('Integration', item.integration?.toString() ?? 'N/A', Icons.text_fields),
              _row('Owner Id', item.ownerId?.toString() ?? 'N/A', Icons.link),
              _row('Last Active', _formatDate(item.lastActive), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {Agent? item}) {
  showDialog(context: context, builder: (ctx) => _AgentForm(item: item, ref: ref));
}

class _AgentForm extends ConsumerStatefulWidget {
  final Agent? item;
  final WidgetRef ref;
  const _AgentForm({this.item, required this.ref});
  @override ConsumerState<_AgentForm> createState() => __AgentFormState();
}

class __AgentFormState extends ConsumerState<_AgentForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _bio;
  String? _locationId;
  String? _address;
  String? _website;
  String? _logoUrl;
  String? _status;
  String? _agencyId;
  String? _licenseNumber;
  double? _commissionRate;
  int? _yearsOfExperience;
  String? _education;
  String? _performanceMetrics;
  String? _taxConfiguration;
  String? _availability;
  String? _socialMedia;
  String? _settings;
  String? _externalId;
  String? _integration;
  String? _ownerId;
  DateTime? _lastActive;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _email = widget.item?.email?.toString();
    _phoneNumber = widget.item?.phoneNumber?.toString();
    _bio = widget.item?.bio?.toString();
    _locationId = widget.item?.locationId?.toString();
    _address = widget.item?.address?.toString();
    _website = widget.item?.website?.toString();
    _logoUrl = widget.item?.logoUrl?.toString();
    _status = widget.item?.status?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _licenseNumber = widget.item?.licenseNumber?.toString();
    _commissionRate = widget.item?.commissionRate;
    _yearsOfExperience = widget.item?.yearsOfExperience;
    _education = widget.item?.education?.toString();
    _performanceMetrics = widget.item?.performanceMetrics?.toString();
    _taxConfiguration = widget.item?.taxConfiguration?.toString();
    _availability = widget.item?.availability?.toString();
    _socialMedia = widget.item?.socialMedia?.toString();
    _settings = widget.item?.settings?.toString();
    _externalId = widget.item?.externalId?.toString();
    _integration = widget.item?.integration?.toString();
    _ownerId = widget.item?.ownerId?.toString();
    _lastActive = widget.item?.lastActive;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_email?.isNotEmpty == true) 'email': _email,
      if (_phoneNumber?.isNotEmpty == true) 'phoneNumber': _phoneNumber,
      if (_bio?.isNotEmpty == true) 'bio': _bio,
      if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
      if (_address?.isNotEmpty == true) 'address': _address,
      if (_website?.isNotEmpty == true) 'website': _website,
      if (_logoUrl?.isNotEmpty == true) 'logoUrl': _logoUrl,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
      if (_licenseNumber?.isNotEmpty == true) 'licenseNumber': _licenseNumber,
      if (_commissionRate != null) 'commissionRate': _commissionRate,
      if (_yearsOfExperience != null) 'yearsOfExperience': _yearsOfExperience,
      if (_education?.isNotEmpty == true) 'education': _education,
      if (_performanceMetrics?.isNotEmpty == true) 'performanceMetrics': _performanceMetrics,
      if (_taxConfiguration?.isNotEmpty == true) 'taxConfiguration': _taxConfiguration,
      if (_availability?.isNotEmpty == true) 'availability': _availability,
      if (_socialMedia?.isNotEmpty == true) 'socialMedia': _socialMedia,
      if (_settings?.isNotEmpty == true) 'settings': _settings,
      if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
      if (_integration?.isNotEmpty == true) 'integration': _integration,
      if (_ownerId?.isNotEmpty == true) 'ownerId': _ownerId,
      if (_lastActive != null) 'lastActive': _lastActive!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(agentCreateStateProvider.notifier).state = Agent.fromJson(data);
    } else {
      widget.ref.read(agentUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'agent': Agent.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Agent' : 'New Agent'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Bio', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.bio?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _bio = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.locationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Agency Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Years Of Experience', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.yearsOfExperience?.toString() ?? '',
                    onSaved: (v) => _yearsOfExperience = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Education', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.education?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _education = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Performance Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.performanceMetrics?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _performanceMetrics = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tax Configuration', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.taxConfiguration?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxConfiguration = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Availability', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.availability?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _availability = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Social Media', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.socialMedia?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _socialMedia = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Settings', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.settings?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _settings = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Owner Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.ownerId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ownerId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastActive ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastActive = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Active',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastActive != null ? _formatDate(_lastActive) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Agent'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Agent item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Agent?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(agentDeleteStateProvider.notifier).state = item.id;
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
