import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tax1099_form_service.dart';
import 'package:reservatior/shared/repositories/tax1099_form_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final tax1099FormServiceProvider = Provider<Tax1099FormService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return Tax1099FormService(dioClient);
});

final tax1099FormRepositoryProvider = Provider<Tax1099FormRepository>((ref) {
  final service = ref.watch(tax1099FormServiceProvider);
  return Tax1099FormRepositoryImpl(service);
});

final tax1099FormListProvider = FutureProvider.autoDispose<List<Tax1099Form>>((ref) async {
  final repository = ref.watch(tax1099FormRepositoryProvider);
  return repository.getAll();
});

final tax1099FormCreateProvider = StateProvider<Tax1099Form?>((ref) => null);
final tax1099FormUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final tax1099FormDeleteProvider = StateProvider<String?>((ref) => null);
final tax1099FormLoadingProvider = StateProvider<bool>((ref) => false);
