import 'dart:io';

class RemainingUIComponentsGenerator {
  static Future<void> generateRemainingUIComponents() async {
    final modelsDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/gen_models/models');
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/features');
    
    if (!await modelsDir.exists()) {
      print('Models directory not found');
      return;
    }
    
    final modelFiles = await modelsDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart')
    ).cast<File>().toList();
    
    print('Found ${modelFiles.length} model files');
    
    // Features that already have UI components
    final completedFeatures = [
      'user', 'property', 'booking', 'organization'
    ];
    
    for (final file in modelFiles) {
      final fileName = file.path.split('/').last;
      final modelName = fileName.replaceAll('.dart', '');
      
      if (!completedFeatures.contains(modelName)) {
        await generateFeatureUIComponents(modelName);
        print('Generated UI components for: $modelName');
      }
    }
    
    print('Remaining UI components generation completed!');
  }
  
  static Future<void> generateFeatureUIComponents(String featureName) async {
    final snakeCase = featureName;
    final className = featureName.split('_').map((part) => 
      part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1)
    ).join('');
    
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/features/$featureName');
    final presentationDir = Directory('${featuresDir.path}/presentation');
    final pagesDir = Directory('${presentationDir.path}/pages');
    final widgetsDir = Directory('${presentationDir.path}/widgets');
    
    // Create directories
    if (!await featuresDir.exists()) {
      await featuresDir.create(recursive: true);
    }
    if (!await presentationDir.exists()) {
      await presentationDir.create(recursive: true);
    }
    if (!await pagesDir.exists()) {
      await pagesDir.create(recursive: true);
    }
    if (!await widgetsDir.exists()) {
      await widgetsDir.create(recursive: true);
    }
    
    // Generate admin and client pages
    await generateAdminPage(featureName, className, snakeCase, pagesDir);
    await generateClientPage(featureName, className, snakeCase, pagesDir);
    await generateDetailWidget(featureName, className, snakeCase, widgetsDir);
    await generateListWidget(featureName, className, snakeCase, widgetsDir);
    await generateFormWidget(featureName, className, snakeCase, widgetsDir);
  }
  
  static Future<void> generateAdminPage(String featureName, String className, String snakeCase, Directory pagesDir) async {
    final adminPageFile = File('${pagesDir.path}/${snakeCase}_admin_page.dart');
    
    final adminContent = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/${snakeCase}_provider.dart';

// Admin Panel for ${className} Management
class ${className}AdminPage extends ConsumerWidget {
  const ${className}AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${className} Management'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _refreshData(context),
          ),
        ],
      ),
      body: const ${className}AdminView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreate${className}Dialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ${className}AdminView extends ConsumerWidget {
  const ${className}AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final ${snakeCase}sAsync = ref.watch(${snakeCase}ListProvider);
    final create${className}Async = ref.watch(${snakeCase}CreateProvider);
    final update${className}Async = ref.watch(${snakeCase}UpdateProvider);
    final delete${className}Async = ref.watch(${snakeCase}DeleteProvider);
    final isLoading = ref.watch(${snakeCase}LoadingProvider);

    return RefreshIndicator(
      onRefresh: () => _refreshData(context),
      child: ${snakeCase}sAsync.when(
        data: (${className}s) => _build${className}sList(context, ${className}s),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error) => Center(
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error: \$error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _refreshData(context),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _build${className}sList(BuildContext context, List ${className}s) {
    if (${className}s.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            const Text(
              'No ${className}s found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showCreate${className}Dialog(context),
              child: const Text('Create ${className}'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                context,
                'Total ${className}s',
                '${className}s.length}',
                Icons.list_alt,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                context,
                'Active ${className}s',
                '${className}s.where((c) => c.isActive).length}',
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // ${className}s List
        Expanded(
          child: ListView.builder(
            itemCount: ${className}s.length,
            itemBuilder: (context, index) {
              final ${snakeCase} = ${className}s[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(${snakeCase}.name?.substring(0, 1).toUpperCase() ?? '?'),
                  ),
                  title: Text(${snakeCase}.name ?? 'Unknown'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_formatDate(${snakeCase}.createdAt)),
                      Text(
                        'Status: \${_get${className}Status(${snakeCase})}',
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(${snakeCase}),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEdit${className}Dialog(context, ${snakeCase}),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _showDelete${className}Dialog(context, ${snakeCase}),
                      ),
                      Switch(
                        value: ${snakeCase}.isActive ?? false,
                        onChanged: (value) => _toggle${className}Status(${snakeCase}, value),
                      ),
                    ],
                  ),
                  onTap: () => _show${className}DetailsDialog(context, ${snakeCase}),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreate${className}Dialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create ${className}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final new${className} = ${className}(
                name: nameController.text,
                email: emailController.text,
                isActive: true,
              );
              // Call create provider
              ref.read(${snakeCase}CreateProvider.notifier).state = new${className};
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEdit${className}Dialog(BuildContext context, ${className} ${snakeCase}) {
    final nameController = TextEditingController(text: ${snakeCase}.name);
    final emailController = TextEditingController(text: ${snakeCase}.email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit ${className}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final updated${className} = ${snakeCase}.copyWith(
                name: nameController.text,
                email: emailController.text,
              );
              // Call update provider
              ref.read(${snakeCase}UpdateProvider.notifier).state = {
                'id': ${snakeCase}.id!,
                '${snakeCase}': updated${className},
              };
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDelete${className}Dialog(BuildContext context, ${className} ${snakeCase}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete ${className}'),
        content: Text('Are you sure you want to delete \${${snakeCase}.name ?? 'this ${className}'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Call delete provider
              ref.read(${snakeCase}DeleteProvider.notifier).state = ${snakeCase}.id!;
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _show${className}DetailsDialog(BuildContext context, ${className} ${snakeCase}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(${snakeCase}.name ?? '${className} Details'),
        content: SingleChildScrollView(
          child: ${className}DetailWidget(${snakeCase}: ${snakeCase}),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _refreshData(BuildContext context) {
    // Call refresh provider
    ref.read(${snakeCase}ListProvider.notifier).refresh();
  }

  void _toggle${className}Status(${className} ${snakeCase}, bool isActive) {
    final updated${className} = ${snakeCase}.copyWith(isActive: isActive);
    // Call update provider
    ref.read(${snakeCase}UpdateProvider.notifier).state = {
      'id': ${snakeCase}.id!,
      '${snakeCase}': updated${className},
    };
  }

  String _get${className}Status(${className} ${snakeCase}) {
    // Logic to determine status
    if (${snakeCase}.isActive == false) return 'Inactive';
    return 'Active';
  }

  Color _getStatusColor(${className} ${snakeCase}) {
    final status = _get${className}Status(${snakeCase});
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '\${date.day}/\${date.month}/\${date.year}';
  }
}
''';
    
    await adminPageFile.writeAsString(adminContent);
  }
  
  static Future<void> generateClientPage(String featureName, String className, String snakeCase, Directory pagesDir) async {
    final clientPageFile = File('${pagesDir.path}/${snakeCase}_client_page.dart');
    
    final clientContent = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/${snakeCase}_provider.dart';

// Client Panel for ${className} Management
class ${className}ClientPage extends ConsumerWidget {
  const ${className}ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ${className}s'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: const ${className}ClientView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreate${className}Dialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ${className}ClientView extends ConsumerWidget {
  const ${className}ClientView({super.key});

  @override
  Widget build(BuildContext context) {
    final user${className}sAsync = ref.watch(${snakeCase}ListProvider);
    final create${className}Async = ref.watch(${snakeCase}CreateProvider);
    final update${className}Async = ref.watch(${snakeCase}UpdateProvider);
    final delete${className}Async = ref.watch(${snakeCase}DeleteProvider);

    return Column(
      children: [
        // Search and Filter Bar
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search ${className}s...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // Implement search logic
                    },
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showFilterDialog(context),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // ${className}s Grid View
        Expanded(
          child: user${className}sAsync.when(
            data: (${className}s) => _build${className}sGrid(context, ${className}s),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error) => Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text('Error: \$error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _refreshData(context),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _build${className}sGrid(BuildContext context, List ${className}s) {
    if (${className}s.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            const Text(
              'No ${className}s found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showCreate${className}Dialog(context),
              child: const Text('Create ${className}'),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
      itemCount: ${className}s.length,
      itemBuilder: (context, index) {
        final ${snakeCase} = ${className}s[index];
        return Card(
          child: InkWell(
            onTap: () => _show${className}DetailsDialog(context, ${snakeCase}),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _getStatusColor(${snakeCase}),
                    child: Text(
                      ${snakeCase}.name?.substring(0, 1).toUpperCase() ?? '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ${snakeCase}.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(${snakeCase}.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCreate${className}Dialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New ${className}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final new${className} = ${className}(
                name: nameController.text,
                email: emailController.text,
                isActive: true,
              );
              // Call create provider
              ref.read(${snakeCase}CreateProvider.notifier).state = new${className};
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _show${className}DetailsDialog(BuildContext context, ${className} ${snakeCase}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(${snakeCase}.name ?? '${className} Details'),
        content: SingleChildScrollView(
          child: ${className}DetailWidget(${snakeCase}: ${snakeCase}),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _refreshData(BuildContext context) {
    // Call refresh provider
    ref.read(${snakeCase}ListProvider.notifier).refresh();
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search ${className}s'),
        content: const Text('Search functionality will go here...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter ${className}s'),
        content: const Text('Filter functionality will go here...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
''';
    
    await clientPageFile.writeAsString(clientContent);
  }
  
  static Future<void> generateDetailWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final detailWidgetFile = File('${widgetsDir.path}/${snakeCase}_detail_widget.dart');
    
    final detailContent = '''import 'package:flutter/material.dart';
import '../../gen_models/models_library.dart';

class ${className}DetailWidget extends StatelessWidget {
  final ${className} ${snakeCase};

  const ${className}DetailWidget({
    super.key,
    required this.${snakeCase},
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ${snakeCase}.name ?? 'Unknown ${className}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('ID', ${snakeCase}.id ?? 'N/A'),
            _buildDetailRow('Status', _get${className}Status(${snakeCase})),
            _buildDetailRow('Created', _formatDate(${snakeCase}.createdAt)),
            if (${snakeCase}.updatedAt != null)
              _buildDetailRow('Updated', _formatDate(${snakeCase}.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              view,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _get${className}Status(${className} ${snakeCase}) {
    // Logic to determine status
    if (${snakeCase}.isActive == false) return 'Inactive';
    return 'Active';
  }

  Color _getStatusColor(${className} ${snakeCase}) {
    final status = _get${className}Status(${snakeCase});
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '\${date.day}/\${date.month}/\${date.year}';
  }
}
''';
    
    await detailWidgetFile.writeAsString(detailContent);
  }
  
  static Future<void> generateListWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final listWidgetFile = File('${widgetsDir.path}/${snakeCase}_list_widget.dart');
    
    final listContent = '''import 'package:flutter/material.dart';
import '../../gen_models/models_library.dart';

class ${className}ListWidget extends StatelessWidget {
  final List<${className}> ${className}s;
  final Function(${className})? onTap;

  const ${className}ListWidget({
    super.key,
    required this.${className}s,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ${className}s.length,
      itemBuilder: (context, index) {
        final ${snakeCase} = ${className}s[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(${snakeCase}.name?.substring(0, 1).toUpperCase() ?? '?'),
            ),
            title: Text(${snakeCase}.name ?? 'Unknown'),
            subtitle: Text(_formatDate(${snakeCase}.createdAt)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onTap?.call(${snakeCase}),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '\${date.day}/\${date.month}/\${date.year}';
  }
}
''';
    
    await listWidgetFile.writeAsString(listContent);
  }
  
  static Future<void> generateFormWidget(String featureName, String className, String snakeCase, Directory widgetsDir) async {
    final formWidgetFile = File('${widgetsDir.path}/${snakeCase}_form_widget.dart');
    
    final formContent = '''import 'package:flutter/material.dart';
import '../../gen_models/models_library.dart';

class ${className}FormWidget extends StatefulWidget {
  final ${className}? ${snakeCase};
  final Function(${className})? onSubmit;

  const ${className}FormWidget({
    super.key,
    this.${snakeCase},
    this.onSubmit,
  });

  @override
  State<${className}FormWidget> createState() => _${className}FormWidgetState();
}

class _${className}FormWidgetState extends State<${className}FormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.${snakeCase}?.name);
    _emailController = TextEditingController(text: widget.${snakeCase}?.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updated${className} = (widget.${snakeCase} ?? ${className}()).copyWith(
                          name: _nameController.text,
                          email: _emailController.text,
                        );
                        widget.onSubmit?.call(updated${className});
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
    
    await formWidgetFile.writeAsString(formContent);
  }
}

void main() {
  RemainingUIComponentsGenerator.generateRemainingUIComponents();
}
