import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../shared/providers/automation_rule_provider.dart';

// ── Workflow Builder Screen ─────────────────────────────────────
// Görsel iş akışı oluşturucu: tetikleyici → koşul → aksiyon zinciri.

class WorkflowBuilderScreen extends ConsumerStatefulWidget {
  final AutomationRule? existing;
  const WorkflowBuilderScreen({super.key, this.existing});

  @override
  ConsumerState<WorkflowBuilderScreen> createState() => _WorkflowBuilderScreenState();
}

class _WorkflowBuilderScreenState extends ConsumerState<WorkflowBuilderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  // Workflow state
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isActive = true;

  _TriggerConfig? _trigger;
  final List<_ConditionConfig> _conditions = [];
  final List<_ActionConfig> _actions = [];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    if (widget.existing != null) {
      _nameCtrl.text = widget.existing!.ruleName ?? '';
      _isActive = widget.existing!.isActive ?? true;
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İş akışı adı zorunlu'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_trigger == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En az bir tetikleyici ekleyin'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_actions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En az bir aksiyon ekleyin'), backgroundColor: Colors.red),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${_nameCtrl.text}" iş akışı kaydedildi'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing != null ? 'İş Akışı Düzenle' : 'Yeni İş Akışı'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            _tabWithBadge('Genel', null),
            _tabWithBadge('Tetikleyici', _trigger != null ? '1' : null),
            _tabWithBadge('Koşullar', _conditions.isNotEmpty ? '${_conditions.length}' : null),
            _tabWithBadge('Aksiyonlar', _actions.isNotEmpty ? '${_actions.length}' : null),
          ],
        ),
        actions: [
          Switch(value: _isActive, onChanged: (v) => setState(() => _isActive = v),
              activeColor: Colors.green),
          const SizedBox(width: 4),
          FilledButton(onPressed: _save, child: const Text('Kaydet')),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(children: [
        // Visual workflow preview bar
        _WorkflowPreviewBar(trigger: _trigger, conditions: _conditions, actions: _actions),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              _GeneralTab(nameCtrl: _nameCtrl, descCtrl: _descCtrl,
                  isActive: _isActive, onActiveChanged: (v) => setState(() => _isActive = v)),
              _TriggerTab(
                trigger: _trigger,
                onChanged: (t) => setState(() => _trigger = t),
              ),
              _ConditionsTab(
                conditions: _conditions,
                onAdd: () => _showAddCondition(context),
                onRemove: (i) => setState(() => _conditions.removeAt(i)),
              ),
              _ActionsTab(
                actions: _actions,
                onAdd: () => _showAddAction(context),
                onRemove: (i) => setState(() => _actions.removeAt(i)),
                onReorder: (o, n) => setState(() {
                  final item = _actions.removeAt(o);
                  _actions.insert(n, item);
                }),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Tab _tabWithBadge(String label, String? badge) => Tab(
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(label),
      if (badge != null) ...[
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ],
    ]),
  );

  void _showAddCondition(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _AddConditionSheet(
        onAdd: (c) { setState(() => _conditions.add(c)); Navigator.pop(ctx); },
      ),
    );
  }

  void _showAddAction(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _AddActionSheet(
        onAdd: (a) { setState(() => _actions.add(a)); Navigator.pop(ctx); },
      ),
    );
  }
}

// ── Workflow Preview Bar ───────────────────────────────────────
class _WorkflowPreviewBar extends StatelessWidget {
  final _TriggerConfig? trigger;
  final List<_ConditionConfig> conditions;
  final List<_ActionConfig> actions;

  const _WorkflowPreviewBar({required this.trigger, required this.conditions, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          _PreviewNode(
            icon: Icons.bolt,
            label: trigger?.label ?? 'Tetikleyici',
            color: trigger != null ? Colors.orange : Colors.grey[400]!,
            isEmpty: trigger == null,
          ),
          if (conditions.isNotEmpty) ...[
            _Arrow(),
            ...conditions.map((c) => Row(children: [
              _PreviewNode(icon: Icons.rule, label: c.label, color: Colors.blue),
              if (c != conditions.last) _Arrow(),
            ])),
          ],
          _Arrow(),
          ...actions.map((a) => Row(children: [
            _PreviewNode(icon: a.icon, label: a.label, color: Colors.green),
            if (a != actions.last) _Arrow(),
          ])),
          if (actions.isEmpty)
            _PreviewNode(icon: Icons.play_arrow, label: 'Aksiyon', color: Colors.grey[400]!, isEmpty: true),
        ]),
      ),
    );
  }
}

class _PreviewNode extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isEmpty;
  const _PreviewNode({required this.icon, required this.label, required this.color, this.isEmpty = false});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isEmpty ? Colors.transparent : color.withOpacity(0.12),
      border: Border.all(color: isEmpty ? Colors.grey[300]! : color.withOpacity(0.4),
          style: isEmpty ? BorderStyle.none : BorderStyle.solid),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: isEmpty ? Colors.grey[400] : color),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 12, color: isEmpty ? Colors.grey[400] : color,
          fontWeight: FontWeight.w500)),
    ]),
  );
}

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.arrow_forward, size: 14, color: Colors.grey[400]),
  );
}

// ── General Tab ────────────────────────────────────────────────
class _GeneralTab extends StatelessWidget {
  final TextEditingController nameCtrl, descCtrl;
  final bool isActive;
  final void Function(bool) onActiveChanged;

  const _GeneralTab({required this.nameCtrl, required this.descCtrl,
      required this.isActive, required this.onActiveChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextFormField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: 'İş Akışı Adı *',
              prefixIcon: Icon(Icons.account_tree), border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: descCtrl,
          decoration: const InputDecoration(labelText: 'Açıklama',
              prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
          maxLines: 3,
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          title: const Text('İş Akışı Aktif'),
          subtitle: const Text('Devre dışı bırakılırsa tetikleyiciler çalışmaz'),
          value: isActive,
          onChanged: onActiveChanged,
          secondary: Icon(isActive ? Icons.play_circle : Icons.pause_circle,
              color: isActive ? Colors.green : Colors.grey),
        ),
        const SizedBox(height: 24),
        const _InfoBox(
          'İş akışları, belirli olaylar gerçekleştiğinde otomatik aksiyonlar alır. '
          'Tetikleyici → Koşullar (opsiyonel) → Aksiyonlar şeklinde yapılandırın.',
          Icons.info_outline, Colors.blue,
        ),
      ]),
    );
  }
}

// ── Trigger Tab ────────────────────────────────────────────────
class _TriggerTab extends StatelessWidget {
  final _TriggerConfig? trigger;
  final void Function(_TriggerConfig) onChanged;

  const _TriggerTab({required this.trigger, required this.onChanged});

  static const _triggers = [
    _TriggerDef('Oluşturulduğunda', 'on_create', Icons.add_circle_outline, Colors.green, 'Yeni kayıt oluşturulduğunda tetiklenir'),
    _TriggerDef('Güncellendiğinde', 'on_update', Icons.edit, Colors.blue, 'Kayıt güncellendiğinde tetiklenir'),
    _TriggerDef('Silindiğinde', 'on_delete', Icons.delete_outline, Colors.red, 'Kayıt silindiğinde tetiklenir'),
    _TriggerDef('Durum Değişince', 'on_status_change', Icons.sync_alt, Colors.orange, 'Durum alanı değiştiğinde tetiklenir'),
    _TriggerDef('Alan Değişince', 'on_field_change', Icons.edit_note, Colors.purple, 'Belirli bir alan değiştiğinde tetiklenir'),
    _TriggerDef('Tarih Gelince', 'on_date_reached', Icons.event, Colors.teal, 'Belirlenen tarih geldiğinde tetiklenir'),
    _TriggerDef('Zamanlanmış', 'on_schedule', Icons.schedule, Colors.indigo, 'Cron zamanlamasıyla tetiklenir'),
    _TriggerDef('Webhook', 'on_webhook', Icons.webhook, Colors.brown, 'Harici webhook isteği geldiğinde tetiklenir'),
    _TriggerDef('API Çağrısı', 'on_api_call', Icons.api, Colors.blueGrey, 'API endpoint\'i çağrıldığında tetiklenir'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tetikleyici Türü Seçin', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Bir tetikleyici seçilince iş akışı otomatik başlar.',
            style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 16),
        ..._triggers.map((t) {
          final isSelected = trigger?.type == t.type;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: isSelected ? t.color.withOpacity(0.08) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: isSelected ? t.color : Colors.transparent,
                width: isSelected ? 2 : 0,
              ),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: t.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(t.icon, color: t.color, size: 20),
              ),
              title: Text(t.label, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(t.desc, style: const TextStyle(fontSize: 12)),
              trailing: isSelected ? Icon(Icons.check_circle, color: t.color) : null,
              onTap: () => onChanged(_TriggerConfig(label: t.label, type: t.type, icon: t.icon, color: t.color)),
            ),
          );
        }),
        if (trigger != null && (trigger!.type == 'on_schedule')) ...[
          const SizedBox(height: 16),
          const Text('Zamanlama (Cron)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            _CronChip('Her saat', '0 * * * *'),
            _CronChip('Her gün 09:00', '0 9 * * *'),
            _CronChip('Her hafta Pazartesi', '0 9 * * 1'),
            _CronChip('Her ay 1.', '0 9 1 * *'),
          ]),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Özel Cron İfadesi',
                hintText: '0 9 * * *', border: OutlineInputBorder(),
                helperText: 'dakika saat gün ay haftanın_günü'),
          ),
        ],
      ]),
    );
  }
}

class _CronChip extends StatelessWidget {
  final String label, value;
  const _CronChip(this.label, this.value);
  @override
  Widget build(BuildContext context) => ActionChip(
    label: Text(label, style: const TextStyle(fontSize: 12)),
    onPressed: () {},
  );
}

// ── Conditions Tab ─────────────────────────────────────────────
class _ConditionsTab extends StatelessWidget {
  final List<_ConditionConfig> conditions;
  final VoidCallback onAdd;
  final void Function(int) onRemove;

  const _ConditionsTab({required this.conditions, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (conditions.isEmpty)
        Expanded(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.rule, size: 56, color: Colors.grey[350]),
          const SizedBox(height: 12),
          Text('Koşul eklenmedi', style: TextStyle(color: Colors.grey[500])),
          const SizedBox(height: 8),
          const Text('Koşullar opsiyoneldir. Eklenmezse\ntüm durumlarda çalışır.',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Koşul Ekle')),
        ])))
      else
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: conditions.length,
          itemBuilder: (_, i) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.rule, color: Colors.blue, size: 20),
              ),
              title: Text(conditions[i].label, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${conditions[i].field} ${conditions[i].operator} "${conditions[i].value}"',
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => onRemove(i)),
            ),
          ),
        )),
      Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(width: double.infinity, child: OutlinedButton.icon(
          onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Koşul Ekle'),
        )),
      ),
    ]);
  }
}

// ── Actions Tab ────────────────────────────────────────────────
class _ActionsTab extends StatelessWidget {
  final List<_ActionConfig> actions;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  final void Function(int, int) onReorder;

  const _ActionsTab({required this.actions, required this.onAdd,
      required this.onRemove, required this.onReorder});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (actions.isEmpty)
        Expanded(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.play_circle_outline, size: 56, color: Colors.grey[350]),
          const SizedBox(height: 12),
          Text('Aksiyon eklenmedi', style: TextStyle(color: Colors.grey[500])),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Aksiyon Ekle')),
        ])))
      else
        Expanded(child: ReorderableListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: actions.length,
          onReorder: onReorder,
          itemBuilder: (_, i) => Card(
            key: ValueKey(i),
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: actions[i].color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(actions[i].icon, color: actions[i].color, size: 20),
              ),
              title: Text(actions[i].label, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(actions[i].description, style: const TextStyle(fontSize: 12)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                ReorderableDragStartListener(index: i, child: const Icon(Icons.drag_handle, color: Colors.grey)),
                IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () => onRemove(i)),
              ]),
            ),
          ),
        )),
      Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(width: double.infinity, child: OutlinedButton.icon(
          onPressed: onAdd, icon: const Icon(Icons.add), label: const Text('Aksiyon Ekle'),
        )),
      ),
    ]);
  }
}

// ── Add Condition Sheet ────────────────────────────────────────
class _AddConditionSheet extends StatefulWidget {
  final void Function(_ConditionConfig) onAdd;
  const _AddConditionSheet({required this.onAdd});
  @override State<_AddConditionSheet> createState() => _AddConditionSheetState();
}

class _AddConditionSheetState extends State<_AddConditionSheet> {
  final _fieldCtrl = TextEditingController();
  final _valueCtrl = TextEditingController();
  String _operator = 'equals';

  final _operators = ['equals', 'not_equals', 'contains', 'starts_with', 'ends_with',
      'greater_than', 'less_than', 'is_empty', 'is_not_empty'];

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 20),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Koşul Ekle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      TextFormField(controller: _fieldCtrl,
          decoration: const InputDecoration(labelText: 'Alan Adı', hintText: 'status, amount, type...', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: _operator,
        decoration: const InputDecoration(labelText: 'Operatör', border: OutlineInputBorder()),
        items: _operators.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
        onChanged: (v) => setState(() => _operator = v!),
      ),
      const SizedBox(height: 12),
      if (!['is_empty', 'is_not_empty'].contains(_operator))
        TextFormField(controller: _valueCtrl,
            decoration: const InputDecoration(labelText: 'Değer', border: OutlineInputBorder())),
      const SizedBox(height: 20),
      SizedBox(width: double.infinity, child: FilledButton(
        onPressed: () {
          if (_fieldCtrl.text.isEmpty) return;
          widget.onAdd(_ConditionConfig(
            label: '${_fieldCtrl.text} $_operator ${_valueCtrl.text}',
            field: _fieldCtrl.text, operator: _operator, value: _valueCtrl.text,
          ));
        },
        child: const Text('Koşul Ekle'),
      )),
      const SizedBox(height: 12),
    ]),
  );
}

// ── Add Action Sheet ───────────────────────────────────────────
class _AddActionSheet extends StatelessWidget {
  final void Function(_ActionConfig) onAdd;
  const _AddActionSheet({required this.onAdd});

  static const _actionDefs = [
    _ActionDef('E-posta Gönder', Icons.email, Colors.blue, 'Belirtilen alıcılara e-posta gönder'),
    _ActionDef('SMS Gönder', Icons.sms, Colors.green, 'Telefon numarasına SMS gönder'),
    _ActionDef('Bildirim Gönder', Icons.notifications, Colors.orange, 'Push bildirimi gönder'),
    _ActionDef('Görev Oluştur', Icons.task_alt, Colors.purple, 'Otomatik görev oluştur'),
    _ActionDef('Durum Güncelle', Icons.sync_alt, Colors.teal, 'Kayıt durumunu değiştir'),
    _ActionDef('Alan Güncelle', Icons.edit, Colors.indigo, 'Belirli bir alanı güncelle'),
    _ActionDef('Webhook Çağır', Icons.webhook, Colors.brown, 'Harici URL\'e POST isteği gönder'),
    _ActionDef('Rapor Oluştur', Icons.assessment, Colors.red, 'Otomatik rapor üret'),
    _ActionDef('Kullanıcı Ata', Icons.person_add, Colors.cyan, 'Kaydı bir kullanıcıya ata'),
    _ActionDef('Etiket Ekle', Icons.label, Colors.amber, 'Kayda etiket ekle'),
    _ActionDef('Bekleme', Icons.hourglass_empty, Colors.grey, 'Belirtilen süre bekle'),
    _ActionDef('Alt İş Akışı Çalıştır', Icons.account_tree, Colors.deepPurple, 'Başka bir iş akışını tetikle'),
  ];

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.7, minChildSize: 0.4, maxChildSize: 0.9, expand: false,
    builder: (ctx, sc) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Aksiyon Seç', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Expanded(child: ListView.builder(
          controller: sc,
          itemCount: _actionDefs.length,
          itemBuilder: (_, i) {
            final a = _actionDefs[i];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: a.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(a.icon, color: a.color, size: 20),
              ),
              title: Text(a.label, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(a.desc, style: const TextStyle(fontSize: 12)),
              onTap: () => onAdd(_ActionConfig(
                label: a.label, icon: a.icon, color: a.color, description: a.desc,
              )),
            );
          },
        )),
      ]),
    ),
  );
}

// ── Shared helpers ─────────────────────────────────────────────

class _InfoBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _InfoBox(this.text, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.07),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 10),
      Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700]))),
    ]),
  );
}

// ── Data classes ───────────────────────────────────────────────

class _TriggerConfig {
  final String label, type;
  final IconData icon;
  final Color color;
  const _TriggerConfig({required this.label, required this.type, required this.icon, required this.color});
}

class _ConditionConfig {
  final String label, field, operator, value;
  const _ConditionConfig({required this.label, required this.field, required this.operator, required this.value});
}

class _ActionConfig {
  final String label, description;
  final IconData icon;
  final Color color;
  const _ActionConfig({required this.label, required this.icon, required this.color, required this.description});
}

class _TriggerDef {
  final String label, type, desc;
  final IconData icon;
  final Color color;
  const _TriggerDef(this.label, this.type, this.icon, this.color, this.desc);
}

class _ActionDef {
  final String label, desc;
  final IconData icon;
  final Color color;
  const _ActionDef(this.label, this.icon, this.color, this.desc);
}
