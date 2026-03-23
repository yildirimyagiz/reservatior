import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_recommendation_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIRecommendation Admin Page
// Auto-generated — edit with care
// ================================================================

class AIRecommendationAdminPage extends ConsumerWidget {
  const AIRecommendationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiRecommendationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Recommendation Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiRecommendationListProvider)),
        ],
      ),
      body: const _AIRecommendationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIRecommendationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Recommendation'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIRecommendationBody extends ConsumerStatefulWidget {
  const _AIRecommendationBody();
  @override ConsumerState<_AIRecommendationBody> createState() => __AIRecommendationBodyState();
}

class __AIRecommendationBodyState extends ConsumerState<_AIRecommendationBody> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(aiRecommendationListProvider);
    return Column(children: [
      // Search bar
      Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search recommendations...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _ctrl.text.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () {
                    _ctrl.clear(); setState(() => _query = '');
                  })
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            filled: true, fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
          onChanged: (val) => setState(() => _query = val.toLowerCase()),
        ),
      ),
      Expanded(child: listAsync.when(
        data: (items) {
          if (items.isEmpty) return const Center(child: Text('No recommendations found. Tap + to create one.'));
          final filtered = _query.isEmpty ? items : items.where((e) {
            return (e.id?.toLowerCase().contains(_query) ?? false) ||
                   (e.userId?.toLowerCase().contains(_query) ?? false) ||
                   (e.recommendationType?.toLowerCase().contains(_query) ?? false);
          }).toList();
          if (filtered.isEmpty) return Center(child: Text('No results for "$_query"'));
          return ListView.builder(
            itemCount: filtered.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (ctx, i) => _buildCard(ctx, ref, filtered[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $e', style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            onPressed: () => ref.invalidate(aiRecommendationListProvider),
          ),
        ])),
      )),
    ]);
  }

  Widget _buildCard(BuildContext context, WidgetRef ref, AIRecommendation item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Text((item.userId?.substring(0, 1) ?? 'R').toUpperCase(),
            style: const TextStyle(color: Colors.white)),
        ),
        title: Text('${item.recommendationType ?? "Recommendation"}'),
        subtitle: Text('User: ${item.userId ?? "N/A"}\n${item.generatedAt?.toString().substring(0, 10) ?? "N/A"}'),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (val) {
            if (val == 'view') _showDetail(context, ref, item);
            else if (val == 'edit') _showForm(context, ref, existing: item);
            else if (val == 'delete') _confirmDelete(context, ref, item);
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'view', child: Row(children: [Icon(Icons.visibility), SizedBox(width: 8), Text('View')])),
            const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit')])),
            const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.red))])),
          ],
        ),
        onTap: () => _showDetail(context, ref, item),
      ),
    );
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, WidgetRef ref, AIRecommendation item) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              color: Colors.blueGrey[800],
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                const Icon(Icons.recommend, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(child: Text('Recommendation Details', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
              ]),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('ID', item.id ?? 'N/A'),
                    _detailRow('User Type', item.userType ?? 'N/A'),
                    _detailRow('User ID', item.userId ?? 'N/A'),
                    _detailRow('Session ID', item.sessionId ?? 'N/A'),
                    _detailRow('Type', item.recommendationType ?? 'N/A'),
                    _detailRow('Recommended Properties', item.recommendedProperties?.toString() ?? 'N/A'),
                    _detailRow('User Preferences', item.userPreferences?.toString() ?? 'N/A'),
                    _detailRow('Reasoning', item.reasoning?.toString() ?? 'N/A'),
                    _detailRow('Generated At', item.generatedAt?.toString() ?? 'N/A'),
                    _detailRow('Expires At', item.expiresAt?.toString() ?? 'N/A'),
                    _detailRow('Created At', item.createdAt?.toString() ?? 'N/A'),
                  ],
                ),
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    onPressed: () {
                      Navigator.pop(context);
                      _showForm(context, ref, existing: item);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {AIRecommendation? existing}) {
  final isEdit = existing != null;
  final formKey = GlobalKey<FormState>();
  
  final userTypeCtrl = TextEditingController(text: existing?.userType ?? '');
  final userIdCtrl = TextEditingController(text: existing?.userId ?? '');
  final sessionIdCtrl = TextEditingController(text: existing?.sessionId ?? '');
  final recommendationTypeCtrl = TextEditingController(text: existing?.recommendationType ?? '');
  final recommendedPropertiesCtrl = TextEditingController(text: existing?.recommendedProperties?.toString() ?? '');
  final userPreferencesCtrl = TextEditingController(text: existing?.userPreferences?.toString() ?? '');
  final reasoningCtrl = TextEditingController(text: existing?.reasoning?.toString() ?? '');

  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.blueGrey[800],
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Icon(isEdit ? Icons.edit : Icons.add, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('${isEdit ? "Edit" : "New"} Recommendation', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
              ]),
            ),
            // Form
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      controller: userTypeCtrl,
                      decoration: const InputDecoration(labelText: 'User Type', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: userIdCtrl,
                      decoration: const InputDecoration(labelText: 'User ID *', border: OutlineInputBorder()),
                      validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: sessionIdCtrl,
                      decoration: const InputDecoration(labelText: 'Session ID', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: recommendationTypeCtrl,
                      decoration: const InputDecoration(labelText: 'Recommendation Type', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: recommendedPropertiesCtrl,
                      decoration: const InputDecoration(labelText: 'Recommended Properties (JSON)', border: OutlineInputBorder()),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: userPreferencesCtrl,
                      decoration: const InputDecoration(labelText: 'User Preferences (JSON)', border: OutlineInputBorder()),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: reasoningCtrl,
                      decoration: const InputDecoration(labelText: 'Reasoning', border: OutlineInputBorder()),
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  Consumer(
                    builder: (ctx, ref, _) {
                      final loading = ref.watch(aiRecommendationLoadingProvider);
                      return ElevatedButton.icon(
                        icon: loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save),
                        label: Text(isEdit ? 'Update' : 'Create'),
                        onPressed: loading ? null : () {
                          if (!formKey.currentState!.validate()) return;
                          
                          final data = {
                            if (userTypeCtrl.text.isNotEmpty) 'userType': userTypeCtrl.text,
                            if (userIdCtrl.text.isNotEmpty) 'userId': userIdCtrl.text,
                            if (sessionIdCtrl.text.isNotEmpty) 'sessionId': sessionIdCtrl.text,
                            if (recommendationTypeCtrl.text.isNotEmpty) 'recommendationType': recommendationTypeCtrl.text,
                            if (recommendedPropertiesCtrl.text.isNotEmpty) 'recommendedProperties': recommendedPropertiesCtrl.text,
                            if (userPreferencesCtrl.text.isNotEmpty) 'userPreferences': userPreferencesCtrl.text,
                            if (reasoningCtrl.text.isNotEmpty) 'reasoning': reasoningCtrl.text,
                          };

                          if (isEdit) {
                            ref.read(aiRecommendationUpdateStateProvider.notifier).state = {
                              'id': existing.id,
                              'ai_recommendation': data,
                            };
                            ref.invalidate(aiRecommendationUpdateProvider);
                          } else {
                            ref.read(aiRecommendationCreateStateProvider.notifier).state = AIRecommendation.fromJson(data);
                            ref.invalidate(aiRecommendationCreateProvider);
                          }
                          Navigator.pop(ctx);
                          ref.invalidate(aiRecommendationListProvider);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDelete(BuildContext context, WidgetRef ref, AIRecommendation item) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Delete Recommendation'),
      content: Text('Are you sure you want to delete this recommendation for user ${item.userId}?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        Consumer(
          builder: (ctx, ref, _) {
            final loading = ref.watch(aiRecommendationLoadingProvider);
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: loading ? null : () {
                ref.read(aiRecommendationDeleteStateProvider.notifier).state = item.id;
                ref.invalidate(aiRecommendationDeleteProvider);
                Navigator.pop(ctx);
                ref.invalidate(aiRecommendationListProvider);
              },
              child: loading 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Delete'),
            );
          },
        ),
      ],
    ),
  );
}
