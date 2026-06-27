import os
import re

def to_camel_case(snake_str):
    if snake_str == 'models': return 'appModels'
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def get_class_name(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        match = re.search(r'class\s+([A-Za-z0-9_]+)', content)
        if match:
            return match.group(1)
    return None

def regenerate_all(model_mappings, base_path):
    services_dir = os.path.join(base_path, "lib/shared/services")
    repos_dir = os.path.join(base_path, "lib/shared/repositories")
    usecases_dir = os.path.join(base_path, "lib/core/usecases")
    providers_dir = os.path.join(base_path, "lib/shared/providers")
    
    os.makedirs(services_dir, exist_ok=True)
    os.makedirs(repos_dir, exist_ok=True)
    os.makedirs(usecases_dir, exist_ok=True)
    os.makedirs(providers_dir, exist_ok=True)

    for snake, class_name in model_mappings.items():
        camel = to_camel_case(snake)
        # Service
        service_content = f"""import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/models.dart';

class {class_name}Service {{
  final DioClient _dioClient;
  {class_name}Service(this._dioClient);

  Future<{class_name}> get{class_name}ById(String id) async {{
    final response = await _dioClient.get('/api/v1/{snake}/$id');
    return {class_name}.fromJson(response.data['data']);
  }}

  Future<List<{class_name}>> get{class_name}s({{
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }}) async {{
    final queryParams = {{
      'page': page, 
      'limit': limit,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    }};
    final response = await _dioClient.get('/api/v1/{snake}', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => {class_name}.fromJson(json)).toList();
  }}

  Future<{class_name}> create{class_name}({class_name} item) async {{
    final response = await _dioClient.post('/api/v1/{snake}', data: item.toJson());
    return {class_name}.fromJson(response.data['data']);
  }}

  Future<{class_name}> update{class_name}(String id, {class_name} item) async {{
    final response = await _dioClient.put('/api/v1/{snake}/$id', data: item.toJson());
    return {class_name}.fromJson(response.data['data']);
  }}

  Future<void> delete{class_name}(String id) async {{
    await _dioClient.delete('/api/v1/{snake}/$id');
  }}
}}
"""
        # Repository
        repo_content = f"""import '../models/models.dart';
import '../services/{snake}_service.dart';

abstract class {class_name}Repository {{
  Future<{class_name}> getById(String id);
  Future<List<{class_name}>> getAll({{
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }});
  Future<{class_name}> create({class_name} item);
  Future<{class_name}> update(String id, {class_name} item);
  Future<void> delete(String id);
}}

class {class_name}RepositoryImpl implements {class_name}Repository {{
  final {class_name}Service _service;
  {class_name}RepositoryImpl(this._service);

  @override
  Future<{class_name}> getById(String id) => _service.get{class_name}ById(id);

  @override
  Future<List<{class_name}>> getAll({{
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }}) => _service.get{class_name}s(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );

  @override
  Future<{class_name}> create({class_name} item) => _service.create{class_name}(item);

  @override
  Future<{class_name}> update(String id, {class_name} item) => _service.update{class_name}(id, item);

  @override
  Future<void> delete(String id) => _service.delete{class_name}(id);
}}
"""
        # Usecase
        usecase_content = f"""import 'package:reservatior/shared/repositories/{snake}_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class Get{class_name}ByIdUseCase {{
  final {class_name}Repository _repository;
  Get{class_name}ByIdUseCase(this._repository);
  Future<{class_name}> execute(String id) => _repository.getById(id);
}}

class Get{class_name}sUseCase {{
  final {class_name}Repository _repository;
  Get{class_name}sUseCase(this._repository);
  Future<List<{class_name}>> execute({{
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }}) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}}

class Create{class_name}UseCase {{
  final {class_name}Repository _repository;
  Create{class_name}UseCase(this._repository);
  Future<{class_name}> execute({class_name} item) => _repository.create(item);
}}

class Update{class_name}UseCase {{
  final {class_name}Repository _repository;
  Update{class_name}UseCase(this._repository);
  Future<{class_name}> execute(String id, {class_name} item) => _repository.update(id, item);
}}

class Delete{class_name}UseCase {{
  final {class_name}Repository _repository;
  Delete{class_name}UseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}}
"""
        # Provider
        provider_content = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/{snake}_service.dart';
import '../repositories/{snake}_repository.dart';
import '../models/models.dart';
import 'dio_client_provider.dart';

final {camel}ServiceProvider = Provider<{class_name}Service>((ref) {{
  final dioClient = ref.watch(dioClientProvider);
  return {class_name}Service(dioClient);
}});

final {camel}RepositoryProvider = Provider<{class_name}Repository>((ref) {{
  final service = ref.watch({camel}ServiceProvider);
  return {class_name}RepositoryImpl(service);
}});

final {camel}ListProvider = FutureProvider.autoDispose<List<{class_name}>>((ref) async {{
  final repository = ref.watch({camel}RepositoryProvider);
  return repository.getAll();
}});

final {camel}CreateProvider = StateProvider<{class_name}?>((ref) => null);
final {camel}UpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {{}});
final {camel}DeleteProvider = StateProvider<String?>((ref) => null);
final {camel}LoadingProvider = StateProvider<bool>((ref) => false);
"""
        with open(os.path.join(services_dir, f"{snake}_service.dart"), "w") as out: out.write(service_content)
        with open(os.path.join(repos_dir, f"{snake}_repository.dart"), "w") as out: out.write(repo_content)
        with open(os.path.join(usecases_dir, f"{snake}_usecase.dart"), "w") as out: out.write(usecase_content)
        with open(os.path.join(providers_dir, f"{snake}_provider.dart"), "w") as out: out.write(provider_content)

if __name__ == "__main__":
    base_path = "/Users/os2026/Downloads/echosystem/reservatiormain/mobile"
    models_root = os.path.join(base_path, "lib/shared/models")
    model_mappings = {}
    for f in os.listdir(models_root):
        if f.endswith(".dart") and f != "models.dart":
            snake = f.replace(".dart", "")
            class_name = get_class_name(os.path.join(models_root, f))
            if class_name:
                model_mappings[snake] = class_name
    
    print(f"ULTRA STANDARDIZING {len(model_mappings)} features with CAMELCASE providers...")
    regenerate_all(model_mappings, base_path)
    print("ULTRA STANDARDIZATION completed!")
