import 'dart:io';

class DatasourcesGenerator {
  static Future<void> regenerateAllDatasources() async {
    final modelsDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/gen_models/models');
    
    if (!await modelsDir.exists()) {
      print('Models directory not found');
      return;
    }
    
    // Clear existing datasources
    await clearAllDatasources();
    
    final modelFiles = await modelsDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart')
    ).cast<File>().toList();
    
    print('Found ${modelFiles.length} model files');
    
    for (final file in modelFiles) {
      final fileName = file.path.split('/').last;
      final modelName = fileName.replaceAll('.dart', '');
      
      await generateFeatureDatasources(modelName);
      print('Generated datasources for: $modelName');
    }
    
    print('Datasource generation completed!');
  }
  
  static Future<void> clearAllDatasources() async {
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/features');
    
    if (await featuresDir.exists()) {
      await for (final entity in featuresDir.list()) {
        if (entity is Directory) {
          final datasourcesDir = Directory('${entity.path}/data/datasources');
          if (await datasourcesDir.exists()) {
            await datasourcesDir.delete(recursive: true);
          }
        }
      }
    }
  }
  
  static Future<void> generateFeatureDatasources(String modelName) async {
    // Convert snake_case to CamelCase properly
    final className = modelName.split('_').map((part) => 
      part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1)
    ).join('');
    
    final snakeCase = modelName;
    final featureName = snakeCase.replaceAll('_', '');
    
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/features/$featureName');
    final dataDir = Directory('${featuresDir.path}/data');
    final datasourcesDir = Directory('${dataDir.path}/datasources');
    
    // Create directories
    if (!await featuresDir.exists()) {
      await featuresDir.create(recursive: true);
    }
    if (!await dataDir.exists()) {
      await dataDir.create(recursive: true);
    }
    if (!await datasourcesDir.exists()) {
      await datasourcesDir.create(recursive: true);
    }
    
    // Generate remote datasource
    await generateRemoteDatasource(modelName, className, snakeCase, datasourcesDir);
    
    // Generate local datasource  
    await generateLocalDatasource(modelName, className, snakeCase, datasourcesDir);
  }
  
  static Future<void> generateRemoteDatasource(String modelName, String className, String snakeCase, Directory datasourcesDir) async {
    final remoteDatasourceFile = File('${datasourcesDir.path}/${snakeCase}_remote_datasource.dart');
    
    final remoteContent = '''import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../gen_models/models_library.dart';

abstract class ${className}RemoteDataSource {
  Future<${className}> get${className}ById(String id);
  Future<List<${className}>> get${className}s({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  });
  Future<${className}> create${className}(${className} ${snakeCase});
  Future<${className}> update${className}(String id, ${className} ${snakeCase});
  Future<void> delete${className}(String id);
}

class ${className}RemoteDataSourceImpl implements ${className}RemoteDataSource {
  final DioClient _dioClient;

  ${className}RemoteDataSourceImpl(this._dioClient);

  @override
  Future<${className}> get${className}ById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/${snakeCase}/\$id');
      return ${className}.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<${className}>> get${className}s({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/${snakeCase}', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ${className}.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<${className}> create${className}(${className} ${snakeCase}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/${snakeCase}',
        data: ${snakeCase}.toJson(),
      );
      return ${className}.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<${className}> update${className}(String id, ${className} ${snakeCase}) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/${snakeCase}/\$id',
        data: ${snakeCase}.toJson(),
      );
      return ${className}.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> delete${className}(String id) async {
    try {
      await _dioClient.delete('/api/v1/${snakeCase}/\$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: \${e.message}');
  }
}
''';
    
    await remoteDatasourceFile.writeAsString(remoteContent);
  }
  
  static Future<void> generateLocalDatasource(String modelName, String className, String snakeCase, Directory datasourcesDir) async {
    final localDatasourceFile = File('${datasourcesDir.path}/${snakeCase}_local_datasource.dart');
    
    final localContent = '''// Note: This is a template for local datasource
// Uncomment and implement when you need local storage
// import 'package:sqflite/sqflite.dart';
import '../../../../gen_models/models_library.dart';

abstract class ${className}LocalDataSource {
  Future<${className}> get${className}ById(String id);
  Future<List<${className}>> get${className}s({int? limit, int? offset});
  Future<${className}> create${className}(${className} ${snakeCase});
  Future<${className}> update${className}(${className} ${snakeCase});
  Future<void> delete${className}(String id);
  Future<void> clearAll();
}

class ${className}LocalDataSourceImpl implements ${className}LocalDataSource {
  // final Database _database;
  
  ${className}LocalDataSourceImpl(/* this._database */);

  @override
  Future<${className}> get${className}ById(String id) async {
    // TODO: Implement local data retrieval
    throw UnimplementedError('Local datasource not implemented yet');
  }

  @override
  Future<List<${className}>> get${className}s({int? limit, int? offset}) async {
    // TODO: Implement local data retrieval
    throw UnimplementedError('Local datasource not implemented yet');
  }

  @override
  Future<${className}> create${className}(${className} ${snakeCase}) async {
    // TODO: Implement local data creation
    throw UnimplementedError('Local datasource not implemented yet');
  }

  @override
  Future<${className}> update${className}(${className} ${snakeCase}) async {
    // TODO: Implement local data update
    throw UnimplementedError('Local datasource not implemented yet');
  }

  @override
  Future<void> delete${className}(String id) async {
    // TODO: Implement local data deletion
    throw UnimplementedError('Local datasource not implemented yet');
  }

  @override
  Future<void> clearAll() async {
    // TODO: Implement local data clearing
    throw UnimplementedError('Local datasource not implemented yet');
  }
}
''';
    
    await localDatasourceFile.writeAsString(localContent);
  }
}

void main() {
  DatasourcesGenerator.regenerateAllDatasources();
}
