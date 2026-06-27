import 'dart:io';

class RemainingUIComponentsGenerator {
  static String toCamelCase(String snake) {
    List<String> parts = snake.split('_');
    if (parts.isEmpty) return '';
    String result = parts[0];
    for (int i = 1; i < parts.length; i++) {
        result += parts[i][0].toUpperCase() + parts[i].substring(1);
    }
    return result;
  }

  static Future<void> generateRemainingUIComponents() async {
    final modelsDir = Directory('/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/models');
    
    if (!await modelsDir.exists()) {
      print('Models directory not found');
      return;
    }
    
    final modelFiles = await modelsDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart') && !entity.path.endsWith('models.dart')
    ).cast<File>().toList();
    
    print('Found ${modelFiles.length} model files');
    
    for (final file in modelFiles) {
      final fileName = file.path.split('/').last;
      final snakeCase = fileName.replaceAll('.dart', '');
      final className = await _getClassName(file);
      
      if (className != null) {
        await generateFeatureUIComponents(snakeCase, className);
        print('Generated UI components for: $snakeCase ($className)');
      }
    }
  }

  static Future<String?> _getClassName(File file) async {
    final content = await file.readAsString();
    final match = RegExp(r'class\s+([A-Za-z0-9_]+)').firstMatch(content);
    return match?.group(1);
  }
  
  static Future<void> generateFeatureUIComponents(String snakeCase, String className) async {
    final featureName = snakeCase;
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/features/$featureName');
    final presentationDir = Directory('${featuresDir.path}/presentation');
    final pagesDir = Directory('${presentationDir.path}/pages');
    final widgetsDir = Directory('${presentationDir.path}/widgets');
    
    if (!await featuresDir.exists()) await featuresDir.create(recursive: true);
    if (!await presentationDir.exists()) await presentationDir.create(recursive: true);
    if (!await pagesDir.exists()) await pagesDir.create(recursive: true);
    if (!await widgetsDir.exists()) await widgetsDir.create(recursive: true);
    
    await generateAdminPage(featureName, className, snakeCase, pagesDir);
    await generateClientPage(featureName, className, snakeCase, pagesDir);
    await generateDetailWidget(featureName, className, snakeCase, widgetsDir);
    await generateListWidget(featureName, className, snakeCase, widgetsDir);
    await generateFormWidget(featureName, className, snakeCase, widgetsDir);
  }
  
  static Future<void> generateAdminPage(String featureName, String className, String snakeCase, Directory pagesDir) async {
    final adminPageFile = File('${pagesDir.path}/${snakeCase}_admin_page.dart');
    final camel = toCamelCase(snakeCase);
    final adminPage = '''mobile.leftovers.import'.tr()package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/${snakeCase}_provider.dart';
import 'package:reservatior/shared/models/models.dart' as models;
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/widgets/${snakeCase}_list_widget.dart';
import 'package:reservatior/widgets/${snakeCase}_form_widget.dart';

class ${className}AdminPage extends ConsumerWidget {
  const ${className}AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('${className} Management', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => ref.invalidate(${camel}ListProvider),
          ),
        ],
      ),
      body: const ${className}AdminView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddForm(context),
        label: Text('Add ${className}'),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _showAddForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const ${className}FormWidget(),
      ),
    );
  }
}

class ${className}AdminView extends ConsumerWidget {
  const ${className}AdminView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(${camel}ListProvider);
    return itemsAsync.when(
      data: (data) => Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: ${className}ListWidget(items: data)),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Error: \$e', style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
''';
    await adminPageFile.writeAsString(adminPage);
  }
  
  static Future<void> generateClientPage(String featureName, String className, String snakeCase, Directory pagesDir) async {
    final clientPageFile = File('${pagesDir.path}/${snakeCase}_client_page.dart');
    final camel = toCamelCase(snakeCase);
    final clientPage = '''mobile.leftovers.import'.tr()package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/${snakeCase}_provider.dart';
import 'package:reservatior/shared/models/models.dart' as models;
import 'package:reservatior/widgets/${snakeCase}_list_widget.dart';

class ${className}ClientPage extends ConsumerWidget {
  const ${className}ClientPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(${camel}ListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('My ${className}s', style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: itemsAsync.when(
        data: (data) => SingleChildScrollView(child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ${className}ListWidget(items: data),
        )),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: \$e')),
      ),
    );
  }
}
''';
    await clientPageFile.writeAsString(clientPage);
  }
  
  static Future<void> generateDetailWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final detailWidgetFile = File('${widgetsDir.path}/${snakeCase}_detail_widget.dart');
    final camel = toCamelCase(snakeCase);
    final detailContentFixed = '''mobile.leftovers.import'.tr()package:flutter/material.dart';
import 'package:reservatior/shared/models/models.dart' as models;

class ${className}DetailWidget extends StatelessWidget {
  final models.${className} ${camel};
  const ${className}DetailWidget({super.key, required this.${camel}});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${className} Details', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          Divider(),
          SizedBox(height: 16),
          _InfoRow(label: 'mobile.auto.id'.tr(), value: ${camel}.id.toString()),
          SizedBox(height: 24),
          Center(
            child: Text('Additional information for ${className} will appear here', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text('\$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(value),
    ],
  );
}
''';
    await detailWidgetFile.writeAsString(detailContentFixed);
  }
  
  static Future<void> generateListWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final listWidgetFile = File('${widgetsDir.path}/${snakeCase}_list_widget.dart');
    final camel = toCamelCase(snakeCase);
    final listContent = '''mobile.leftovers.import'.tr()package:flutter/material.dart';
import 'package:reservatior/shared/models/models.dart' as models;
import '${snakeCase}_detail_widget.dart';

class ${className}ListWidget extends StatelessWidget {
  final List<models.${className}> items;
  const ${className}ListWidget({super.key, required this.items});
  
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text('mobile.auto.no_items_found'.tr()));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, i) => _${className}Card(item: items[i]),
    );
  }
}

class _${className}Card extends StatelessWidget {
  final models.${className} item;
  const _${className}Card({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(child: Icon(Icons.info_outline)),
        title: Text(item.id.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('mobile.auto.tap_to_view_details'.tr()),
        trailing: Icon(Icons.chevron_right),
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ${className}DetailWidget(${camel}: item),
        ),
      ),
    );
  }
}
''';
    await listWidgetFile.writeAsString(listContent);
  }
  
  static Future<void> generateFormWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final formWidgetFile = File('${widgetsDir.path}/${snakeCase}_form_widget.dart');
    final formContent = '''mobile.leftovers.import'.tr()package:flutter/material.dart';
import 'package:reservatior/shared/models/models.dart' as models;

class ${className}FormWidget extends StatefulWidget {
  final models.${className}? item;
  const ${className}FormWidget({super.key, this.item});
  @override
  State<${className}FormWidget> createState() => _${className}FormWidgetState();
}

class _${className}FormWidgetState extends State<${className}FormWidget> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.item == null ? 'New ${className}' : 'Edit ${className}', 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            TextFormField(
              initialValue: widget.item?.id?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.id_name'.tr(), border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context),
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
''';
    await formWidgetFile.writeAsString(formContent);
  }
}

void main() async {
  await RemainingUIComponentsGenerator.generateRemainingUIComponents();
}
