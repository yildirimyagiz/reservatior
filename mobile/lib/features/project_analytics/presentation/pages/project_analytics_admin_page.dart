import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/project_analytics_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ProjectAnalytics Admin Page  |  7 fields
// Auto-generated — edit with care
// ================================================================

class ProjectAnalyticsAdminPage extends ConsumerWidget {
  const ProjectAnalyticsAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(projectAnalyticsLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Analytics Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(projectAnalyticsListProvider)),
        ],
      ),
      body: const _ProjectAnalyticsBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ProjectAnalyticsFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Project Analytics'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ProjectAnalyticsBody extends ConsumerStatefulWidget {
  const _ProjectAnalyticsBody({super.key});
  @override ConsumerState<_ProjectAnalyticsBody> createState() => __ProjectAnalyticsBodyState();
}

class __ProjectAnalyticsBodyState extends ConsumerState<_ProjectAnalyticsBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(projectAnalyticsListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Project Analyticss…',
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
              : items.where((item) => ((item.projectId?.toString() ?? '') + " " + (item.analysisType?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Project Analyticss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(projectAnalyticsListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.analysisType != null && item.analysisType!.toString().isNotEmpty ? item.analysisType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.analysisType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(projectAnalyticsListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ProjectAnalytics item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Project Analytics Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Project Id', item.projectId?.toString() ?? 'N/A', Icons.link),
              _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Analysis Data', item.analysisData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Score', item.score?.toString() ?? 'N/A', Icons.numbers),
              _row('Insights', item.insights?.join(', ') ?? 'N/A', Icons.lightbulb_outline),
              _row('Recommendations', item.recommendations?.join(', ') ?? 'N/A', Icons.recommend),
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

void _showForm(BuildContext context, WidgetRef ref, {ProjectAnalytics? item}) {
  showDialog(context: context, builder: (ctx) => _ProjectAnalyticsForm(item: item, ref: ref));
}

class _ProjectAnalyticsForm extends ConsumerStatefulWidget {
  final ProjectAnalytics? item;
  final WidgetRef ref;
  const _ProjectAnalyticsForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ProjectAnalyticsForm> createState() => __ProjectAnalyticsFormState();
}

class __ProjectAnalyticsFormState extends ConsumerState<_ProjectAnalyticsForm> {
  final _key = GlobalKey<FormState>();

  String? _projectId;
  String? _analysisType;
  String? _analysisData;
  List<String>? _insights;
  List<String>? _recommendations;
  double? _score;

  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _analysisData = widget.item?.analysisData?.toString();
    _insights = widget.item?.insights;
    _recommendations = widget.item?.recommendations;
    _score = widget.item?.score;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_projectId?.isNotEmpty == true) 'projectId': _projectId,
      if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
      if (_analysisData?.isNotEmpty == true) 'analysisData': _analysisData,
      if (_insights != null) 'insights': _insights,
      if (_recommendations != null) 'recommendations': _recommendations,
      if (_score != null) 'score': _score,
    };
    if (widget.item == null) {
      widget.ref.read(projectAnalyticsCreateStateProvider.notifier).state = ProjectAnalytics.fromJson(data);
    } else {
      widget.ref.read(projectAnalyticsUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'projectAnalytics': ProjectAnalytics.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Project Analytics' : 'New Project Analytics'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Project Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.projectId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _projectId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.analysisType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.analysisData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Insights', prefixIcon: const Icon(Icons.lightbulb_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.insights?.join(', ') ?? '',
                    maxLines: 2,
                    onSaved: (v) => _insights = v?.isEmpty == true ? null : v?.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Recommendations', prefixIcon: const Icon(Icons.recommend), border: const OutlineInputBorder()),
                    initialValue: widget.item?.recommendations?.join(', ') ?? '',
                    maxLines: 2,
                    onSaved: (v) => _recommendations = v?.isEmpty == true ? null : v?.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.score?.toString() ?? '',
                    onSaved: (v) => _score = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Project Analytics'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ProjectAnalytics item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Project Analytics?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(projectAnalyticsDeleteStateProvider.notifier).state = item.id;
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
