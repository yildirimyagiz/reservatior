// ignore_for_file: uri_does_not_exist, unused_import
import 'dart:io'; 
import 'package:easy_localization/easy_localization.dart';

class RepositoryImplGenerator {
  static Future<void> generateAllRepositoryImpls() async {
    final modelsDir = Directory('/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/models');
    
    if (!await modelsDir.exists()) {
      print('Models directory not found');
      return;
    }
    
    // Clear existing repository implementations
    await clearAllRepositoryImpls();
    
    final modelFiles = await modelsDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart')
    ).cast<File>().toList();
    
    print('Found ${modelFiles.length} model files');
    
    for (final file in modelFiles) {
      final fileName = file.path.split('/').last;
      final modelName = fileName.replaceAll('.dart', '');
      
      await generateRepositoryImpl(modelName);
      print('Generated repository implementation for: $modelName');
    }
    
    print('Repository implementation generation completed!');
  }
  
  static Future<void> clearAllRepositoryImpls() async {
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/features');
    
    if (await featuresDir.exists()) {
      await for (final entity in featuresDir.list()) {
        if (entity is Directory) {
          final repositoriesDir = Directory('${entity.path}/data/repositories');
          if (await repositoriesDir.exists()) {
            await repositoriesDir.delete(recursive: true);
          }
        }
      }
    }
  }
  
  static Future<void> generateRepositoryImpl(String modelName) async {
    // Convert snake_case to CamelCase properly
    final className = modelName.split('_').map((part) => 
      part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1)
    ).join('');
    
    final snakeCase = modelName;
    final featureName = snakeCase.replaceAll('_', '');
    
    final featuresDir = Directory('/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/features/$featureName');
    final dataDir = Directory('${featuresDir.path}/data');
    final repositoriesDir = Directory('${dataDir.path}/repositories');
    
    // Create directories
    if (!await featuresDir.exists()) {
      await featuresDir.create(recursive: true);
    }
    if (!await dataDir.exists()) {
      await dataDir.create(recursive: true);
    }
    if (!await repositoriesDir.exists()) {
      await repositoriesDir.create(recursive: true);
    }
    
    // Generate repository implementation
    await generateRepositoryImplFile(modelName, className, snakeCase, repositoriesDir);
  }
  
  static Future<void> generateRepositoryImplFile(String modelName, String className, String snakeCase, Directory repositoriesDir) async {
    final repositoryImplFile = File('${repositoriesDir.path}/${snakeCase}_repository_impl.dart');
    
    final repositoryImplContent = '''mobile.leftovers.import'.tr()../../../../repositories/${snakeCase}_repository.dart';
import 'package:reservatior/datasources/${snakeCase}_remote_datasource.dart';
import 'package:reservatior/datasources/${snakeCase}_local_datasource.dart';

class ${className}RepositoryImpl extends ${className}Repository {
  final ${className}RemoteDataSource _remoteDataSource;
  final ${className}LocalDataSource _localDataSource;

  ${className}RepositoryImpl({
    required ${className}RemoteDataSource remoteDataSource,
    required ${className}LocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<${className}> get${className}ById(String id) async {
    try {
      return await _remoteDataSource.get${className}ById(id);
    } catch (e) {
      // Fallback to local datasource if needed
      try {
        return await _localDataSource.get${className}ById(id);
      } catch (localError) {
        throw Exception('Failed to get ${className}: \$e');
      }
    }
  }

  @override
  Future<List<${className}>> get${className}s({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      return await _remoteDataSource.get${className}s(
        page: page,
        limit: limit,
        filters: filters,
      );
    } catch (e) {
      // Fallback to local datasource if needed
      try {
        return await _localDataSource.get${className}s(
          limit: limit,
          offset: (page - 1) * limit,
        );
      } catch (localError) {
        throw Exception('Failed to get ${className}s: \$e');
      }
    }
  }

  @override
  Future<${className}> create${className}(${className} ${snakeCase}) async {
    try {
      final result = await _remoteDataSource.create${className}(${snakeCase});
      
      // Cache locally
      try {
        await _localDataSource.create${className}(result);
      } catch (localError) {
        // Ignore local caching errors
      }
      
      return result;
    } catch (e) {
      throw Exception('Failed to create ${className}: \$e');
    }
  }

  @override
  Future<${className}> update${className}(String id, ${className} ${snakeCase}) async {
    try {
      final result = await _remoteDataSource.update${className}(id, ${snakeCase});
      
      // Update local cache
      try {
        await _localDataSource.update${className}(result);
      } catch (localError) {
        // Ignore local caching errors
      }
      
      return result;
    } catch (e) {
      throw Exception('Failed to update ${className}: \$e');
    }
  }

  @override
  Future<void> delete${className}(String id) async {
    try {
      await _remoteDataSource.delete${className}(id);
      
      // Remove from local cache
      try {
        await _localDataSource.delete${className}(id);
      } catch (localError) {
        // Ignore local caching errors
      }
    } catch (e) {
      throw Exception('Failed to delete ${className}: \$e');
    }
  }
}
''';
    
    await repositoryImplFile.writeAsString(repositoryImplContent);
  }
}

void main() {
  RepositoryImplGenerator.generateAllRepositoryImpls();
}
