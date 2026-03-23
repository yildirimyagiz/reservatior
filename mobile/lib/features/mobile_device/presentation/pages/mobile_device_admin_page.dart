import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/mobile_device_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MobileDevice Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class MobileDeviceAdminPage extends ConsumerWidget {
  const MobileDeviceAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(mobileDeviceLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Device Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(mobileDeviceListProvider)),
        ],
      ),
      body: const _MobileDeviceBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MobileDeviceFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Mobile Device'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MobileDeviceBody extends ConsumerStatefulWidget {
  const _MobileDeviceBody({super.key});
  @override ConsumerState<_MobileDeviceBody> createState() => __MobileDeviceBodyState();
}

class __MobileDeviceBodyState extends ConsumerState<_MobileDeviceBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mobileDeviceListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Mobile Devices…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.deviceId?.toString() ?? '') + " " + (item.deviceType?.toString() ?? '') + " " + (item.deviceToken?.toString() ?? '') + " " + (item.appVersion?.toString() ?? '') + " " + (item.osVersion?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Mobile Devices yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mobileDeviceListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.deviceType != null && item.deviceType!.toString().isNotEmpty ? item.deviceType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.deviceType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(mobileDeviceListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MobileDevice item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Device Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Device Id', item.deviceId?.toString() ?? 'N/A', Icons.link),
              _row('Device Type', item.deviceType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Device Token', item.deviceToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('App Version', item.appVersion?.toString() ?? 'N/A', Icons.text_fields),
              _row('Os Version', item.osVersion?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Last Login At', _formatDate(item.lastLoginAt), Icons.calendar_today),
              _row('Notification Preferences', item.notificationPreferences?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {MobileDevice? item}) {
  showDialog(context: context, builder: (ctx) => _MobileDeviceForm(item: item, ref: ref));
}

class _MobileDeviceForm extends ConsumerStatefulWidget {
  final MobileDevice? item;
  final WidgetRef ref;
  const _MobileDeviceForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MobileDeviceForm> createState() => __MobileDeviceFormState();
}

class __MobileDeviceFormState extends ConsumerState<_MobileDeviceForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _deviceId;
  String? _deviceType;
  String? _deviceToken;
  String? _appVersion;
  String? _osVersion;
  bool _isActive = false;
  DateTime? _lastLoginAt;
  String? _notificationPreferences;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _deviceId = widget.item?.deviceId?.toString();
    _deviceType = widget.item?.deviceType?.toString();
    _deviceToken = widget.item?.deviceToken?.toString();
    _appVersion = widget.item?.appVersion?.toString();
    _osVersion = widget.item?.osVersion?.toString();
    _isActive = widget.item?.isActive ?? false;
    _lastLoginAt = widget.item?.lastLoginAt;
    _notificationPreferences = widget.item?.notificationPreferences?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_deviceId?.isNotEmpty == true) 'deviceId': _deviceId,
      if (_deviceType?.isNotEmpty == true) 'deviceType': _deviceType,
      if (_deviceToken?.isNotEmpty == true) 'deviceToken': _deviceToken,
      if (_appVersion?.isNotEmpty == true) 'appVersion': _appVersion,
      if (_osVersion?.isNotEmpty == true) 'osVersion': _osVersion,
      'isActive': _isActive,
      if (_lastLoginAt != null) 'lastLoginAt': _lastLoginAt!.toIso8601String(),
      if (_notificationPreferences?.isNotEmpty == true) 'notificationPreferences': _notificationPreferences,
    };
    if (widget.item == null) {
      widget.ref.read(mobileDeviceCreateStateProvider.notifier).state = MobileDevice.fromJson(data);
    } else {
      widget.ref.read(mobileDeviceUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'mobileDevice': MobileDevice.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Mobile Device' : 'New Mobile Device'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Device Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.deviceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _deviceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Device Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.deviceType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _deviceType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Device Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.deviceToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _deviceToken = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'App Version', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.appVersion?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _appVersion = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Os Version', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.osVersion?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _osVersion = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastLoginAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastLoginAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Login At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastLoginAt != null ? _formatDate(_lastLoginAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notification Preferences', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.notificationPreferences?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _notificationPreferences = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Mobile Device'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MobileDevice item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Mobile Device?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(mobileDeviceDeleteStateProvider.notifier).state = item.id;
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
