import 'dart:io';

/// Auto Repository Generator
/// Generates repository files based on auto-generated Prisma models
class RepositoryGenerator {
  final String modelsDir;
  final String repositoriesDir;
  final String template;

  RepositoryGenerator({
    required this.modelsDir,
    required this.repositoriesDir,
    required this.template,
  });

  Future<void> generateAll() async {
    print('🚀 Starting repository generation...');
    
    // Get all model files
    final modelsDirectory = Directory(modelsDir);
    if (!await modelsDirectory.exists()) {
      print('❌ Models directory not found: $modelsDir');
      return;
    }

    final modelFiles = await modelsDirectory
        .list()
        .where((entity) => 
            entity is File && 
            entity.path.endsWith('.dart') &&
            !_isEnumFile(entity.path))
        .cast<File>()
        .toList();

    print('📁 Found ${modelFiles.length} model files');

    // Ensure repositories directory exists
    final reposDirectory = Directory(repositoriesDir);
    if (!await reposDirectory.exists()) {
      await reposDirectory.create(recursive: true);
      print('📁 Created repositories directory: $repositoriesDir');
    }

    for (final modelFile in modelFiles) {
      await generateRepository(modelFile);
    }

    print('✅ Repository generation completed!');
  }

  Future<void> generateRepository(File modelFile) async {
    final modelName = _getModelName(modelFile.path);
    final className = _toPascalCase(modelName);
    final repositoryName = '${className}Repository';
    final fileName = '${modelName}_repository.dart';

    print('📝 Generating $fileName...');

    final content = template
        .replaceAll('{{CLASS_NAME}}', className)
        .replaceAll('{{REPOSITORY_NAME}}', repositoryName)
        .replaceAll('{{MODEL_NAME}}', modelName)
        .replaceAll('{{MODEL_NAME_CAMEL}}', _toCamelCase(modelName))
        .replaceAll('{{MODEL_NAME_PLURAL}}', _pluralize(modelName))
        .replaceAll('{{API_ENDPOINT}}', _getApiEndpoint(modelName));

    final repositoryFile = File('$repositoriesDir/$fileName');
    await repositoryFile.writeAsString(content);
  }

  bool _isEnumFile(String filePath) {
    final fileName = _getModelName(filePath);
    
    // Skip enum files based on naming patterns
    final enumPatterns = [
      r'_type$',      // account_type.dart
      r'_status$',    // booking_status.dart
      r'_tier$',      // loyalty_tier.dart
      r'_level$',     // permission_level.dart
      r'_key$',       // permission_key.dart
      r'_category$',  // campaign_category.dart
      r'_class$',     // building_class.dart
      r'_method$',    // payment_method.dart
      r'_scope$',     // management_fee_scope.dart
      r'_severity$',  // alert_severity.dart
      r'_priority$',  // task_priority.dart
      r'_stage$',     // deal_stage.dart
      r'_phase$',     // project_phase.dart
      r'_mode$',      // sync_mode.dart
      r'_format$',    // date_format.dart
      r'_style$',     // video_lora_style.dart
      r'_strategy$',  // pricing_strategy.dart
      r'_role$',      // member_role.dart
      r'_state$',     // connection_state.dart
      r'_u_s$',      // US-specific enums
      r'^us_',      // US-specific enums starting with us_
      r'^mls_',      // MLS-specific enums
    ];
    
    // Check if filename matches any enum pattern
    for (final pattern in enumPatterns) {
      if (RegExp(pattern, caseSensitive: false).hasMatch(fileName)) {
        return true;
      }
    }
    
    // Also check for common enum prefixes
    final enumPrefixes = [
      'contact_',
      'payment_',
      'listing_',
      'property_',
      'task_',
      'user_',
      'deal_',
      'lease_',
      'rental_',
      'mortgage_',
      'escrow_',
      'commission_',
      'notification_',
      'subscription_',
      'report_',
      'project_',
      'facility_',
      'amenity_',
      'channel_',
      'event_',
      'expense_',
      'earning_',
      'offer_',
      'review_',
      'ticket_',
      'unit_',
      'region_',
      'state_',
      'gender_',
      'language_',
      'currency_',
      'photo_',
      'video_',
      'document_',
      'contract_',
      'inspection_',
      'tax_',
      'mls_',
      'api_',
      'webhook_',
      'agent_',
      'location_',
      'map_',
      'route_',
      'exchange_',
      'export_',
      'government_',
      'lead_',
      'referral_',
      'maintenance_',
      'calendar_',
      'appointment_',
      'audit_',
      'automation_',
      'budget_',
      'dashboard_',
      'earning_',
      'event_',
      'favorite_',
      'hashtag_',
      'home_',
      'immigration_',
      'included_',
      'increase_',
      'api_integration',
      'api_key',
      'key_',
      'language_',
      'lease_',
      'ledger_',
      'loyalty_',
      'map_',
      'marketing_',
      'mention_',
      'mls_',
      'mobile_',
      'offline_',
      'org_',
      'performance_',
      'plan_',
      'predictive_',
      'pricing_',
      'project_',
      'property_',
      'queue_',
      'quote_',
      'recommendation_',
      'recording_',
      'recurring_',
      'reference_',
      'referral_',
      'rent_',
      'rental_',
      'report_',
      'reservation_',
      'right_',
      'role_',
      'route_',
      'scraping_',
      'security_',
      'session_',
      'shared_',
      'signature_',
      'social_',
      'solicitor_',
      'subscription_',
      'sync_',
      'system_',
      'tag_',
      'task_',
      'tenant_',
      'vacation_',
      'vendor_',
      'verification_',
      'video_',
      'virtual_',
      'webhook_',
      'work_',
    ];
    
    // Check for enum prefixes with type/status patterns
    for (final prefix in enumPrefixes) {
      if (fileName.startsWith(prefix) && 
          (fileName.endsWith('_type') || fileName.endsWith('_status') || fileName.endsWith('_tier') || fileName.endsWith('_level') || fileName.endsWith('_key') || fileName.endsWith('_category') || fileName.endsWith('_class') || fileName.endsWith('_method') || fileName.endsWith('_scope') || fileName.endsWith('_severity') || fileName.endsWith('_priority') || fileName.endsWith('_stage') || fileName.endsWith('_phase') || fileName.endsWith('_mode') || fileName.endsWith('_format') || fileName.endsWith('_style') || fileName.endsWith('_strategy') || fileName.endsWith('_role') || fileName.endsWith('_state'))) {
        return true;
      }
    }
    
    return false;
  }

  String _getModelName(String filePath) {
    final fileName = filePath.split('/').last;
    return fileName.replaceAll('.dart', '');
  }

  String _toPascalCase(String input) {
    return input
        .split('_')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join('');
  }

  String _toCamelCase(String input) {
    final pascal = _toPascalCase(input);
    return pascal.isEmpty ? '' : pascal[0].toLowerCase() + pascal.substring(1);
  }

  String _pluralize(String input) {
    // Simple pluralization - can be enhanced
    if (input.endsWith('y')) {
      return '${input.substring(0, input.length - 1)}ies';
    } else if (input.endsWith('s') || input.endsWith('sh') || input.endsWith('ch')) {
      return '${input}es';
    } else {
      return '${input}s';
    }
  }

  String _getApiEndpoint(String modelName) {
    // Convert model name to kebab-case for API endpoints
    return modelName.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return '-${match.group(0)!.toLowerCase()}';
    }).replaceAll(RegExp(r'^-'), '');
  }
}

void main() async {
  const template = '''
import 'package:dio/dio.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/models.dart';

/// Repository for {{CLASS_NAME}} operations
/// Provides CRUD operations with proper error handling and type safety
class {{REPOSITORY_NAME}} {
  final DioClient _dioClient;

  {{REPOSITORY_NAME}}(this._dioClient);

  /// Get {{CLASS_NAME}} by ID
  /// Returns [{{CLASS_NAME}}] if found, throws [RepositoryException] otherwise
  Future<{{CLASS_NAME}}> get{{CLASS_NAME}}ById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/{{API_ENDPOINT}}/\$id');
      if (response.statusCode == 200) {
        return {{CLASS_NAME}}.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch {{MODEL_NAME}}',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all {{MODEL_NAME_PLURAL}} with pagination and filtering
  /// Returns list of [{{CLASS_NAME}}] objects
  Future<List<{{CLASS_NAME}}>> get{{MODEL_NAME_PLURAL}}({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/{{API_ENDPOINT}}', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => {{CLASS_NAME}}.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch {{MODEL_NAME_PLURAL}}',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new {{CLASS_NAME}}
  /// Returns created [{{CLASS_NAME}}] object
  Future<{{CLASS_NAME}}> create{{CLASS_NAME}}({{CLASS_NAME}} {{MODEL_NAME_CAMEL}}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/{{API_ENDPOINT}}',
        data: {{MODEL_NAME_CAMEL}}.toJson(),
      );
      return {{CLASS_NAME}}.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update {{CLASS_NAME}}
  Future<{{CLASS_NAME}}> update{{CLASS_NAME}}(String id, {{CLASS_NAME}} {{MODEL_NAME_CAMEL}}) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/{{API_ENDPOINT}}/\$id',
        data: {{MODEL_NAME_CAMEL}}.toJson(),
      );
      return {{CLASS_NAME}}.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete {{CLASS_NAME}}
  Future<void> delete{{CLASS_NAME}}(String id) async {
    try {
      await _dioClient.delete('/api/v1/{{API_ENDPOINT}}/\$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API error: \${e.message}');
  }
}
''';

  final generator = RepositoryGenerator(
    modelsDir: 'lib/gen_models/models',
    repositoriesDir: 'lib/repositories',
    template: template,
  );

  await generator.generateAll();
}
