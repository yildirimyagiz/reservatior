import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../shared/providers/automation_rule_provider.dart';
import '../../../../shared/providers/automation_execution_provider.dart';
import '../../../../shared/providers/automation_task_provider.dart';
import 'workflow_builder_screen.dart';

// ── Automation Dashboard Screen ─────────────────────────────────
// Tüm otomasyon kuralları, çalışma geçmişi ve görev monitörü.

class AutomationDashboardScreen extends ConsumerStatefulWidget {
  const AutomationDashboardScreen({super.key});

  @override
  ConsumerState<AutomationDashboardScreen> createState() =>
      _AutomationDashboardScreenState();
}

class _AutomationDashboardScreenState
    extends ConsumerState<AutomationDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  String _filterStatus = 'all';
  String _searchQ = '';
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(automationRuleListProvider);
    final executionsAsync = ref.watch(automationExecutionListProvider);
    final tasksAsync = ref.watch(automationTaskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Otomasyon Merkezi'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard_outlined, size: 18), text: 'Genel Bakış'),
            Tab(icon: Icon(Icons.account_tree_outlined, size: 18), text: 'İş Akışları'),
            Tab(icon: Icon(Icons.history, size: 18), text: 'Çalışma Geçmişi'),
            Tab(icon: Icon(Icons.task_alt, size: 18), text: 'Görevler'),
          ],
        ),
        actions: [
          FilledButton.icon(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const WorkflowBuilderScreen())),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Yeni İş Akışı'),
            style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                visualDensity: VisualDensity.compact),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          // Overview
          _OverviewTab(rulesAsync: rulesAsync, executionsAsync: executionsAsync, tasksAsync: tasksAsync),
          // Workflows
          _WorkflowsTab(
            rulesAsync: rulesAsync,
            filterStatus: _filterStatus,
            searchQ: _searchQ,
            searchCtrl: _searchCtrl,
            onFilterChanged: (v) => setState(() => _filterStatus = v),
            onSearchChanged: (v) => setState(() => _searchQ = v),
          ),
          // Execution history
          _ExecutionHistoryTab(executionsAsync: executionsAsync),
          // Tasks
          _TasksTab(tasksAsync: tasksAsync),
        ],
      ),
    );
  }
}

// ── Overview Tab ───────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  final AsyncValue<List<AutomationRule>> rulesAsync;
  final AsyncValue<List<AutomationExecution>> executionsAsync;
  final AsyncValue<List<AutomationTask>> tasksAsync;

  const _OverviewTab({required this.rulesAsync, required this.executionsAsync, required this.tasksAsync});

  @override
  Widget build(BuildContext context) {
    final rules = rulesAsync.valueOrNull ?? [];
    final executions = executionsAsync.valueOrNull ?? [];
    final tasks = tasksAsync.valueOrNull ?? [];

    final activeRules = rules.where((r) => r.isActive == true).length;
    final successExec = executions.where((e) => e.status == 'success').length;
    final failedExec = executions.where((e) => e.status == 'failed').length;
    final runningTasks = tasks.where((t) => t.status == 'RUNNING').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // KPI Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.7,
          crossAxisSpacing: 12, mainAxisSpacing: 12,
          children: [
            _KpiCard('Toplam İş Akışı', rules.length, Icons.account_tree, Colors.blue),
            _KpiCard('Aktif Kural', activeRules, Icons.play_circle, Colors.green),
            _KpiCard('Başarılı Çalışma', successExec, Icons.check_circle, Colors.teal),
            _KpiCard('Başarısız Çalışma', failedExec, Icons.error_outline, Colors.red),
            _KpiCard('Çalışan Görev', runningTasks, Icons.sync, Colors.orange),
            _KpiCard('Toplam Çalışma', executions.length, Icons.history, Colors.purple),
          ],
        ),

        const SizedBox(height: 20),
        const _SectionTitle('Durum Özeti'),
        Card(child: Column(children: [
          _StatusRow('Aktif Kurallar', activeRules, rules.length, Colors.green),
          _StatusRow('Başarı Oranı',
              successExec, successExec + failedExec, Colors.blue),
          _StatusRow('Görev Sağlığı',
              tasks.where((t) => t.status != 'FAILED').length,
              tasks.length, Colors.teal),
        ])),

        const SizedBox(height: 20),
        const _SectionTitle('Son Çalışmalar'),
        if (executions.isEmpty)
          Card(child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text('Henüz çalışma yok',
                style: TextStyle(color: Colors.grey[500]))),
          ))
        else
          ...executions.take(5).map((e) => _ExecutionTile(execution: e)),

        const SizedBox(height: 20),
        const _SectionTitle('Hızlı İşlemler'),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _QuickAction('Tümünü Duraklat', Icons.pause_circle_outline, Colors.orange, () {}),
          _QuickAction('Tümünü Başlat', Icons.play_circle_outline, Colors.green, () {}),
          _QuickAction('Geçmişi Temizle', Icons.delete_sweep, Colors.red, () {}),
          _QuickAction('Test Modu', Icons.science, Colors.blue, () {}),
        ]),
      ]),
    );
  }
}

// ── Workflows Tab ──────────────────────────────────────────────
class _WorkflowsTab extends StatelessWidget {
  final AsyncValue<List<AutomationRule>> rulesAsync;
  final String filterStatus, searchQ;
  final TextEditingController searchCtrl;
  final void Function(String) onFilterChanged;
  final void Function(String) onSearchChanged;

  const _WorkflowsTab({required this.rulesAsync, required this.filterStatus,
      required this.searchQ, required this.searchCtrl,
      required this.onFilterChanged, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    final all = rulesAsync.valueOrNull ?? [];
    final filtered = all.where((r) {
      if (filterStatus != 'all') {
        final isActive = r.isActive == true;
        if (filterStatus == 'active' && !isActive) return false;
        if (filterStatus == 'inactive' && isActive) return false;
      }
      if (searchQ.isNotEmpty) {
        return (r.ruleName ?? '').toLowerCase().contains(searchQ.toLowerCase()) ||
            (r.ruleType ?? '').toLowerCase().contains(searchQ.toLowerCase());
      }
      return true;
    }).toList();

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
        child: TextField(
          controller: searchCtrl,
          decoration: InputDecoration(
            hintText: 'İş akışı ara…',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: searchQ.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () { searchCtrl.clear(); onSearchChanged(''); })
                : null,
            border: const OutlineInputBorder(), isDense: true,
          ),
          onChanged: onSearchChanged,
        ),
      ),
      // Status filter chips
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(children: [
          for (final s in [('all', 'Tümü'), ('active', 'Aktif'), ('inactive', 'Pasif')])
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(s.$2, style: const TextStyle(fontSize: 12)),
                selected: filterStatus == s.$1,
                onSelected: (_) => onFilterChanged(s.$1),
              ),
            ),
          const Spacer(),
          Text('${filtered.length} kural', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ]),
      ),
      Expanded(
        child: rulesAsync.when(
          data: (_) => filtered.isEmpty
              ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.account_tree, size: 56, color: Colors.grey[350]),
                  const SizedBox(height: 12),
                  Text('Kural bulunamadı', style: TextStyle(color: Colors.grey[500])),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _RuleCard(rule: filtered[i]),
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Hata: $e')),
        ),
      ),
    ]);
  }
}

class _RuleCard extends StatelessWidget {
  final AutomationRule rule;
  const _RuleCard({required this.rule});

  @override
  Widget build(BuildContext context) {
    final isActive = rule.isActive ?? false;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 10, height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.green : Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(rule.ruleName ?? 'İsimsiz Kural',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
            Switch(
              value: isActive,
              onChanged: (_) {},
              activeColor: Colors.green,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            _Chip(rule.ruleType ?? '—', Icons.category, Colors.blue),
            const SizedBox(width: 8),
            _Chip(rule.triggerType ?? '—', Icons.bolt, Colors.orange),
            const Spacer(),
            if (rule.executionCount != null)
              Text('${rule.executionCount} çalışma',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          ]),
          if (rule.lastExecutedAt != null) ...[
            const SizedBox(height: 6),
            Text('Son çalışma: ${_fmtDate(rule.lastExecutedAt)}',
                style: TextStyle(fontSize: 11, color: Colors.grey[500])),
          ],
          const SizedBox(height: 10),
          Row(children: [
            OutlinedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => WorkflowBuilderScreen(existing: rule))),
              icon: const Icon(Icons.edit, size: 14),
              label: const Text('Düzenle', style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  visualDensity: VisualDensity.compact),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, size: 14),
              label: const Text('Test Et', style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  visualDensity: VisualDensity.compact),
            ),
          ]),
        ]),
      ),
    );
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '—';
    return '${d.day}.${d.month}.${d.year} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
  }
}

// ── Execution History Tab ──────────────────────────────────────
class _ExecutionHistoryTab extends StatelessWidget {
  final AsyncValue<List<AutomationExecution>> executionsAsync;
  const _ExecutionHistoryTab({required this.executionsAsync});

  @override
  Widget build(BuildContext context) {
    return executionsAsync.when(
      data: (executions) => executions.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.history, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text('Henüz çalışma geçmişi yok', style: TextStyle(color: Colors.grey[500])),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: executions.length,
              itemBuilder: (_, i) => _ExecutionTile(execution: executions[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }
}

class _ExecutionTile extends StatelessWidget {
  final AutomationExecution execution;
  const _ExecutionTile({required this.execution});

  @override
  Widget build(BuildContext context) {
    final isSuccess = execution.status == 'success';
    final isFailed = execution.status == 'failed';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (isSuccess ? Colors.green : isFailed ? Colors.red : Colors.orange).withOpacity(0.15),
          child: Icon(
            isSuccess ? Icons.check : isFailed ? Icons.close : Icons.sync,
            color: isSuccess ? Colors.green : isFailed ? Colors.red : Colors.orange,
            size: 18,
          ),
        ),
        title: Text(execution.ruleId ?? '—',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(execution.status ?? '—',
              style: TextStyle(
                color: isSuccess ? Colors.green : isFailed ? Colors.red : Colors.orange,
                fontSize: 12, fontWeight: FontWeight.w500,
              )),
          if (execution.executedAt != null)
            Text(_fmtDate(execution.executedAt), style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ]),
        trailing: execution.processingTimeMs != null
            ? Text('${execution.processingTimeMs}ms',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]))
            : null,
      ),
    );
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '—';
    return '${d.day}.${d.month}.${d.year} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
  }
}

// ── Tasks Tab ─────────────────────────────────────────────────
class _TasksTab extends StatelessWidget {
  final AsyncValue<List<AutomationTask>> tasksAsync;
  const _TasksTab({required this.tasksAsync});

  @override
  Widget build(BuildContext context) {
    return tasksAsync.when(
      data: (tasks) => tasks.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.task_alt, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text('Görev yok', style: TextStyle(color: Colors.grey[500])),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (_, i) => _TaskCard(task: tasks[i]),
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Hata: $e')),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final AutomationTask task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final isRunning = task.status == 'RUNNING';
    final isPending = task.status == 'PENDING';
    final isCompleted = task.status == 'COMPLETED';
    final isFailed = task.status == 'FAILED';

    Color color = isRunning ? Colors.orange
        : isCompleted ? Colors.green
        : isFailed ? Colors.red
        : Colors.blue;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(_taskIcon(task.taskType), color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(task.taskType ?? 'Görev', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              if (task.persona != null)
                Text(task.persona!, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (isRunning) ...[
                  SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 2, color: color)),
                  const SizedBox(width: 6),
                ],
                Text(task.status ?? '—',
                    style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            if (task.schedule != null) ...[
              const Icon(Icons.schedule, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(task.schedule!, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              const SizedBox(width: 12),
            ],
            if (task.nextRun != null) ...[
              const Icon(Icons.event, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(_fmtDate(task.nextRun), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ]),
          if (task.command != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(6)),
              child: Text(task.command!, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
            ),
          ],
          if (task.error != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(6)),
              child: Row(children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 14),
                const SizedBox(width: 6),
                Expanded(child: Text(task.error!, style: const TextStyle(color: Colors.red, fontSize: 11))),
              ]),
            ),
          ],
        ]),
      ),
    );
  }

  IconData _taskIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'SCRAPING': return Icons.travel_explore;
      case 'ANALYSIS': return Icons.analytics;
      case 'MONITORING': return Icons.monitor_heart;
      case 'REPORTING': return Icons.assessment;
      default: return Icons.task_alt;
    }
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '—';
    return '${d.day}.${d.month}.${d.year} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
  }
}

// ── Shared helpers ─────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
  );
}

class _KpiCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;
  const _KpiCard(this.label, this.value, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 22),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ])),
    ])),
  );
}

class _StatusRow extends StatelessWidget {
  final String label;
  final int value, total;
  final Color color;
  const _StatusRow(this.label, this.value, this.total, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(children: [
      SizedBox(width: 140, child: Text(label, style: const TextStyle(fontSize: 13))),
      Expanded(child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: total > 0 ? value / total : 0,
          minHeight: 8, backgroundColor: Colors.grey[200], color: color,
        ),
      )),
      const SizedBox(width: 8),
      Text('$value/$total', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _Chip(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: color),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
    ]),
  );
}

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction(this.label, this.icon, this.color, this.onTap);
  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, color: color, size: 16),
    label: Text(label, style: TextStyle(color: color, fontSize: 12)),
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: color.withOpacity(0.4)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
