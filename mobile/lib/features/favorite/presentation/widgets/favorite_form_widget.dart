import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Favorite Form Widget  |  Fields: userId, propertyId

class FavoriteFormWidget extends StatefulWidget {
  final Favorite? item;
  final void Function(Favorite)? onSubmit;
  const FavoriteFormWidget({super.key, this.item, this.onSubmit});
  @override State<FavoriteFormWidget> createState() => _FavoriteFormWidgetState();
}

class _FavoriteFormWidgetState extends State<FavoriteFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _propertyId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
    };
    final result = widget.item != null
        ? Favorite.fromJson({...widget.item!.toJson(), ...data})
        : Favorite.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Favorite'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}