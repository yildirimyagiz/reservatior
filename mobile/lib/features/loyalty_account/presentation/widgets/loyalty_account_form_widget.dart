import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── LoyaltyAccount Form Widget  |  Fields: userId, name, description, pointsPerDollar, pointsExpiryDays, tiersEnabled, bronzeThreshold, silverThreshold, goldThreshold, platinumThreshold, diamondThreshold, currentPoints, currentTier, totalEarned, pointsHistory, rewards, isActive

class LoyaltyAccountFormWidget extends StatefulWidget {
  final LoyaltyAccount? item;
  final void Function(LoyaltyAccount)? onSubmit;
  const LoyaltyAccountFormWidget({super.key, this.item, this.onSubmit});
  @override State<LoyaltyAccountFormWidget> createState() => _LoyaltyAccountFormWidgetState();
}

class _LoyaltyAccountFormWidgetState extends State<LoyaltyAccountFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _description;
  double? _pointsPerDollar;
  int? _pointsExpiryDays;
  bool _tiersEnabled = false;
  int? _bronzeThreshold;
  int? _silverThreshold;
  int? _goldThreshold;
  int? _platinumThreshold;
  int? _diamondThreshold;
  int? _currentPoints;
  String? _currentTier;
  int? _totalEarned;
  String? _pointsHistory;
  String? _rewards;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _pointsPerDollar = widget.item?.pointsPerDollar;
    _pointsExpiryDays = widget.item?.pointsExpiryDays;
    _tiersEnabled = widget.item?.tiersEnabled ?? false;
    _bronzeThreshold = widget.item?.bronzeThreshold;
    _silverThreshold = widget.item?.silverThreshold;
    _goldThreshold = widget.item?.goldThreshold;
    _platinumThreshold = widget.item?.platinumThreshold;
    _diamondThreshold = widget.item?.diamondThreshold;
    _currentPoints = widget.item?.currentPoints;
    _currentTier = widget.item?.currentTier?.toString();
    _totalEarned = widget.item?.totalEarned;
    _pointsHistory = widget.item?.pointsHistory?.toString();
    _rewards = widget.item?.rewards?.toString();
    _isActive = widget.item?.isActive ?? false;
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_pointsPerDollar != null) 'pointsPerDollar': _pointsPerDollar,
        if (_pointsExpiryDays != null) 'pointsExpiryDays': _pointsExpiryDays,
        'tiersEnabled': _tiersEnabled,
        if (_bronzeThreshold != null) 'bronzeThreshold': _bronzeThreshold,
        if (_silverThreshold != null) 'silverThreshold': _silverThreshold,
        if (_goldThreshold != null) 'goldThreshold': _goldThreshold,
        if (_platinumThreshold != null) 'platinumThreshold': _platinumThreshold,
        if (_diamondThreshold != null) 'diamondThreshold': _diamondThreshold,
        if (_currentPoints != null) 'currentPoints': _currentPoints,
        if (_currentTier?.isNotEmpty == true) 'currentTier': _currentTier,
        if (_totalEarned != null) 'totalEarned': _totalEarned,
        if (_pointsHistory?.isNotEmpty == true) 'pointsHistory': _pointsHistory,
        if (_rewards?.isNotEmpty == true) 'rewards': _rewards,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? LoyaltyAccount.fromJson({...widget.item!.toJson(), ...data})
        : LoyaltyAccount.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Points Per Dollar', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _pointsPerDollar = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Points Expiry Days', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _pointsExpiryDays = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Tiers Enabled'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _tiersEnabled,
                  onChanged: (v) { ss(() {}); setState(() => _tiersEnabled = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bronze Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _bronzeThreshold = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Silver Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _silverThreshold = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Gold Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _goldThreshold = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Platinum Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _platinumThreshold = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Diamond Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _diamondThreshold = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Points', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _currentPoints = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Current Tier', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currentTier = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Earned', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalEarned = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Points History', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _pointsHistory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rewards', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _rewards = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Loyalty Account'),
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