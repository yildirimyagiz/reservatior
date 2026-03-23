import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_sentiment_analysis_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AISentimentAnalysis Admin Page  |  12 fields
// Auto-generated — edit with care
// ================================================================

class AISentimentAnalysisAdminPage extends ConsumerWidget {
  const AISentimentAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiSentimentAnalysisLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Sentiment Analysis Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiSentimentAnalysisListProvider)),
        ],
      ),
      body: const _AISentimentAnalysisBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AISentimentAnalysisFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Sentiment Analysis'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AISentimentAnalysisBody extends ConsumerStatefulWidget {
  const _AISentimentAnalysisBody();
  @override ConsumerState<_AISentimentAnalysisBody> createState() => __AISentimentAnalysisBodyState();
}

class __AISentimentAnalysisBodyState extends ConsumerState<_AISentimentAnalysisBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiSentimentAnalysisListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Sentiment Analysiss…',
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
              : items.where((item) => '${item.orgId ?? ''} ${item.contentType ?? ''} ${item.contentId ?? ''} ${item.contentText ?? ''} ${item.sentiment ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Sentiment Analysiss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiSentimentAnalysisListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.contentType != null && item.contentType!.isNotEmpty ? item.contentType![0].toUpperCase() : '?'),),
                    title: Text(item.contentType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Sentiment: ${item.sentiment ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiSentimentAnalysisListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AISentimentAnalysis item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Sentiment Analysis Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Content Type', item.contentType?.toString() ?? 'N/A', Icons.notes),
              _row('Content Id', item.contentId?.toString() ?? 'N/A', Icons.link),
              _row('Content Text', item.contentText?.toString() ?? 'N/A', Icons.notes),
              _row('Sentiment', item.sentiment?.toString() ?? 'N/A', Icons.text_fields),
              _row('Sentiment Score', item.sentimentScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Key Phrases', item.keyPhrases?.toString() ?? 'N/A', Icons.text_fields),
              _row('Emotions', item.emotions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Analyzed At', _formatDate(item.analyzedAt), Icons.calendar_today),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {AISentimentAnalysis? item}) {
  showDialog(context: context, builder: (ctx) => _AISentimentAnalysisForm(item: item, ref: ref));
}

class _AISentimentAnalysisForm extends ConsumerStatefulWidget {
  final AISentimentAnalysis? item;
  final WidgetRef ref;
  const _AISentimentAnalysisForm({this.item, required this.ref});
  @override ConsumerState<_AISentimentAnalysisForm> createState() => __AISentimentAnalysisFormState();
}

class __AISentimentAnalysisFormState extends ConsumerState<_AISentimentAnalysisForm> {
  final _key = GlobalKey<FormState>();

  String? _contentType;
  String? _contentId;
  String? _contentText;
  String? _sentiment;
  double? _sentimentScore;
  double? _confidence;
  String? _keyPhrases;
  String? _emotions;
  DateTime? _analyzedAt;

  @override
  void initState() {
    super.initState();
    _contentType = widget.item?.contentType?.toString();
    _contentId = widget.item?.contentId?.toString();
    _contentText = widget.item?.contentText?.toString();
    _sentiment = widget.item?.sentiment?.toString();
    _sentimentScore = widget.item?.sentimentScore;
    _confidence = widget.item?.confidence;
    _keyPhrases = widget.item?.keyPhrases?.toString();
    _emotions = widget.item?.emotions?.toString();
    _analyzedAt = widget.item?.analyzedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_contentType?.isNotEmpty == true) 'contentType': _contentType,
      if (_contentId?.isNotEmpty == true) 'contentId': _contentId,
      if (_contentText?.isNotEmpty == true) 'contentText': _contentText,
      if (_sentiment?.isNotEmpty == true) 'sentiment': _sentiment,
      if (_sentimentScore != null) 'sentimentScore': _sentimentScore,
      if (_confidence != null) 'confidence': _confidence,
      if (_keyPhrases?.isNotEmpty == true) 'keyPhrases': _keyPhrases,
      if (_emotions?.isNotEmpty == true) 'emotions': _emotions,
      if (_analyzedAt != null) 'analyzedAt': _analyzedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(aiSentimentAnalysisCreateStateProvider.notifier).state = AISentimentAnalysis.fromJson(data);
    } else {
      widget.ref.read(aiSentimentAnalysisUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'ai_sentiment_analysis': AISentimentAnalysis.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Sentiment Analysis' : 'New Ai Sentiment Analysis'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content Type', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.contentType ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contentType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.contentId ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content Text', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.contentText ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contentText = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sentiment', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.sentiment ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sentiment = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sentiment Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.sentimentScore?.toString() ?? '',
                    onSaved: (v) => _sentimentScore = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Key Phrases', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.keyPhrases ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyPhrases = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Emotions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.emotions ?? '',
                    maxLines: 1,
                    onSaved: (v) => _emotions = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _analyzedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _analyzedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Analyzed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_analyzedAt != null ? _formatDate(_analyzedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Sentiment Analysis'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AISentimentAnalysis item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Sentiment Analysis?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiSentimentAnalysisDeleteStateProvider.notifier).state = item.id;
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
