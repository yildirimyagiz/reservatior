import os
import re

MODELS_DIR = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/models'
SERVICES_DIR = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/services'
PROVIDERS_DIR = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/providers'
REPOS_DIR = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/shared/repositories'
FEATURES_DIR = '/Users/os2026/Downloads/echosystem/reservatiormain/mobile/lib/features'

SERVICE_TEMPLATE = """import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/models.dart';

class {CLASS_NAME}Service {{
  final DioClient _dioClient;
  {CLASS_NAME}Service(this._dioClient);

  Future<{CLASS_NAME}> get{CLASS_NAME}ById(String id) async {{
    final response = await _dioClient.get('/api/v1/{SNAKE_CASE}/$id');
    return {CLASS_NAME}.fromJson(response.data['data']);
  }}

  Future<List<{CLASS_NAME}>> get{CLASS_NAME}s({{int page = 1, int limit = 20}}) async {{
    final response = await _dioClient.get('/api/v1/{SNAKE_CASE}', queryParameters: {{'page': page, 'limit': limit}});
    final data = response.data['data'] as List;
    return data.map((json) => {CLASS_NAME}.fromJson(json)).toList();
  }}

  Future<{CLASS_NAME}> create{CLASS_NAME}({CLASS_NAME} item) async {{
    final response = await _dioClient.post('/api/v1/{SNAKE_CASE}', data: item.toJson());
    return {CLASS_NAME}.fromJson(response.data['data']);
  }}

  Future<{CLASS_NAME}> update{CLASS_NAME}(String id, {CLASS_NAME} item) async {{
    final response = await _dioClient.put('/api/v1/{SNAKE_CASE}/$id', data: item.toJson());
    return {CLASS_NAME}.fromJson(response.data['data']);
  }}

  Future<void> delete{CLASS_NAME}(String id) async {{
    await _dioClient.delete('/api/v1/{SNAKE_CASE}/$id');
  }}
}}
"""

PROVIDER_TEMPLATE = """import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/{SNAKE_CASE}_service.dart';
import '../models/models.dart';
import 'dio_client_provider.dart';

final {SNAKE_CASE}ServiceProvider = Provider<{CLASS_NAME}Service>((ref) {{
  final dioClient = ref.watch(dioClientProvider);
  return {CLASS_NAME}Service(dioClient);
}});

final {SNAKE_CASE}listProvider = FutureProvider.autoDispose<List<{CLASS_NAME}>>((ref) async {{
  final service = ref.watch({SNAKE_CASE}ServiceProvider);
  return service.get{CLASS_NAME}s();
}});

final {SNAKE_CASE}createProvider = StateProvider<{CLASS_NAME}?>((ref) => null);
final {SNAKE_CASE}updateProvider = StateProvider<Map<String, dynamic>>((ref) => {{}});
final {SNAKE_CASE}deleteProvider = StateProvider<String?>((ref) => null);
final {SNAKE_CASE}loadingProvider = StateProvider<bool>((ref) => false);
"""

REPO_INTERFACE_TEMPLATE = """import '../models/models.dart';

abstract class {CLASS_NAME}Repository {{
  Future<{CLASS_NAME}> get{CLASS_NAME}ById(String id);
  Future<List<{CLASS_NAME}>> get{CLASS_NAME}s({{int page = 1, int limit = 20, Map<String, dynamic>? filters}});
  Future<{CLASS_NAME}> create{CLASS_NAME}({CLASS_NAME} item);
  Future<{CLASS_NAME}> update{CLASS_NAME}(String id, {CLASS_NAME} item);
  Future<void> delete{CLASS_NAME}(String id);
}}
"""

def to_camel_case(snake_str):
    return "".join(x.title() for x in snake_str.split('_'))

def architect():
    os.makedirs(SERVICES_DIR, exist_ok=True)
    os.makedirs(PROVIDERS_DIR, exist_ok=True)
    os.makedirs(REPOS_DIR, exist_ok=True)

    for f in os.listdir(MODELS_DIR):
        if not f.endswith('.dart') or f == 'models.dart': continue
        
        snake_case = f.replace('.dart', '')
        class_name = to_camel_case(snake_case)
        
        # Shared Service
        with open(os.path.join(SERVICES_DIR, f'{snake_case}_service.dart'), 'w') as out:
            out.write(SERVICE_TEMPLATE.format(CLASS_NAME=class_name, SNAKE_CASE=snake_case))
        
        # Shared Provider
        with open(os.path.join(PROVIDERS_DIR, f'{snake_case}_provider.dart'), 'w') as out:
            out.write(PROVIDER_TEMPLATE.format(CLASS_NAME=class_name, SNAKE_CASE=snake_case))
            
        # Shared Repository Interface
        with open(os.path.join(REPOS_DIR, f'{snake_case}_repository.dart'), 'w') as out:
            out.write(REPO_INTERFACE_TEMPLATE.format(CLASS_NAME=class_name))

        print(f'Architected Shared Layer for: {class_name}')

if __name__ == '__main__':
    architect()
