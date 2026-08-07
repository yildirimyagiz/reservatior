import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';


class DynamicAdminScreen extends ConsumerStatefulWidget {
  final String modelName;

  const DynamicAdminScreen({super.key, required this.modelName});

  @override
  ConsumerState<DynamicAdminScreen> createState() => _DynamicAdminScreenState();
}

class _DynamicAdminScreenState extends ConsumerState<DynamicAdminScreen> {
  bool isLoading = true;
  Map<String, dynamic>? schema;
  List<dynamic> data = [];
  String? error;

  String _formatValue(String fieldName, dynamic val, BuildContext context) {
    if (val == null) return 'null';
    final strVal = val.toString();
    final lowerName = fieldName.toLowerCase();
    
    // Check if it's a date
    if (strVal.length >= 20 && strVal.contains('T') && strVal.contains('Z')) {
      try {
        final d = DateTime.parse(strVal);
        return DateFormat.yMd(context.locale.toString()).add_Hm().format(d);
      } catch (_) {}
    }
    
    // Check if it's currency
    if (lowerName.contains('price') || lowerName.contains('amount') || lowerName.contains('fee') || lowerName.contains('tax') || lowerName.contains('total')) {
      if (val is num) {
        return NumberFormat.currency(locale: context.locale.toString(), symbol: '').format(val).trim();
      }
    }
    
    return strVal;
  }
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final dio = ref.read(dioClientProvider).dio;
      // Fetch schema
      final schemaRes = await dio.get('/admin/dynamic/schema/${widget.modelName}');
      if (schemaRes.data['error'] != null) {
        throw Exception(schemaRes.data['error']);
      }
      final modelSchema = schemaRes.data['data'];

      // Fetch data
      final dataRes = await dio.get('/admin/dynamic/data/${widget.modelName}');
      final modelData = dataRes.data['data'];

      setState(() {
        schema = modelSchema;
        data = modelData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _deleteRecord(dynamic id) async {
    try {
      final dio = ref.read(dioClientProvider).dio;
      await dio.delete('/admin/dynamic/data/${widget.modelName}/$id');
      _fetchData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mobile.admin.error_deleting'.tr(args: [e.toString()]))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.modelName)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.modelName)),
        body: Center(child: Text('mobile.admin.error_backend'.tr(args: [error ?? '']), textAlign: TextAlign.center)),
      );
    }

    if (schema == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.modelName)),
        body: Center(child: Text('mobile.admin.schema_not_found'.tr())),
      );
    }

    final fields = (schema!['fields'] as List).where((f) => f['type'] == 'String' || f['type'] == 'Int' || f['type'] == 'Boolean' || f['type'] == 'DateTime').toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text('${widget.modelName} ${'mobile.admin.data'.tr()} (${data.length})', style: TextStyle(color: colors.textPrimary)),
        iconTheme: IconThemeData(color: colors.textPrimary),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colors.gold),
            onPressed: _fetchData,
          )
        ],
      ),
      body: data.isEmpty
          ? Center(child: Text('mobile.admin.no_records_found'.tr(), style: TextStyle(color: colors.textSecondary)))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  color: colors.surface,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    title: Text(
                      item['name'] ?? item['title'] ?? item['id']?.toString() ?? 'Record $index',
                      style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('ID: ${item['id']}', style: TextStyle(color: colors.textSecondary)),
                    children: [
                      ...fields.map((f) {
                        final fieldName = f['name'];
                        return ListTile(
                          title: Text(fieldName, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                          subtitle: Text(_formatValue(fieldName, item[fieldName], context), style: TextStyle(color: colors.textPrimary)),
                        );
                      }),
                      OverflowBar(
                        children: [
                          TextButton(
                            onPressed: () => _deleteRecord(item['id']),
                            child: Text('mobile.admin.delete'.tr(), style: TextStyle(color: Colors.red)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.gold,
        onPressed: () {
          // Future: Implement Add Record Dialog using schema fields
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('mobile.admin.add_feature_coming_soon'.tr())));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
