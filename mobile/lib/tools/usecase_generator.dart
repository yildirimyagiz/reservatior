import 'dart:io';

class UseCaseGenerator {
  static Future<void> regenerateAllUseCases() async {
    final modelsDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/gen_models/models');
    final useCasesDir = Directory('/Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/core/usecases');
    
    if (!await modelsDir.exists()) {
      print('Models directory not found');
      return;
    }
    
    if (!await useCasesDir.exists()) {
      await useCasesDir.create(recursive: true);
    }
    
    final modelFiles = await modelsDir.list().where((entity) => 
      entity is File && entity.path.endsWith('.dart')
    ).cast<File>().toList();
    
    print('Found ${modelFiles.length} model files');
    
    for (final file in modelFiles) {
      final fileName = file.path.split('/').last;
      final modelName = fileName.replaceAll('.dart', '');
      
      final useCaseFile = File('${useCasesDir.path}/${modelName}_usecase.dart');
      await generateUseCase(modelName, useCaseFile);
      print('Generated usecase: ${modelName}_usecase.dart');
    }
    
    print('UseCase generation completed!');
  }
  
  static Future<void> generateUseCase(String modelName, File outputFile) async {
    // Convert snake_case to CamelCase properly
    final className = modelName.split('_').map((part) => 
      part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1)
    ).join('');
    
    final snakeCase = modelName;
    final camelCaseVar = modelName.split('_').map((part) => 
      part.isEmpty ? '' : (part == modelName.split('_').first ? part : part[0].toUpperCase() + part.substring(1))
    ).join('');
    
    final useCaseContent = '''import '../services/${snakeCase}_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ${className}

class Get${className}ByIdUseCase {
  final ${className}Service _service;
  
  Get${className}ByIdUseCase(this._service);
  
  Future<${className}> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.get${className}ById(id);
  }
}

class Get${className}sUseCase {
  final ${className}Service _service;
  
  Get${className}sUseCase(this._service);
  
  Future<List<${className}>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.get${className}s(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class Create${className}UseCase {
  final ${className}Service _service;
  
  Create${className}UseCase(this._service);
  
  Future<${className}> execute(${className} ${camelCaseVar}) async {
    // Add validation logic here
    return await _service.create${className}(${camelCaseVar});
  }
}

class Update${className}UseCase {
  final ${className}Service _service;
  
  Update${className}UseCase(this._service);
  
  Future<${className}> execute(String id, ${className} ${camelCaseVar}) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update${className}(id, ${camelCaseVar});
  }
}

class Delete${className}UseCase {
  final ${className}Service _service;
  
  Delete${className}UseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete${className}(id);
  }
}

// ${className} Use Case Container
class ${className}UseCases {
  final Get${className}ByIdUseCase getById;
  final Get${className}sUseCase getAll;
  final Create${className}UseCase create;
  final Update${className}UseCase update;
  final Delete${className}UseCase delete;
  
  ${className}UseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ${className}UseCases.create(${className}Service service) {
    return ${className}UseCases(
      getById: Get${className}ByIdUseCase(service),
      getAll: Get${className}sUseCase(service),
      create: Create${className}UseCase(service),
      update: Update${className}UseCase(service),
      delete: Delete${className}UseCase(service),
    );
  }
}
''';
    
    await outputFile.writeAsString(useCaseContent);
  }
}

void main() {
  UseCaseGenerator.regenerateAllUseCases();
}
