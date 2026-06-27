import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/contact_service.dart';
import 'package:reservatior/shared/repositories/contact_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final contactServiceProvider = Provider<ContactService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContactService(dioClient);
});

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final service = ref.watch(contactServiceProvider);
  return ContactRepositoryImpl(service);
});

final contactListProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  final repository = ref.watch(contactRepositoryProvider);
  return repository.getAll();
});

final contactCreateProvider = StateProvider<Contact?>((ref) => null);
final contactUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final contactDeleteProvider = StateProvider<String?>((ref) => null);
final contactLoadingProvider = StateProvider<bool>((ref) => false);
