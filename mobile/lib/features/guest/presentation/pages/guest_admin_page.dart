import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/guest_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Guest Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class GuestAdminPage extends ConsumerWidget {
  const GuestAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(guestLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(guestListProvider)),
        ],
      ),
      body: const _GuestBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'GuestFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Guest'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _GuestBody extends ConsumerStatefulWidget {
  const _GuestBody({super.key});
  @override ConsumerState<_GuestBody> createState() => __GuestBodyState();
}

class __GuestBodyState extends ConsumerState<_GuestBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(guestListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Guests…',
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
              : items.where((item) => ((item.name?.toString() ?? '') + " " + (item.phone?.toString() ?? '') + " " + (item.image?.toString() ?? '') + " " + (item.nationality?.toString() ?? '') + " " + (item.passportNumber?.toString() ?? '') + " " + (item.address?.toString() ?? '') + " " + (item.city?.toString() ?? '') + " " + (item.country?.toString() ?? '') + " " + (item.zipCode?.toString() ?? '') + " " + (item.email?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Guests yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(guestListProvider),
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
                    subtitle: Text('Email: ' + item.email?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(guestListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Guest item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guest Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Phone', item.phone?.toString() ?? 'N/A', Icons.phone),
              _row('Image', item.image?.toString() ?? 'N/A', Icons.text_fields),
              _row('Nationality', item.nationality?.toString() ?? 'N/A', Icons.text_fields),
              _row('Passport Number', item.passportNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Gender', item.gender?.toString() ?? 'N/A', Icons.text_fields),
              _row('Birth Date', _formatDate(item.birthDate), Icons.calendar_today),
              _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
              _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
              _row('Country', item.country?.toString() ?? 'N/A', Icons.location_on),
              _row('Zip Code', item.zipCode?.toString() ?? 'N/A', Icons.text_fields),
              _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Guest? item}) {
  showDialog(context: context, builder: (ctx) => _GuestForm(item: item, ref: ref));
}

class _GuestForm extends ConsumerStatefulWidget {
  final Guest? item;
  final WidgetRef ref;
  const _GuestForm({super.key, this.item, required this.ref});
  @override ConsumerState<_GuestForm> createState() => __GuestFormState();
}

class __GuestFormState extends ConsumerState<_GuestForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _phone;
  String? _image;
  String? _nationality;
  String? _passportNumber;
  String? _gender;
  DateTime? _birthDate;
  String? _address;
  String? _city;
  String? _country;
  String? _zipCode;
  String? _email;
  String? _agencyId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _phone = widget.item?.phone?.toString();
    _image = widget.item?.image?.toString();
    _nationality = widget.item?.nationality?.toString();
    _passportNumber = widget.item?.passportNumber?.toString();
    _gender = widget.item?.gender?.toString();
    _birthDate = widget.item?.birthDate;
    _address = widget.item?.address?.toString();
    _city = widget.item?.city?.toString();
    _country = widget.item?.country?.toString();
    _zipCode = widget.item?.zipCode?.toString();
    _email = widget.item?.email?.toString();
    _agencyId = widget.item?.agencyId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_phone?.isNotEmpty == true) 'phone': _phone,
      if (_image?.isNotEmpty == true) 'image': _image,
      if (_nationality?.isNotEmpty == true) 'nationality': _nationality,
      if (_passportNumber?.isNotEmpty == true) 'passportNumber': _passportNumber,
      if (_gender?.isNotEmpty == true) 'gender': _gender,
      if (_birthDate != null) 'birthDate': _birthDate!.toIso8601String(),
      if (_address?.isNotEmpty == true) 'address': _address,
      if (_city?.isNotEmpty == true) 'city': _city,
      if (_country?.isNotEmpty == true) 'country': _country,
      if (_zipCode?.isNotEmpty == true) 'zipCode': _zipCode,
      if (_email?.isNotEmpty == true) 'email': _email,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
    };
    if (widget.item == null) {
      widget.ref.read(guestCreateStateProvider.notifier).state = Guest.fromJson(data);
    } else {
      widget.ref.read(guestUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'guest': Guest.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Guest' : 'New Guest'),
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
                    decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                    initialValue: widget.item.phone?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.image?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _image = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nationality', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.nationality?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _nationality = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Passport Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.passportNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _passportNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Gender', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.gender?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _gender = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _birthDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _birthDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Birth Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_birthDate != null ? _formatDate(_birthDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.address?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _address = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.city?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _city = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.country?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _country = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Zip Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.zipCode?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _zipCode = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                    initialValue: widget.item.email?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _email = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Guest'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Guest item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Guest?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(guestDeleteStateProvider.notifier).state = item.id;
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
